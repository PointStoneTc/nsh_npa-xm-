package nsh.xinmi.npa.sysInit.entity;

import static javax.persistence.GenerationType.IDENTITY;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.Table;
import javax.persistence.Transient;

/**
 * NaturalPerson entity. @author MyEclipse Persistence Tools
 */
@Entity
@Table(name = "npa_natural_person_imp")
public class NaturalPersonImp implements java.io.Serializable {
    private static final long serialVersionUID = -4178114245878328956L;
    // Fields
    private Long id;
    private String name; // 姓名
    private String idNumber; // 身份证号
    private String isBorrower; // 是否借款人
    private String isGuarantee; // 是否担保人
    
    private String existing;  //是否存在在正式库中

    /** default constructor */
    public NaturalPersonImp() {}

    // Property accessors
    @Id
    @GeneratedValue(strategy = IDENTITY)
    @Column(name = "id", unique = true, nullable = false)
    public Long getId() {
        return this.id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    @Column(name = "name", nullable = false, length = 10)
    public String getName() {
        return this.name;
    }

    public void setName(String name) {
        this.name = name;
    }


    @Column(name = "id_number", unique = true, nullable = false, length = 18)
    public String getIdNumber() {
        return this.idNumber;
    }

    public void setIdNumber(String idNumber) {
        this.idNumber = idNumber;
    }

    @Column(name = "is_borrower", nullable = false, length = 1)
    public String getIsBorrower() {
        return this.isBorrower;
    }

    public void setIsBorrower(String isBorrower) {
        this.isBorrower = isBorrower;
    }

    @Column(name = "is_guarantee", nullable = false, length = 1)
    public String getIsGuarantee() {
        return this.isGuarantee;
    }

    public void setIsGuarantee(String isGuarantee) {
        this.isGuarantee = isGuarantee;
    }

    @Transient
    public String getExisting() {
        return existing;
    }

    public void setExisting(String existing) {
        this.existing = existing;
    }
}
