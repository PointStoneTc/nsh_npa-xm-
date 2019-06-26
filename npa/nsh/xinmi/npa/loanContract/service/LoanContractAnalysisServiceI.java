package nsh.xinmi.npa.loanContract.service;

import java.util.List;

import org.jeecgframework.core.common.service.CommonService;

import nsh.xinmi.npa.loanContract.view.LoanContractAnalsisErrorView;
import nsh.xinmi.npa.loanContract.view.LoanContractAnalsisOrgAmountView;
import nsh.xinmi.npa.loanContract.view.LoanContractAnalsisOrgBorrower;

public interface LoanContractAnalysisServiceI extends CommonService {
    /**
     * @Title:借款合同按支行，贷款金额分析
     * @return
     */
    List<LoanContractAnalsisOrgAmountView> getLoanContractlOrgAmount();
    
    /**
     * @Title:借款合同按支行，贷款人分析
     * @return
     */
    List<LoanContractAnalsisOrgBorrower> getLoanContractlOrgBorrower();
    
    /**
     * @Title:错误数据借款合同按支行，修改、未修改数量分析
     * @return
     */
    List<LoanContractAnalsisErrorView> getLoanContractlOrgError();
}
