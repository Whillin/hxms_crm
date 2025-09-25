package co.yixiang.yshop.module.system.job;

import co.yixiang.yshop.framework.quartz.core.handler.JobHandler;
// 移除租户相关导入
// import co.yixiang.yshop.framework.tenant.core.context.TenantContextHolder;
// import co.yixiang.yshop.framework.tenant.core.job.TenantJob;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Component;

/**
 * 示例 Job
 *
 * @author yshop
 */
@Component
@Slf4j
public class DemoJob implements JobHandler {

    // 移除租户相关注解
    // @TenantJob // 标记多租户
    @Override
    public String execute(String param) throws Exception {
        // 移除租户相关逻辑
        // System.out.println("当前租户：" + TenantContextHolder.getTenantId());
        System.out.println("执行参数：" + param);
        return "执行成功:" + param;
    }

}
