package nsh.xinmi.npa.loanContract.view;

/**
 * 借款合同查询视图(部门，贷款金额)
 * 
 * @author 赵琦
 *
 */
public class LoanContractAnalsisOrgAmountView implements java.io.Serializable {
    private static final long serialVersionUID = -5445052752450781386L;
    private Long orgId; // 支行id
    private String orgName; // 支行名称
    private int v1; // 回收本金
    private int v2; // 剩余本金

    public LoanContractAnalsisOrgAmountView() {}

    public LoanContractAnalsisOrgAmountView(Long orgId, String orgName, int v1, int v2) {
        this.orgId = orgId;
        this.orgName = orgName;
        this.v1 = v1;
        this.v2 = v2;
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

    public int getV1() {
        return v1;
    }

    public void setV1(int v1) {
        this.v1 = v1;
    }

    public int getV2() {
        return v2;
    }

    public void setV2(int v2) {
        this.v2 = v2;
    };

}
