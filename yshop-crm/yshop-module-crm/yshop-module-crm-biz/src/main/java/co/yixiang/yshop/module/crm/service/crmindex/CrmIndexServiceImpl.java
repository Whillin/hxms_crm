package co.yixiang.yshop.module.crm.service.crmindex;

import cn.hutool.core.date.DateUtil;
import co.yixiang.yshop.framework.security.core.util.SecurityFrameworkUtils;
import co.yixiang.yshop.module.crm.controller.admin.crmindex.vo.CrmIndexRespVO;
import co.yixiang.yshop.module.crm.dal.dataobject.crmbusiness.CrmBusinessDO;
import co.yixiang.yshop.module.crm.dal.dataobject.crmclues.CrmCluesDO;
import co.yixiang.yshop.module.crm.dal.dataobject.crmcustomer.CrmCustomerDO;
import co.yixiang.yshop.module.crm.dal.mysql.crmbusiness.CrmBusinessMapper;
import co.yixiang.yshop.module.crm.dal.mysql.crmbusiness.CrmBusinessProductMapper;
import co.yixiang.yshop.module.crm.dal.mysql.crmclues.CrmCluesMapper;
import co.yixiang.yshop.module.crm.dal.mysql.crmcustomer.CrmCustomerMapper;
import co.yixiang.yshop.module.product.dal.dataobject.storeproduct.StoreProductDO;
import co.yixiang.yshop.module.product.dal.mysql.storeproduct.StoreProductMapper;
import co.yixiang.yshop.module.product.dal.mysql.storeproductattrvalue.StoreProductAttrValueMapper;
import co.yixiang.yshop.module.system.api.user.AdminUserApi;
import com.baomidou.mybatisplus.core.conditions.query.LambdaQueryWrapper;
import jakarta.annotation.Resource;
import org.springframework.stereotype.Service;
import org.springframework.validation.annotation.Validated;

import java.util.Date;

/**
 * 商机 Service 实现类
 *
 * @author yshop
 */
@Service
@Validated
public class CrmIndexServiceImpl implements CrmIndexService {

    @Resource
    private CrmBusinessMapper businessMapper;
    @Resource
    private StoreProductMapper storeProductMapper;
    @Resource
    private CrmCustomerMapper customerMapper;
    @Resource
    private CrmCluesMapper crmCluesMapper;


    @Override
    public CrmIndexRespVO getIndexCount() {
        Long loginUserId = SecurityFrameworkUtils.getLoginUserId();
        Date todayStart = DateUtil.beginOfDay(new Date());
        Date todayEnd = DateUtil.endOfDay(new Date());

        Long followCustomerCount = customerMapper.selectCount(new LambdaQueryWrapper<CrmCustomerDO>()
                .between(CrmCustomerDO::getNextTime,todayStart,todayEnd).eq(CrmCustomerDO::getOwnerUserId,loginUserId));
        Long followBusinessCount = businessMapper.selectCount(new LambdaQueryWrapper<CrmBusinessDO>()
                .between(CrmBusinessDO::getNextTime,todayStart,todayEnd).eq(CrmBusinessDO::getOwnerUserId,loginUserId));
        Long followCluesCount = crmCluesMapper.selectCount(new LambdaQueryWrapper<CrmCluesDO>()
                .between(CrmCluesDO::getNextTime,todayStart,todayEnd).eq(CrmCluesDO::getOwnerUserId,loginUserId));
        Long customerDueCount = 0L;
        Long productCount = storeProductMapper.selectCount();

        return CrmIndexRespVO.builder()
                .followCustomerCount(followCustomerCount)
                .followBusinessCount(followBusinessCount)
                .followCluesCount(followCluesCount)
                .customerDueCount(customerDueCount)
                .productCount(productCount)
                .build();
    }
}