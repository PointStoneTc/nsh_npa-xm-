package nsh.xinmi.npa.loanContractGuarantee.service.impl;

import java.util.List;

import org.jeecgframework.core.common.service.impl.CommonServiceImpl;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import nsh.xinmi.npa.loanContractGuarantee.entity.LoanContractGuarantee;
import nsh.xinmi.npa.loanContractGuarantee.service.LoanContractGuaranteeServiceI;
import nsh.xinmi.npa.naturalPerson.entity.NaturalPerson;

@Service("loanContractGuaranteeService")
@Transactional
public class LoanContractGuaranteeServiceImpl extends CommonServiceImpl implements LoanContractGuaranteeServiceI {
    @Override
    public List<LoanContractGuarantee> getListByContractId(Long contractId) {
        String hql = "from LoanContractGuarantee where loanContracId = ?";
        List<LoanContractGuarantee> list = findHql(hql, contractId);

        for (LoanContractGuarantee item : list) {
            NaturalPerson guarantee = this.get(NaturalPerson.class, item.getGuaranteeId());
            item.setGuarantee(guarantee);
        }
        return list;
    }



}
