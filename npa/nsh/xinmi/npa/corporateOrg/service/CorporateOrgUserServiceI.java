package nsh.xinmi.npa.corporateOrg.service;

import java.util.List;

import org.jeecgframework.core.common.service.CommonService;

import nsh.xinmi.npa.corporateOrg.entity.CorporateOrg;

public interface CorporateOrgUserServiceI extends CommonService {
    /**
     * @Title:根据用户查询可以操作的法人组织机构字典清单
     * @return
     */
    public List<CorporateOrg> getDictSelectByUser();
}
