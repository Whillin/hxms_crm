package co.yixiang.yshop.module.system.dal.dataobject.employee;

import co.yixiang.yshop.framework.mybatis.core.dataobject.BaseDO;
import com.baomidou.mybatisplus.annotation.KeySequence;
import com.baomidou.mybatisplus.annotation.TableId;
import com.baomidou.mybatisplus.annotation.TableName;
import lombok.*;

import java.time.LocalDateTime;

/**
 * 员工信息 DO
 * 用于注册时的员工身份验证
 *
 * @author yshop
 */
@TableName("system_employee")
@KeySequence("system_employee_seq") // 用于 Oracle、PostgreSQL、Kingbase、DB2、H2 数据库的主键自增。如果是 MySQL 等数据库，可不写。
@Data
@EqualsAndHashCode(callSuper = true)
@Builder
@NoArgsConstructor
@AllArgsConstructor
public class EmployeeDO extends BaseDO {

    /**
     * 员工ID
     */
    @TableId
    private Long id;
    
    /**
     * 员工姓名
     */
    private String name;
    
    /**
     * 手机号码
     */
    private String mobile;
    
    /**
     * 部门ID
     * 关联 system_dept 表
     */
    private Long deptId;
    
    /**
     * 品牌部门
     */
    private String brandDept;
    
    /**
     * 信息部门
     */
    private String infoDept;
    
    /**
     * 区域
     */
    private String region;
    
    /**
     * 门店
     */
    private String store;
    
    /**
     * 岗位
     */
    private String position;
    
    /**
     * 是否在职
     * true: 在职, false: 离职
     */
    private Boolean isActive;
    
    /**
     * 入职日期
     */
    private LocalDateTime entryDate;
    
    /**
     * 离职日期
     */
    private LocalDateTime leaveDate;
    
    /**
     * 备注
     */
    private String remark;

}