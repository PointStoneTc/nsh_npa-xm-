package nsh.xinmi.npa.recoveryMoney.service.impl;

import java.math.BigDecimal;
import java.util.Date;
import java.util.List;
import java.util.Map;
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

  @Override
  public boolean del(Long id) throws Exception {
    StringBuilder sql = new StringBuilder();
    Date interestDate = null;
    //找到除此id之外的最后一条收汇款记录
    sql.append("select interest_date from npa_recovery_money where is_effect = '1' and is_delete = '0' and id != ? order by id desc");
    List<Map<String, Object>> list = findForJdbcParam(sql.toString(), 1, 1, id);
    if (!list.isEmpty()) {
      interestDate = (Date) list.get(0).get("interest_date");
    }

    sql.setLength(0);
    sql.append("UPDATE npa_loan_contract c, npa_recovery_money m ") //
        .append(
            "SET c.recovery_principal = c.recovery_principal - m.recovery_principal, c.recovery_interest = c.recovery_interest - m.recovery_interest, c.hang_interes = c.hang_interes - m.hang_interest, c.interest_date = ?, ") //
        .append("m.is_delete = 1, m.is_effect = 0, m.delete_date = NOW() ") //
        .append("WHERE c.id = m.loan_contrac_id AND m.id = ?");
    executeSql(sql.toString(), interestDate, id);
    return true;
  }

}
