package nsh.xinmi.npa.corporateOrg.service;

import java.util.List;

import org.jeecgframework.core.common.model.json.DataGrid;
import org.jeecgframework.core.common.service.CommonService;

import nsh.xinmi.npa.corporateOrg.entity.CorporateOrg;

public interface CorporateOrgServiceI extends CommonService {
    /**
     * @Title:获取法人组织机构列表
     * @param corporateOrg
     * @param dataGrid
     */
    void getAllList(CorporateOrg corporateOrg, DataGrid dataGrid);

    /**
     * @Title:获取法人组织机构下所有的操作员列表
     * @param id 法人组织机构id
     * @param dataGrid
     */
    void getOperatorListByCorporateOrgId(Long id, DataGrid dataGrid);

    /**
     * @Title:选择操作员
     * @param dataGrid
     */
    void getOneOperatorList(Long orgId, DataGrid dataGrid);

    /**
     * @Title:获取所有的组织机构
     * @return
     */
    List<CorporateOrg> getAllList();
}
