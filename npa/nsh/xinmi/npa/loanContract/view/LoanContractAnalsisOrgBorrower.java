package nsh.xinmi.npa.loanContract.view;

/**
 * 借款合同查询视图(部门，贷款人)
 * 
 * @author 赵琦
 *
 */
public class LoanContractAnalsisOrgBorrower implements java.io.Serializable {
    private static final long serialVersionUID = -8438204017427255835L;
    private Long orgId; // 支行id
    private String orgName; // 支行名称
    private int ct; // 借款人数量

    public LoanContractAnalsisOrgBorrower() {}

    public LoanContractAnalsisOrgBorrower(Long orgId, String orgName, int ct) {
        this.orgId = orgId;
        this.orgName = orgName;
        this.ct = ct;
    }

    public Long getOrgId() {
        return orgId;
    }

    public void setOrgId(Long orgId) {
        this.orgId = orgId;
    }

    public String getOrgName() {
        return orgName;
    }

    public void setOrgName(String orgName) {
        this.orgName = orgName;
    }

    public int getCt() {
        return ct;
    }

    public void setCt(int ct) {
        this.ct = ct;
    }
}
