package co.yixiang.yshop.module.system.service.employee;

import co.yixiang.yshop.module.system.dal.dataobject.employee.EmployeeDO;
import co.yixiang.yshop.module.system.dal.mysql.employee.EmployeeMapper;
import lombok.extern.slf4j.Slf4j;
import org.springframework.stereotype.Service;
import org.springframework.validation.annotation.Validated;

import jakarta.annotation.Resource;

/**
 * 员工信息 Service 实现类
 *
 * @author yshop
 */
@Service
@Validated
@Slf4j
public class EmployeeServiceImpl implements EmployeeService {

    @Resource
    private EmployeeMapper employeeMapper;

    @Override
    public EmployeeDO validateEmployee(String name, String mobile) {
        // 根据姓名和手机号查询在职员工
        EmployeeDO employee = employeeMapper.selectByNameAndMobile(name, mobile);
        
        // 检查员工是否存在且在职
        if (employee != null && isActiveEmployee(employee)) {
            return employee;
        }
        
        return null;
    }

    @Override
    public EmployeeDO getEmployeeByMobile(String mobile) {
        return employeeMapper.selectByMobile(mobile);
    }

    @Override
    public EmployeeDO getEmployeeByName(String name) {
        return employeeMapper.selectByName(name);
    }

    @Override
    public boolean isActiveEmployee(EmployeeDO employee) {
        return employee != null && Boolean.TRUE.equals(employee.getIsActive());
    }

}