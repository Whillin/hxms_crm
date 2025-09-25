package co.yixiang.yshop.module.system.service.permission;

import org.springframework.stereotype.Service;

import java.util.HashMap;
import java.util.Map;

/**
 * 岗位角色映射服务
 * 根据员工岗位自动分配对应的角色
 *
 * @author yshop
 */
@Service
public class PositionRoleMappingService {

    /**
     * 岗位到角色ID的映射关系
     */
    private static final Map<String, Long> POSITION_ROLE_MAPPING = new HashMap<>();

    static {
        // 集团级岗位 -> 集团管理员角色 (ID: 10)
        POSITION_ROLE_MAPPING.put("集团总裁", 10L);
        POSITION_ROLE_MAPPING.put("集团副总裁", 10L);
        
        // 品牌级岗位 -> 品牌管理员角色 (ID: 20)
        POSITION_ROLE_MAPPING.put("品牌总经理", 20L);
        POSITION_ROLE_MAPPING.put("品牌副总经理", 20L);
        
        // 信息管理部岗位 -> 集团管理员角色 (ID: 10)
        POSITION_ROLE_MAPPING.put("信息管理部总监", 10L);
        POSITION_ROLE_MAPPING.put("系统工程师", 10L);
        
        // 区域级岗位 -> 区域管理员角色 (ID: 30)
        POSITION_ROLE_MAPPING.put("区域经理", 30L);
        POSITION_ROLE_MAPPING.put("区域主管", 30L);
        
        // 门店级岗位 -> 门店管理员角色 (ID: 40)
        POSITION_ROLE_MAPPING.put("店长", 40L);
        POSITION_ROLE_MAPPING.put("销售经理", 40L);
        
        // 普通员工岗位 -> 普通员工角色 (ID: 50)
        POSITION_ROLE_MAPPING.put("前台", 50L);
        POSITION_ROLE_MAPPING.put("销售顾问", 50L);
        POSITION_ROLE_MAPPING.put("预约专员", 50L);
    }

    /**
     * 根据员工岗位获取对应的角色ID
     *
     * @param position 员工岗位
     * @return 角色ID，如果没有匹配的岗位则返回普通员工角色ID (50)
     */
    public Long getRoleIdByPosition(String position) {
        if (position == null || position.trim().isEmpty()) {
            return 50L; // 默认为普通员工角色
        }
        
        return POSITION_ROLE_MAPPING.getOrDefault(position.trim(), 50L);
    }

    /**
     * 检查岗位是否有对应的角色映射
     *
     * @param position 员工岗位
     * @return 是否有映射关系
     */
    public boolean hasRoleMapping(String position) {
        if (position == null || position.trim().isEmpty()) {
            return false;
        }
        
        return POSITION_ROLE_MAPPING.containsKey(position.trim());
    }
}