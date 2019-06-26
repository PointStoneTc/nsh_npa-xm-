package nsh.xinmi.npa.loanContract.entity;

import static javax.persistence.GenerationType.IDENTITY;

import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;
import javax.persistence.Transient;

import org.jeecgframework.core.util.oConvertUtils;

import nsh.xinmi.npa.naturalPerson.entity.NaturalPerson;

/**
 * LoanContract entity. @author MyEclipse Persistence Tools
 */
@Entity
@Table(name = "npa_loan_contract")
public class LoanContract implements java.io.Serializable {
    private static final long serialVersionUID = 3426484739730812526L;
    // Fields

    private Long id; // 主键
    private String numCode; // 档案编号
    private String customerNo; // 客户号
    private String louNo; // 借据号
    private Long borrowerId; // 借款人ID
    private String borrowerName; // 借款人姓名
    private String isImpersonate; // 是否借冒名
    private Double amount; // 贷款金额
    private Date issueDate; // 贷款发放日
    private Date dueDate; // 贷款到期日
    private Double interestRate; // 利率
    private String officer; // 信贷员
    private Long corporateOrgId; // 所属支行ID
    private String corporateOrgName; // 所属支行名称
    private String guaranteeMode; // 担保方式 信用:x 保证:b 抵押:d 复合:f
    private String disposeMode; // 处理方式 核销贷款:h 土地置换:t 央票置换:y
    private String stat; // 状态 正常:n 终止:t 结束:e
    private String litigationStat; // 诉讼状态 n:未诉讼 l:立案 f:一审 s:二审 g:再审 t:调解 e:诉讼终结 i:申请执行 a:执行 b:中止执行 c:终止本次执行 d:执行终结
    private String remark; // 备注
    private String isSubmit; // 是否提交
    private Date interestDate; // 起息日
    private Double recoveryPrincipal; // 收回本金
    private Double recoveryInterest; // 收回利息
    private Double hangInteres; // 挂息
    private String createBy; // 新建人
    private Date createDate; // 新建时间
    private String updateBy; // 修改人
    private Date updateDate; // 修改时间
    private String isDelete; // 是否删除
    private Date deleteDate; // 删除时间

    // 非持久化的属性
    private NaturalPerson borrower;

    // Constructors

    /** default constructor */
    public LoanContract() {}

    /** full constructor */
    public LoanContract(String numCode, String customerNo, String louNo, Long borrowerId, String borrowerName, String isImpersonate, Double amount, Date issueDate, Date dueDate,
            Double interestRate, String officer, Long corporateOrgId, String corporateOrgName, String guaranteeMode, String disposeMode, String litigationStat, String stat,
            String remark, String isSubmit, Double recoveryPrincipal, Double recoveryInterest, Double hangInteres, String createBy, Date createDate, String updateBy,
            Date updateDate, String isDelete, Date deleteDate) {
        this.numCode = numCode;
        this.customerNo = customerNo;
        this.louNo = louNo;
        this.borrowerId = borrowerId;
        this.borrowerName = borrowerName;
        this.isImpersonate = isImpersonate;
        this.amount = amount;
        this.issueDate = issueDate;
        this.dueDate = dueDate;
        this.interestRate = interestRate;
        this.officer = officer;
        this.corporateOrgId = corporateOrgId;
        this.corporateOrgName = corporateOrgName;
        this.guaranteeMode = guaranteeMode;
        this.disposeMode = disposeMode;
        this.litigationStat = litigationStat;
        this.stat = stat;
        this.remark = remark;
        this.isSubmit = isSubmit;
        this.recoveryPrincipal = recoveryPrincipal;
        this.recoveryInterest = recoveryInterest;
        this.hangInteres = hangInteres;
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

    @Column(name = "num_code", length = 20)
    public String getNumCode() {
        return this.numCode;
    }

    public void setNumCode(String numCode) {
        this.numCode = numCode;
    }

    @Column(name = "customer_no", length = 20)
    public String getCustomerNo() {
        return customerNo;
    }

    public void setCustomerNo(String customerNo) {
        this.customerNo = customerNo;
    }

    @Column(name = "lou_no", nullable = false, length = 20)
    public String getLouNo() {
        return louNo;
    }

    public void setLouNo(String louNo) {
        this.louNo = louNo;
    }

    @Column(name = "borrower_id", nullable = false)
    public Long getBorrowerId() {
        return this.borrowerId;
    }

    public void setBorrowerId(Long borrowerId) {
        this.borrowerId = borrowerId;
    }

    @Column(name = "borrower_name", length = 15)
    public String getBorrowerName() {
        return this.borrowerName;
    }

    public void setBorrowerName(String borrowerName) {
        this.borrowerName = borrowerName;
    }

    @Column(name = "is_impersonate", length = 1)
    public String getIsImpersonate() {
        return this.isImpersonate;
    }

    public void setIsImpersonate(String isImpersonate) {
        this.isImpersonate = isImpersonate;
    }

    @Column(name = "amount", nullable = false, precision = 11, scale = 3)
    public Double getAmount() {
        return this.amount;
    }

    public void setAmount(Double amount) {
        this.amount = amount;
    }

    @Temporal(TemporalType.DATE)
    @Column(name = "issue_date", nullable = false, length = 10)
    public Date getIssueDate() {
        return this.issueDate;
    }

    public void setIssueDate(Date issueDate) {
        this.issueDate = issueDate;
    }

    @Temporal(TemporalType.DATE)
    @Column(name = "due_date", nullable = false, length = 10)
    public Date getDueDate() {
        return this.dueDate;
    }

    public void setDueDate(Date dueDate) {
        this.dueDate = dueDate;
    }

    @Column(name = "interest_rate", nullable = false, precision = 6, scale = 4)
    public Double getInterestRate() {
        return this.interestRate;
    }

    public void setInterestRate(Double interestRate) {
        this.interestRate = interestRate;
    }

    @Column(name = "officer", length = 15)
    public String getOfficer() {
        return this.officer;
    }

    public void setOfficer(String officer) {
        this.officer = officer;
    }

    @Column(name = "corporate_org_id", nullable = false)
    public Long getCorporateOrgId() {
        return this.corporateOrgId;
    }

    public void setCorporateOrgId(Long corporateOrgId) {
        this.corporateOrgId = corporateOrgId;
    }

    @Column(name = "corporate_org_name", length = 50)
    public String getCorporateOrgName() {
        return this.corporateOrgName;
    }

    public void setCorporateOrgName(String corporateOrgName) {
        this.corporateOrgName = corporateOrgName;
    }

    @Column(name = "guarantee_mode", length = 1)
    public String getGuaranteeMode() {
        return guaranteeMode;
    }

    public void setGuaranteeMode(String guaranteeMode) {
        this.guaranteeMode = guaranteeMode;
    }

    @Column(name = "dispose_mode", length = 1)
    public String getDisposeMode() {
        return disposeMode;
    }

    public void setDisposeMode(String disposeMode) {
        this.disposeMode = disposeMode;
    }

    @Column(name = "litigation_stat", length = 1)
    public String getLitigationStat() {
        return litigationStat;
    }

    public void setLitigationStat(String litigationStat) {
        this.litigationStat = litigationStat;
    }

    @Column(name = "stat", length = 1)
    public String getStat() {
        return this.stat;
    }

    public void setStat(String stat) {
        this.stat = stat;
    }

    @Column(name = "remark", length = 200)
    public String getRemark() {
        return this.remark;
    }

    public void setRemark(String remark) {
        this.remark = remark;
    }

    @Column(name = "is_submit", nullable = false, length = 1)
    public String getIsSubmit() {
        return this.isSubmit;
    }

    public void setIsSubmit(String isSubmit) {
        this.isSubmit = isSubmit;
    }

    @Temporal(TemporalType.DATE)
    @Column(name = "interest_date", length = 10)
    public Date getInterestDate() {
        return this.interestDate;
    }

    public void setInterestDate(Date interestDate) {
        this.interestDate = interestDate;
    }

    @Column(name = "recovery_principal", nullable = false, precision = 11, scale = 3)
    public Double getRecoveryPrincipal() {
        return this.recoveryPrincipal;
    }

    public void setRecoveryPrincipal(Double recoveryPrincipal) {
        this.recoveryPrincipal = recoveryPrincipal;
    }

    @Column(name = "recovery_interest", nullable = false, precision = 11, scale = 3)
    public Double getRecoveryInterest() {
        return this.recoveryInterest;
    }

    public void setRecoveryInterest(Double recoveryInterest) {
        this.recoveryInterest = recoveryInterest;
    }

    @Column(name = "hang_interes", nullable = false, precision = 11, scale = 3)
    public Double getHangInteres() {
        return this.hangInteres;
    }

    public void setHangInteres(Double hangInteres) {
        this.hangInteres = hangInteres;
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

    @Transient
    public NaturalPerson getBorrower() {
        return borrower;
    }

    public void setBorrower(NaturalPerson borrower) {
        this.borrower = borrower;
    }

    @Transient
    public String getGuaranteeMode_s() {
        if (oConvertUtils.isEmpty(guaranteeMode))
            return "";
        GuaranteeModeEnum e = GuaranteeModeEnum.getEnumByKey(guaranteeMode);
        return e.getDesc();
    }

    @Transient
    public String getDisposeMode_s() {
        if (oConvertUtils.isEmpty(disposeMode))
            return "";
        DisposeModeEnum e = DisposeModeEnum.getEnumByKey(disposeMode);
        return e.getDesc();
    }

    @Transient
    public String getLitigationStat_s() {
        if (oConvertUtils.isEmpty(litigationStat))
            return "";
        LitigationStatEnum e = LitigationStatEnum.getEnumByKey(litigationStat);
        return e.getDesc();
    }

    @Transient
    public String getStat_s() {
        if (oConvertUtils.isEmpty(stat))
            return "";
        StatEnum e = StatEnum.getEnumByKey(stat);
        return e.getDesc();
    }
}
