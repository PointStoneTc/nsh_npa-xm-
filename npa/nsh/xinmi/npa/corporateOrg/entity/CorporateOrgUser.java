package nsh.xinmi.npa.corporateOrg.entity;

import static javax.persistence.GenerationType.IDENTITY;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.Table;

/**
 * CorporateOrgUser entity. @author MyEclipse Persistence Tools
 */
@Entity
@Table(name = "npa_corporate_org_user")
public class CorporateOrgUser implements java.io.Serializable {
    private static final long serialVersionUID = 2330023362020560734L;
    // Fields
    private Long id;
    private Long corporateOrgId;
    private String userid;

	// Constructors

	/** default constructor */
	public CorporateOrgUser() {
	}

	/** full constructor */
    public CorporateOrgUser(Long corporateOrgId, String userid) {
        super();
        this.corporateOrgId = corporateOrgId;
        this.userid = userid;
    }
    
    @Id
    @GeneratedValue(strategy = IDENTITY)
	@Column(name = "id", nullable = false)
    public Long getId() {
        return this.id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    @Column(name = "corporate_org_id", nullable = false)
    public Long getCorporateOrgId() {
        return this.corporateOrgId;
    }

    public void setCorporateOrgId(Long corporateOrgId) {
        this.corporateOrgId = corporateOrgId;
    }

    @Column(name = "userid", nullable = false, length = 32)
    public String getUserid() {
        return this.userid;
    }

    public void setUserid(String userid) {
        this.userid = userid;
    }

}