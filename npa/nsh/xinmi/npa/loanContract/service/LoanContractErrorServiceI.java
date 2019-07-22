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
     * @param ids 主键s
     * @param name 姓名
     * @param sex 性别
     * @param birthday 生日
     * @param idNumber 身份证号码
     * @return
     * @throws Exception
     */
    boolean updateBorrower(String ids, String name, String sex, Date birthday, String idNumber) throws Exception;

    /**
     * @Title:更新错误借款合同担保人信息
     * 
     * @param id 主键
     * @param guaranteesNames 担保人姓名s
     * @param guaranteesIdNumbers 担保人身份证号s
     * @return
     * @throws Exception
     */
    boolean updateGuarantee(String id, String guaranteesNames, String guaranteesIdNumbers) throws Exception;

    /**
     * @Title:更新错误借款合同贷款发放日、到期日信息
     * 
     * @param id 主键
     * @param issueDate 贷款发放日
     * @param dueDate 贷款到期日
     * @return
     * @throws Exception
     */
    boolean updateIssueDueDate(Long id, Date issueDate, Date dueDate) throws Exception;

    /**
     * @Title: 更新错误借款合同贷款其它信息信息
     * 
     * @param id 主键
     * @param interestRate 利率
     * @param officer 信贷员
     * @param guaranteeMode 担保方式
     * @param disposeMode 处理方式
     * @param litigationStat 诉讼状态
     * @return
     * @throws Exception
     */
    boolean updateOther(Long id, Double interestRate, String officer, String guaranteeMode, String disposeMode, String litigationStat) throws Exception;

    /**
     * @Title: 更新错误借款合同贷款地址信息
     * 
     * @param idNumber 身份证号
     * @param address 地址
     * @return
     */
    boolean updateAddress(String idNumber, String address);
    /**
     * @Title: 错误借款合同登记提交
     * 
     * @param ids 主键s
     * @return
     */
    boolean commit(String ids);
}
