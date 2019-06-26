package nsh.xinmi.npa.sysInit.entity;

import static javax.persistence.GenerationType.IDENTITY;

import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.Table;
import javax.persistence.Temporal;
import javax.persistence.TemporalType;

import org.jeecgframework.poi.excel.annotation.Excel;

/**
 * LoanContract entity. @author MyEclipse Persistence Tools
 */
@Entity
@Table(name = "npa_loan_contract_imp")
public class LoanContractImp implements java.io.Serializable {
    private static final long serialVersionUID = 3824758136156506020L;
    // Fields
    private Long id; // 主键
    @Excel(name = "档案编号", width = 20)
    private String numCode; // 档案编号
    @Excel(name = "客户号", width = 20)
    private String customerNo; // 客户号
    @Excel(name = "借据号", width = 20)
    private String louNo; // 借据号
    @Excel(name = "借款人姓名", width = 15)
    private String borrowerName; // 借款人姓名
    @Excel(name = "借款人身份证号", width = 18)
    private String borrowerNumber; // 借款人身份证号
    private String isImpersonate; // 是否借冒名
    @Excel(name = "担保人", width = 100)
    private String guarantees; // 担保人
    @Excel(name = "贷款金额")
    private Double amount; // 贷款金额
    @Excel(name = "贷款发放日", format = "yyyy-MM-dd")
    private Date issueDate; // 贷款发放日
    @Excel(name = "贷款到期日", format = "yyyy-MM-dd")
    private Date dueDate; // 贷款到期日
    @Excel(name = "利率")
    private Double interestRate; // 利率
    @Excel(name = "信贷员", width = 10)
    private String officer; // 信贷员
    @Excel(name = "所属支行", width = 10)
    private String corporateOrgName; // 所属支行名称
    @Excel(name = "担保方式", dicCode = "npa_gtmode")
    private String guaranteeMode; // 担保方式 信用:x 保证:b 抵押:d 复合:f
    @Excel(name = "处理方式", dicCode = "npa_dsmode")
    private String disposeMode; // 处理方式 核销贷款:h 土地置换:t 央票置换:y
    @Excel(name = "状态", dicCode = "npa_stat")
    private String stat; // 状态 正常:n 终止:t 结束:e
    @Excel(name = "诉讼状态", dicCode = "npa_ltstat")
    private String litigationStat; // 诉讼状态 n:未诉讼 l:立案 f:一审 s:二审 g:再审 t:调解 e:诉讼终结 i:申请执行 a:执行 b:中止执行 c:终止本次执行 d:执行终结
    @Excel(name = "起息日", format = "yyyy-MM-dd")
    private Date interestDate; // 起息日
    @Excel(name = "收回本金")
    private Double recoveryPrincipal; // 收回本金
    @Excel(name = "收回利息")
    private Double recoveryInterest; // 收回利息
    @Excel(name = "挂息")
    private Double hangInteres; // 挂息

    // Constructors
    /** default constructor */
    public LoanContractImp() {}

    // Property accessors
    @Id
    @GeneratedValue(strategy = IDENTITY)
    @Column(name = "id", unique = true)
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

    @Column(name = "lou_no", length = 20)
    public String getLouNo() {
        return louNo;
    }

    public void setLouNo(String louNo) {
        this.louNo = louNo;
    }

    @Column(name = "borrower_name", length = 15)
    public String getBorrowerName() {
        return this.borrowerName;
    }

    public void setBorrowerName(String borrowerName) {
        this.borrowerName = borrowerName;
    }

    @Column(name = "borrower_number", length = 18)
    public String getBorrowerNumber() {
        return borrowerNumber;
    }

    public void setBorrowerNumber(String borrowerNumber) {
        this.borrowerNumber = borrowerNumber;
    }

    @Column(name = "is_impersonate", length = 1)
    public String getIsImpersonate() {
        return this.isImpersonate;
    }

    public void setIsImpersonate(String isImpersonate) {
        this.isImpersonate = isImpersonate;
    }

    @Column(name = "guarantees", length = 100)
    public String getGuarantees() {
        return guarantees;
    }

    public void setGuarantees(String guarantees) {
        this.guarantees = guarantees;
    }

    @Column(name = "amount", precision = 11, scale = 3)
    public Double getAmount() {
        return this.amount;
    }

    public void setAmount(Double amount) {
        this.amount = amount;
    }

    @Temporal(TemporalType.DATE)
    @Column(name = "issue_date", length = 10)
    public Date getIssueDate() {
        return this.issueDate;
    }

    public void setIssueDate(Date issueDate) {
        this.issueDate = issueDate;
    }

    @Temporal(TemporalType.DATE)
    @Column(name = "due_date", length = 10)
    public Date getDueDate() {
        return this.dueDate;
    }

    public void setDueDate(Date dueDate) {
        this.dueDate = dueDate;
    }

    @Column(name = "interest_rate", precision = 6, scale = 4)
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

    @Column(name = "corporate_org_name")
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

    @Temporal(TemporalType.DATE)
    @Column(name = "interest_date", length = 10)
    public Date getInterestDate() {
        return this.interestDate;
    }

    public void setInterestDate(Date interestDate) {
        this.interestDate = interestDate;
    }

    @Column(name = "recovery_principal", precision = 11, scale = 3)
    public Double getRecoveryPrincipal() {
        return this.recoveryPrincipal;
    }

    public void setRecoveryPrincipal(Double recoveryPrincipal) {
        this.recoveryPrincipal = recoveryPrincipal;
    }

    @Column(name = "recovery_interest", precision = 11, scale = 3)
    public Double getRecoveryInterest() {
        return this.recoveryInterest;
    }

    public void setRecoveryInterest(Double recoveryInterest) {
        this.recoveryInterest = recoveryInterest;
    }

    @Column(name = "hang_interes", precision = 11, scale = 3)
    public Double getHangInteres() {
        return hangInteres;
    }

    public void setHangInteres(Double hangInteres) {
        this.hangInteres = hangInteres;
    }

}
