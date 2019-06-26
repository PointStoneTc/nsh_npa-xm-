package nsh.xinmi.npa.loanContract.view;

/**
 * 借款合同查询视图(错误数据)
 * 
 * @author 赵琦
 *
 */
public class LoanContractAnalsisErrorView implements java.io.Serializable {
    private static final long serialVersionUID = 4439506437731907254L;
    private int orgId;  //支行id
    private String orgName; // 支行名称
    private int v1; // 全部错误数据
    private int v2; // 修改过的错误数据
    private int v3; // 剩余的错误数据

    public LoanContractAnalsisErrorView() {}

    public LoanContractAnalsisErrorView(int orgId, String orgName, int v1, int v2, int v3) {
        super();
        this.orgId = orgId;
        this.orgName = orgName;
        this.v1 = v1;
        this.v2 = v2;
        this.v3 = v3;
    }

    public int getOrgId() {
        return orgId;
    }

    public void setOrgId(int orgId) {
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
    }

    public int getV3() {
        return v3;
    }

    public void setV3(int v3) {
        this.v3 = v3;
    }
   
}
