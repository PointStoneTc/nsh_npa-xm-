package nsh.xinmi.npa.recoveryMoney.service.impl;

import java.math.BigDecimal;
import java.util.List;

import org.jeecgframework.core.common.service.impl.CommonServiceImpl;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import nsh.xinmi.npa.recoveryMoney.entity.RecoveryMoney;
import nsh.xinmi.npa.recoveryMoney.service.RecoveryMoneyServiceI;

@Service("recoveryMoneyService")
@Transactional
public class RecoveryMoneyServiceImpl extends CommonServiceImpl implements RecoveryMoneyServiceI {
    @Override
    public List<RecoveryMoney> getListByContractId(Long contractId) {
        String hql = "from RecoveryMoney where isEffect = '1' and isDelete = '0' and loanContracId = ?";
        List<RecoveryMoney> list = findHql(hql, contractId);
        return list;
    }

    @Override
    public boolean saveMain(RecoveryMoney recoveryMoney) throws Exception {
        // 保存回款记录
        recoveryMoney.setIsEffect("1");
        recoveryMoney.setIsDelete("0");
        save(recoveryMoney);

        // 更新合同主表
        double rp = 0d, ri = 0d, hi = 0d;
        rp = new BigDecimal(recoveryMoney.getRecoveryPrincipal().doubleValue()).setScale(3, BigDecimal.ROUND_HALF_UP).doubleValue();
        ri = new BigDecimal(recoveryMoney.getRecoveryInterest().doubleValue()).setScale(3, BigDecimal.ROUND_HALF_UP).doubleValue();
        hi = new BigDecimal(recoveryMoney.getHangInterest().doubleValue()).setScale(3, BigDecimal.ROUND_HALF_UP).doubleValue();
        String sql =
                "update npa_loan_contract set recovery_principal = recovery_principal + ?, recovery_interest = recovery_interest + ?, hang_interes = hang_interes + ?, interest_date = ? where id = ?";
        executeSql(sql, rp, ri, hi, recoveryMoney.getInterestDate(), recoveryMoney.getLoanContracId());
        return true;
    }
}
