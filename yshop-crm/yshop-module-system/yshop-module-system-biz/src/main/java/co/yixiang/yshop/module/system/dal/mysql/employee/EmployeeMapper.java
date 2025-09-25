package co.yixiang.yshop.module.system.dal.mysql.employee;

import co.yixiang.yshop.framework.mybatis.core.mapper.BaseMapperX;
import co.yixiang.yshop.module.system.dal.dataobject.employee.EmployeeDO;
import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import org.apache.ibatis.annotations.Mapper;

/**
 * 员工信息 Mapper
 *
 * @author yshop
 */
@Mapper
public interface EmployeeMapper extends BaseMapperX<EmployeeDO> {

    /**
     * 根据姓名和手机号查询在职员工
     *
     * @param name   员工姓名
     * @param mobile 手机号码
     * @return 员工信息
     */
    default EmployeeDO selectByNameAndMobile(String name, String mobile) {
        return selectOne(new LambdaQueryWrapper<EmployeeDO>()
                .eq(EmployeeDO::getName, name)
                .eq(EmployeeDO::getMobile, mobile)
                .eq(EmployeeDO::getIsActive, true));
    }

    /**
     * 根据手机号查询员工
     *
     * @param mobile 手机号码
     * @return 员工信息
     */
    default EmployeeDO selectByMobile(String mobile) {
        return selectOne(EmployeeDO::getMobile, mobile);
    }

    /**
     * 根据姓名查询员工
     *
     * @param name 员工姓名
     * @return 员工信息
     */
    default EmployeeDO selectByName(String name) {
        return selectOne(EmployeeDO::getName, name);
    }

}