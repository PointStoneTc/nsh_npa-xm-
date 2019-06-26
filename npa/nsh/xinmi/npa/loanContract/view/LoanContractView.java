package nsh.xinmi.npa.loanContract.view;

import java.util.ArrayList;
import java.util.List;

import nsh.xinmi.npa.loanContract.entity.LoanContract;
import nsh.xinmi.npa.loanContractGuarantee.entity.LoanContractGuarantee;
import nsh.xinmi.npa.naturalPerson.entity.NaturalPerson;

/**
 * 借款合同视图
 * 
 * @author 赵琦
 *
 */
public class LoanContractView implements java.io.Serializable {
    private static final long serialVersionUID = -4685975848088829055L;
    private LoanContract loanContract;
    private NaturalPerson borrower;
    private List<LoanContractGuarantee> loanContractGuarantees;

    public LoanContractView() {
        loanContract = new LoanContract();
        borrower = new NaturalPerson();
        loanContractGuarantees = new ArrayList<LoanContractGuarantee>();
    }

    public LoanContract getLoanContract() {
        return loanContract;
    }

    public void setLoanContract(LoanContract loanContract) {
        this.loanContract = loanContract;
    }

    public NaturalPerson getBorrower() {
        return borrower;
    }

    public void setBorrower(NaturalPerson borrower) {
        this.borrower = borrower;
    }

    public List<LoanContractGuarantee> getLoanContractGuarantees() {
        return loanContractGuarantees;
    }

    public void setLoanContractGuarantees(List<LoanContractGuarantee> loanContractGuarantees) {
        this.loanContractGuarantees = loanContractGuarantees;
    }

}
