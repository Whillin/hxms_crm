package co.yixiang.yshop.module.system.service.employee;

import co.yixiang.yshop.module.system.dal.dataobject.employee.EmployeeDO;

/**
 * 员工信息 Service 接口
 *
 * @author yshop
 */
public interface EmployeeService {

    /**
     * 根据姓名和手机号验证员工身份
     *
     * @param name   员工姓名
     * @param mobile 手机号码
     * @return 员工信息，如果不存在或已离职则返回 null
     */
    EmployeeDO validateEmployee(String name, String mobile);

    /**
     * 根据手机号查询员工
     *
     * @param mobile 手机号码
     * @return 员工信息
     */
    EmployeeDO getEmployeeByMobile(String mobile);

    /**
     * 根据姓名查询员工
     *
     * @param name 员工姓名
     * @return 员工信息
     */
    EmployeeDO getEmployeeByName(String name);

    /**
     * 检查员工是否在职
     *
     * @param employee 员工信息
     * @return 是否在职
     */
    boolean isActiveEmployee(EmployeeDO employee);

}