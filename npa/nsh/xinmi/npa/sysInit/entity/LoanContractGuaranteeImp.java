package nsh.xinmi.npa.sysInit.entity;

import static javax.persistence.GenerationType.IDENTITY;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.Table;

/**
 * LoanContractGuarantee entity. @author MyEclipse Persistence Tools
 */
@Entity
@Table(name = "npa_loan_contract_guarantee_imp")
public class LoanContractGuaranteeImp implements java.io.Serializable {
    private static final long serialVersionUID = -8424145188644840493L;
    // Fields
    private Long id;
    private Long loanContracId;
    private Long guaranteeId;
    private String guaranteeName;
    private String isImpersonate;

    // Constructors
    /** default constructor */
    public LoanContractGuaranteeImp() {}

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

    @Column(name = "loan_contrac_id", nullable = false)
    public Long getLoanContracId() {
        return this.loanContracId;
    }

    public void setLoanContracId(Long loanContracId) {
        this.loanContracId = loanContracId;
    }

    @Column(name = "guarantee_id", nullable = false)
    public Long getGuaranteeId() {
        return this.guaranteeId;
    }

    public void setGuaranteeId(Long guaranteeId) {
        this.guaranteeId = guaranteeId;
    }

    @Column(name = "guarantee_name", length = 15)
    public String getGuaranteeName() {
        return this.guaranteeName;
    }

    public void setGuaranteeName(String guaranteeName) {
        this.guaranteeName = guaranteeName;
    }

    @Column(name = "is_impersonate", length = 1)
    public String getIsImpersonate() {
        return this.isImpersonate;
    }

    public void setIsImpersonate(String isImpersonate) {
        this.isImpersonate = isImpersonate;
    }

}
