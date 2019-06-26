package nsh.xinmi.npa.loanContract.view;

import java.util.ArrayList;
import java.util.List;

import nsh.xinmi.npa.loanContract.entity.LoanContract;
import nsh.xinmi.npa.recoveryMoney.entity.RecoveryMoney;

/**
 * 借款合同收回款视图
 * 
 * @author 赵琦
 *
 */
public class LoanContractRecallView implements java.io.Serializable {
    private static final long serialVersionUID = 5395385671585024485L;
    private LoanContract loanContract;
    private List<RecoveryMoney> recoveryMoneies;

    public LoanContractRecallView() {
        recoveryMoneies = new ArrayList<RecoveryMoney>();
    }

    public LoanContract getLoanContract() {
        return loanContract;
    }


    public void setLoanContract(LoanContract loanContract) {
        this.loanContract = loanContract;
    }


    public List<RecoveryMoney> getRecoveryMoneies() {
        return recoveryMoneies;
    }

    public void setRecoveryMoneies(List<RecoveryMoney> recoveryMoneies) {
        this.recoveryMoneies = recoveryMoneies;
    }
}
