package nsh.xinmi.npa.loanContractGuarantee.service;

import java.util.List;

import org.jeecgframework.core.common.service.CommonService;

import nsh.xinmi.npa.loanContractGuarantee.entity.LoanContractGuarantee;

public interface LoanContractGuaranteeServiceI extends CommonService {
    /**
     * @Title: 根据合同id查询所有担保人信息
     * @param contractId
     * @return
     */
    List<LoanContractGuarantee> getListByContractId(Long contractId);
}
