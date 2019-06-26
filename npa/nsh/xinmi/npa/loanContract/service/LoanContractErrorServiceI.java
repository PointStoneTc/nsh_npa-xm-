package nsh.xinmi.npa.loanContract.service;

import java.util.Date;

import org.jeecgframework.core.common.model.json.DataGrid;
import org.jeecgframework.core.common.service.CommonService;

import nsh.xinmi.npa.loanContract.view.LoanContractRegisterView;

public interface LoanContractErrorServiceI extends CommonService {
    /**
     * @Title:错误借款合同列表
     * 
     * @param loanContractListView
     * @param errorType
     * @param dataGrid
     */
    void getLoanContractRegisterList(LoanContractRegisterView loanContractRegisterView, String errorType, DataGrid dataGrid);

    /**
     * @Title:更新错误借款合同借款人信息
     * 
     * @param ids
     * @param name
     * @param sex
     * @param birthday
     * @param idNumber
     * @return
     * @throws Exception
     */
    boolean updateBorrower(String ids, String name, String sex, Date birthday, String idNumber) throws Exception;

    /**
     * @Title:更新错误借款合同贷款发放日、到期日信息
     * 
     * @param id
     * @param issueDate
     * @param dueDate
     * @return
     * @throws Exception
     */
    boolean updateIssueDueDate(Long id, Date issueDate, Date dueDate) throws Exception;

    /**
     * @Title: 错误借款合同登记提交
     * 
     * @param ids
     * @return
     */
    boolean commit(String ids);
}
