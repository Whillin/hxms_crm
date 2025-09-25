package co.yixiang.yshop.framework.security.config;

import cn.hutool.core.collection.CollUtil;
import co.yixiang.yshop.framework.security.core.filter.TokenAuthenticationFilter;
import co.yixiang.yshop.framework.security.core.aop.PreAuthenticatedAspect;
import co.yixiang.yshop.framework.security.core.context.TransmittableThreadLocalSecurityContextHolderStrategy;
import co.yixiang.yshop.framework.security.core.service.SecurityFrameworkService;
import co.yixiang.yshop.framework.security.core.service.SecurityFrameworkServiceImpl;
import co.yixiang.yshop.framework.security.core.handler.AccessDeniedHandlerImpl;
import co.yixiang.yshop.framework.security.core.handler.AuthenticationEntryPointImpl;
import co.yixiang.yshop.framework.web.core.handler.GlobalExceptionHandler;
import co.yixiang.yshop.module.system.api.oauth2.OAuth2TokenApi;
import co.yixiang.yshop.module.system.api.permission.PermissionApi;
import org.springframework.beans.factory.config.MethodInvokingFactoryBean;
import org.springframework.security.crypto.bcrypt.BCryptPasswordEncoder;
import org.springframework.security.crypto.password.PasswordEncoder;
import org.springframework.security.core.context.SecurityContextHolder;
import co.yixiang.yshop.framework.web.config.WebProperties;
import com.google.common.collect.HashMultimap;
import com.google.common.collect.Multimap;
import jakarta.annotation.Resource;
import jakarta.annotation.security.PermitAll;
import lombok.extern.slf4j.Slf4j;
import org.springframework.boot.autoconfigure.AutoConfiguration;
import org.springframework.boot.autoconfigure.AutoConfigureOrder;
import org.springframework.boot.autoconfigure.condition.ConditionalOnWebApplication;
import org.springframework.context.ApplicationContext;
import org.springframework.context.annotation.Bean;
import org.springframework.context.annotation.Configuration;
import org.springframework.http.HttpMethod;
import org.springframework.security.authentication.AuthenticationManager;
import org.springframework.security.config.Customizer;
import org.springframework.security.config.annotation.authentication.configuration.AuthenticationConfiguration;
import org.springframework.security.config.annotation.method.configuration.EnableMethodSecurity;
import org.springframework.security.config.annotation.web.configuration.EnableWebSecurity;
import org.springframework.security.config.annotation.web.builders.HttpSecurity;
import org.springframework.security.config.annotation.web.configurers.AbstractHttpConfigurer;
import org.springframework.security.config.annotation.web.configurers.HeadersConfigurer;
import org.springframework.security.config.http.SessionCreationPolicy;
import org.springframework.security.web.AuthenticationEntryPoint;
import org.springframework.security.web.SecurityFilterChain;
import org.springframework.security.web.access.AccessDeniedHandler;
import org.springframework.security.web.authentication.UsernamePasswordAuthenticationFilter;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.method.HandlerMethod;
import org.springframework.web.servlet.mvc.method.RequestMappingInfo;
import org.springframework.web.servlet.mvc.method.annotation.RequestMappingHandlerMapping;
import org.springframework.web.util.pattern.PathPattern;

import java.util.HashSet;
import java.util.List;
import java.util.Map;
import java.util.Set;

import static co.yixiang.yshop.framework.common.util.collection.CollectionUtils.convertList;

/**
 * 自定义的 Spring Security 配置适配器实现
 *
 * @author yshop
 */
@AutoConfiguration // 改为@AutoConfiguration注解以确保被Spring Boot自动加载
@AutoConfigureOrder(-1) // 目的：先于 Spring Security 自动配置，避免一键改包后，org.* 基础包无法生效
@ConditionalOnWebApplication(type = ConditionalOnWebApplication.Type.SERVLET) // 重新启用条件注解
@EnableMethodSecurity(securedEnabled = true)
@EnableWebSecurity // 添加@EnableWebSecurity注解
@Slf4j
public class YshopWebSecurityConfigurerAdapter {

    static {
        System.out.println("=== YshopWebSecurityConfigurerAdapter 类被加载 ===");
        System.out.println("当前应用类型: " + org.springframework.boot.web.servlet.context.ServletWebServerApplicationContext.class.getName());
        System.out.println("ConditionalOnWebApplication 条件检查...");
    }

    @Resource
    private WebProperties webProperties;
    @Resource
    private SecurityProperties securityProperties;

    // 移除循环依赖的@Resource注入，改为在方法中直接创建

    /**
     * 自定义的权限映射 Bean 们
     *
     * @see #filterChain(HttpSecurity)
     */
    @Resource
    private List<AuthorizeRequestsCustomizer> authorizeRequestsCustomizers;

    @Resource
    private ApplicationContext applicationContext;

    public YshopWebSecurityConfigurerAdapter() {
        System.out.println("=== YshopWebSecurityConfigurerAdapter 构造函数被调用 ===");
        log.info("YshopWebSecurityConfigurerAdapter 构造函数被调用");
    }

    // 移除重复的Bean定义，这些Bean已经在YshopSecurityAutoConfiguration中定义了
    // 避免Bean重复定义导致的冲突

    /**
     * 由于 Spring Security 创建 AuthenticationManager 对象时，没声明 @Bean 注解，导致无法被注入
     * 通过覆写父类的该方法，添加 @Bean 注解，解决该问题
     */
    @Bean
    public AuthenticationManager authenticationManagerBean(AuthenticationConfiguration authenticationConfiguration) throws Exception {
        return authenticationConfiguration.getAuthenticationManager();
    }

    /**
     * 配置 URL 的安全配置
     *
     * anyRequest          |   匹配所有请求路径
     * access              |   SpringEl表达式结果为true时可以访问
     * anonymous           |   匿名可以访问
     * denyAll             |   用户不能访问
     * fullyAuthenticated  |   用户完全认证可以访问（非remember-me下自动登录）
     * hasAnyAuthority     |   如果有参数，参数表示权限，则其中任何一个权限可以访问
     * hasAnyRole          |   如果有参数，参数表示角色，则其中任何一个角色可以访问
     * hasAuthority        |   如果有参数，参数表示权限，则其权限可以访问
     * hasIpAddress        |   如果有参数，参数表示IP地址，如果用户IP和参数匹配，则可以访问
     * hasRole             |   如果有参数，参数表示角色，则其角色可以访问
     * permitAll           |   用户可以任意访问
     * rememberMe          |   允许通过remember-me登录的用户访问
     * authenticated       |   用户登录后可访问
     */
    @Bean
    public SecurityFilterChain filterChain(HttpSecurity httpSecurity,
                                           GlobalExceptionHandler globalExceptionHandler,
                                           OAuth2TokenApi oauth2TokenApi) throws Exception {
        log.info("YshopWebSecurityConfigurerAdapter - 开始配置 SecurityFilterChain...");
        // 登出
        httpSecurity
                // 开启跨域
                .cors(Customizer.withDefaults())
                // CSRF 禁用，因为不使用 Session
                .csrf(AbstractHttpConfigurer::disable)
                // 基于 token 机制，所以不需要 Session
                .sessionManagement(c -> c.sessionCreationPolicy(SessionCreationPolicy.STATELESS))
                .headers(c -> c.frameOptions(HeadersConfigurer.FrameOptionsConfig::disable))
                // 一堆自定义的 Spring Security 处理器
                .exceptionHandling(c -> c.authenticationEntryPoint(applicationContext.getBean(AuthenticationEntryPoint.class))
                        .accessDeniedHandler(applicationContext.getBean(AccessDeniedHandler.class)));
        // 登录、登录暂时不使用 Spring Security 的拓展点，主要考虑一方面拓展多用户、多种登录方式相对复杂，一方面用户的学习成本较高

        // 获得 @PermitAll 带来的 URL 列表，免登录
        log.info("YshopWebSecurityConfigurerAdapter - 开始获取 @PermitAll 注解的 URL 列表...");
        Multimap<HttpMethod, String> permitAllUrls = getPermitAllUrlsFromAnnotations();
        log.info("YshopWebSecurityConfigurerAdapter - 获取到的 @PermitAll URLs: {}", permitAllUrls);
        // 设置每个请求的权限
        httpSecurity
                .authorizeHttpRequests(c -> {
                    // 1.1 静态资源，可匿名访问
                    c.requestMatchers(HttpMethod.GET, "/*.html", "/*.css", "/*.js").permitAll();
                    
                    // 1.2 设置 @PermitAll 无需认证
                    if (!permitAllUrls.get(HttpMethod.GET).isEmpty()) {
                        c.requestMatchers(HttpMethod.GET, permitAllUrls.get(HttpMethod.GET).toArray(new String[0])).permitAll();
                    }
                    if (!permitAllUrls.get(HttpMethod.POST).isEmpty()) {
                        c.requestMatchers(HttpMethod.POST, permitAllUrls.get(HttpMethod.POST).toArray(new String[0])).permitAll();
                    }
                    if (!permitAllUrls.get(HttpMethod.PUT).isEmpty()) {
                        c.requestMatchers(HttpMethod.PUT, permitAllUrls.get(HttpMethod.PUT).toArray(new String[0])).permitAll();
                    }
                    if (!permitAllUrls.get(HttpMethod.DELETE).isEmpty()) {
                        c.requestMatchers(HttpMethod.DELETE, permitAllUrls.get(HttpMethod.DELETE).toArray(new String[0])).permitAll();
                    }
                    if (!permitAllUrls.get(HttpMethod.HEAD).isEmpty()) {
                        c.requestMatchers(HttpMethod.HEAD, permitAllUrls.get(HttpMethod.HEAD).toArray(new String[0])).permitAll();
                    }
                    if (!permitAllUrls.get(HttpMethod.PATCH).isEmpty()) {
                        c.requestMatchers(HttpMethod.PATCH, permitAllUrls.get(HttpMethod.PATCH).toArray(new String[0])).permitAll();
                    }
                    
                    // 1.3 基于 yshop.security.permit-all-urls 无需认证
                    log.info("YshopWebSecurityConfigurerAdapter - 从配置文件获取的 permit-all-urls: {}", securityProperties.getPermitAllUrls());
                    if (!securityProperties.getPermitAllUrls().isEmpty()) {
                        c.requestMatchers(securityProperties.getPermitAllUrls().toArray(new String[0])).permitAll();
                    }
                    
                    // 1.4 设置 App API 无需认证
                    c.requestMatchers(buildAppApi("/**")).permitAll();
                    
                    // 每个项目的自定义规则
                    authorizeRequestsCustomizers.forEach(customizer -> customizer.customize(c));
                    
                    // 兜底规则，必须认证
                    c.anyRequest().authenticated();
                });

        // 添加 Token Filter - 从YshopSecurityAutoConfiguration获取Bean
        httpSecurity.addFilterBefore(applicationContext.getBean(TokenAuthenticationFilter.class), UsernamePasswordAuthenticationFilter.class);
        log.info("YshopWebSecurityConfigurerAdapter - SecurityFilterChain配置完成");
        return httpSecurity.build();
    }

    private String buildAppApi(String url) {
        return webProperties.getAppApi().getPrefix() + url;
    }

    private Multimap<HttpMethod, String> getPermitAllUrlsFromAnnotations() {
        Multimap<HttpMethod, String> result = HashMultimap.create();
        // 获得接口对应的 HandlerMethod 集合
        RequestMappingHandlerMapping requestMappingHandlerMapping = (RequestMappingHandlerMapping)
                applicationContext.getBean("requestMappingHandlerMapping");
        Map<RequestMappingInfo, HandlerMethod> handlerMethodMap = requestMappingHandlerMapping.getHandlerMethods();
        // 获得有 @PermitAll 注解的接口
        for (Map.Entry<RequestMappingInfo, HandlerMethod> entry : handlerMethodMap.entrySet()) {
            HandlerMethod handlerMethod = entry.getValue();
            if (!handlerMethod.hasMethodAnnotation(PermitAll.class)) {
                continue;
            }
            Set<String> urls = new HashSet<>();
            if (entry.getKey().getPatternsCondition() != null) {
                urls.addAll(entry.getKey().getPatternsCondition().getPatterns());
            }
            if (entry.getKey().getPathPatternsCondition() != null) {
                urls.addAll(convertList(entry.getKey().getPathPatternsCondition().getPatterns(), PathPattern::getPatternString));
            }
            if (urls.isEmpty()) {
                continue;
            }

            // 添加调试日志
            log.info("Found @PermitAll annotated method: {} with URLs: {}", handlerMethod.getMethod().getName(), urls);

            // 特殊：使用 @RequestMapping 注解，并且未写 method 属性，此时认为都需要免登录
            Set<RequestMethod> methods = entry.getKey().getMethodsCondition().getMethods();
            if (CollUtil.isEmpty(methods)) {
                result.putAll(HttpMethod.GET, urls);
                result.putAll(HttpMethod.POST, urls);
                result.putAll(HttpMethod.PUT, urls);
                result.putAll(HttpMethod.DELETE, urls);
                result.putAll(HttpMethod.HEAD, urls);
                result.putAll(HttpMethod.PATCH, urls);
                continue;
            }
            // 根据请求方法，添加到 result 结果
            entry.getKey().getMethodsCondition().getMethods().forEach(requestMethod -> {
                switch (requestMethod) {
                    case GET:
                        result.putAll(HttpMethod.GET, urls);
                        break;
                    case POST:
                        result.putAll(HttpMethod.POST, urls);
                        break;
                    case PUT:
                        result.putAll(HttpMethod.PUT, urls);
                        break;
                    case DELETE:
                        result.putAll(HttpMethod.DELETE, urls);
                        break;
                    case HEAD:
                        result.putAll(HttpMethod.HEAD, urls);
                        break;
                    case PATCH:
                        result.putAll(HttpMethod.PATCH, urls);
                        break;
                }
            });
        }
        
        // 添加调试日志，输出所有识别到的@PermitAll URL
        log.info("All @PermitAll URLs: {}", result);
        
        return result;
    }

}
