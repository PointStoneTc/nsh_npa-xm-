package nsh.xinmi.npa.loanContract.entity;

import static javax.persistence.GenerationType.IDENTITY;

import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.Table;

/**
 * LoanContract entity. @author MyEclipse Persistence Tools
 */
@Entity
@Table(name = "npa_loan_contract_error")
public class LoanContractError implements java.io.Serializable {
    private static final long serialVersionUID = 2213063666757541546L;
    // Fields
    private Long id; // 主键
    private Long loanContractId; //合同表id
    private String isSubmit; // 是否提交
    private String createBy; // 新建人
    private Date createDate; // 新建时间
    private String updateBy; // 修改人
    private Date updateDate; // 修改时间
    private String isDelete; // 是否删除
    private Date deleteDate; // 删除时间

    // Constructors

    /** default constructor */
    public LoanContractError() {}
   
    public LoanContractError(Long loanContractId, String isSubmit, String createBy, Date createDate, String updateBy, Date updateDate, String isDelete, Date deleteDate) {
        this.loanContractId = loanContractId;
        this.isSubmit = isSubmit;
        this.createBy = createBy;
        this.createDate = createDate;
        this.updateBy = updateBy;
        this.updateDate = updateDate;
        this.isDelete = isDelete;
        this.deleteDate = deleteDate;
    }

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

    @Column(name = "loan_contract_id", nullable = false)
    public Long getLoanContractId() {
        return loanContractId;
    }

    public void setLoanContractId(Long loanContractId) {
        this.loanContractId = loanContractId;
    }

    @Column(name = "is_submit", nullable = false, length = 1)
    public String getIsSubmit() {
        return this.isSubmit;
    }

    public void setIsSubmit(String isSubmit) {
        this.isSubmit = isSubmit;
    }

    @Column(name = "create_by", length = 15)
    public String getCreateBy() {
        return this.createBy;
    }

    public void setCreateBy(String createBy) {
        this.createBy = createBy;
    }

    @Column(name = "create_date", length = 19)
    public Date getCreateDate() {
        return this.createDate;
    }

    public void setCreateDate(Date createDate) {
        this.createDate = createDate;
    }

    @Column(name = "update_by", length = 15)
    public String getUpdateBy() {
        return this.updateBy;
    }

    public void setUpdateBy(String updateBy) {
        this.updateBy = updateBy;
    }

    @Column(name = "update_date", length = 19)
    public Date getUpdateDate() {
        return this.updateDate;
    }

    public void setUpdateDate(Date updateDate) {
        this.updateDate = updateDate;
    }

    @Column(name = "is_delete", length = 1)
    public String getIsDelete() {
        return this.isDelete;
    }

    public void setIsDelete(String isDelete) {
        this.isDelete = isDelete;
    }

    @Column(name = "delete_date", length = 19)
    public Date getDeleteDate() {
        return this.deleteDate;
    }

    public void setDeleteDate(Date deleteDate) {
        this.deleteDate = deleteDate;
    }
}
