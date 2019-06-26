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

/**
 * LoanContract entity. @author MyEclipse Persistence Tools
 */
@Entity
@Table(name = "vi_contract_qy")
public class ViContractQy implements java.io.Serializable {
    private static final long serialVersionUID = 1300957246893053675L;
    // Fields
    private Long id; // 主键
    private String numCode; // 合同号
    private String customerNo; // 客户号
    private String louNo; // 借据号
    private String borrowerName; // 借款人
    private String idNumber; // 借款人身份证号
    private Double amount; // 原贷金额
    private Double amountSurplus; // 贷款余额
    private Double oInterestRate; // 原贷利率
    private Date issueDate; // 贷款发放日
    private Date dueDate; // 贷款到期日
    private Date interestDate; // 起息日
    private Double adjustInterestRate; // 调整利率
    private String officer; // 信贷员
    private String corporateOrgName; // 所属支行
    private String guaranteeMode; // 担保方式 信用:x 保证:b 抵押:d 复合:f
    private String disposeMode; // 处理方式 核销贷款:h 土地置换:t 央票置换:y
    private String litigationStat; // 诉讼状态 n:未诉讼 l:立案 f:一审 s:二审 a:再审 t:调解 e:诉讼终结 i:申请执行 a:执行 b:中止执行 c:终止本次执行 d:执行终结
    private String stat; // 状态
    private Double hangInteres; // 挂息金额

    // Constructors

    /** default constructor */
    public ViContractQy() {}

    public ViContractQy(Long id, String numCode, String customerNo, String louNo, String borrowerName, String idNumber, Double amount, Double amountSurplus, Double oInterestRate, Date issueDate, Date dueDate,
            Date interestDate, Double adjustInterestRate, String officer, String corporateOrgName, String guaranteeMode, String disposeMode, String litigationStat, String stat,
            Double hangInteres) {
        this.id = id;
        this.numCode = numCode;
        this.customerNo = customerNo;
        this.louNo = louNo;
        this.borrowerName = borrowerName;
        this.idNumber = idNumber;
        this.amount = amount;
        this.amountSurplus = amountSurplus;
        this.oInterestRate = oInterestRate;
        this.issueDate = issueDate;
        this.dueDate = dueDate;
        this.interestDate = interestDate;
        this.adjustInterestRate = adjustInterestRate;
        this.officer = officer;
        this.corporateOrgName = corporateOrgName;
        this.guaranteeMode = guaranteeMode;
        this.disposeMode = disposeMode;
        this.litigationStat = litigationStat;
        this.stat = stat;
        this.hangInteres = hangInteres;
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

    public String getCustomerNo() {
        return customerNo;
    }

    public void setCustomerNo(String customerNo) {
        this.customerNo = customerNo;
    }

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

    @Column(name = "id_number", length = 18)
    public String getIdNumber() {
        return idNumber;
    }

    public void setIdNumber(String idNumber) {
        this.idNumber = idNumber;
    }

    @Column(name = "amount", precision = 11, scale = 3)
    public Double getAmount() {
        return this.amount;
    }

    public void setAmount(Double amount) {
        this.amount = amount;
    }

    @Column(name = "amount_surplus", precision = 11, scale = 3)
    public Double getAmountSurplus() {
        return amountSurplus;
    }

    public void setAmountSurplus(Double amountSurplus) {
        this.amountSurplus = amountSurplus;
    }

    @Column(name = "o_interest_rate", precision = 6, scale = 4)
    public Double getOInterestRate() {
        return this.oInterestRate;
    }

    public void setOInterestRate(Double oInterestRate) {
        this.oInterestRate = oInterestRate;
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

    @Temporal(TemporalType.DATE)
    @Column(name = "interest_date", length = 10)
    public Date getInterestDate() {
        return interestDate;
    }

    public void setInterestDate(Date interestDate) {
        this.interestDate = interestDate;
    }

    @Column(name = "adjust_interest_rate", precision = 6, scale = 4)
    public Double getAdjustInterestRate() {
        return adjustInterestRate;
    }

    public void setAdjustInterestRate(Double adjustInterestRate) {
        this.adjustInterestRate = adjustInterestRate;
    }

    @Column(name = "officer", length = 15)
    public String getOfficer() {
        return this.officer;
    }

    public void setOfficer(String officer) {
        this.officer = officer;
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

    @Column(name = "hang_interes", precision = 11, scale = 3)
    public Double getHangInteres() {
        return this.hangInteres;
    }

    public void setHangInteres(Double hangInteres) {
        this.hangInteres = hangInteres;
    }

}
