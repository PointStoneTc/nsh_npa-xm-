package nsh.xinmi.npa.corporateOrg.view;

/**
 * 法人组织机构用户列表视图
 * 
 * @author 赵琦
 *
 */
public class CorporateOrgUserListView {
    private Long id;
    private Long corporateOrgId;
    private String userid;
    private String userName;

    public CorporateOrgUserListView() {}

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public Long getCorporateOrgId() {
        return corporateOrgId;
    }

    public void setCorporateOrgId(Long corporateOrgId) {
        this.corporateOrgId = corporateOrgId;
    }

    public String getUserid() {
        return userid;
    }

    public void setUserid(String userid) {
        this.userid = userid;
    }

    public String getUserName() {
        return userName;
    }

    public void setUserName(String userName) {
        this.userName = userName;
    }



}
