package nsh.xinmi.npa.naturalPerson.service;

import org.jeecgframework.core.common.model.json.DataGrid;
import org.jeecgframework.core.common.service.CommonService;

import nsh.xinmi.npa.naturalPerson.entity.NaturalPerson;

public interface NaturalPersonServiceI extends CommonService {
    /**
     * @Title:获取借款人列表
     * @param naturalPerson
     * @param dataGrid
     */
    void getBorrowerList(NaturalPerson naturalPerson, DataGrid dataGrid);

    /**
     * @Title:获取担保人列表
     * @param naturalPerson
     * @param dataGrid
     */
    void getGuaranteeList(NaturalPerson naturalPerson, DataGrid dataGrid);

    /**
     * @Title:通过身份查询自然人是否存在
     * @param idNumber 身份证号
     * @return
     */
    NaturalPerson isExist(String name, String idNumber);

    /**
     * @Title:选择一个自然人
     * @param excludeIdNumbers 排除在外的人身份证号
     * @param naturalPerson
     * @param dataGrid
     */
    void getOnePersonList(String excludeIdNumbers, NaturalPerson naturalPerson, DataGrid dataGrid);

    /**
     * @Title:保存一个自然人
     * @param naturalPerson
     * @param isBorrower
     * @return
     * @throws Exception
     */
    NaturalPerson saveOrUpdateItem(NaturalPerson naturalPerson, boolean isBorrower) throws Exception;

    /**
     * @Title:保存自然人的联系方式，通讯地址信息
     * @param naturalPerson
     * @return
     * @throws Exception
     */
    boolean updateDetail(NaturalPerson naturalPerson) throws Exception;
}
