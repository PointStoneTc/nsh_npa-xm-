package nsh.xinmi.npa.loanContract.view;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import nsh.xinmi.npa.loanContractGuarantee.entity.LoanContractGuarantee;

/**
 * 借款合同登记视图
 * 
 * @author 赵琦
 *
 */
public class LoanContractRegisterView implements java.io.Serializable {
    private static final long serialVersionUID = 5999644520239267072L;

    private Long id;
    private String numCode;
    private String customerNo;
    private String louNo; 
    private Long borrowerId;
    private String borrowerName;
    private String isImpersonate;
    private Double amount;
    private Date issueDate;
    private Date dueDate;
    private Double interestRate;
    private String officer;
    private String corporateOrgName;
    private String guaranteeMode;
    private String disposeMode;
    private String litigationStat;
    private String stat;
    private String isSubmit;
    private Date interestDate;
    private Double recoveryPrincipal;
    private Double recoveryInterest;
    private Double hangInteres;
    private String createBy;
    private Date createDate;
    private String idNumber;
    private List<LoanContractGuarantee> loanContractGuarantees;

    public LoanContractRegisterView() {
        loanContractGuarantees = new ArrayList<LoanContractGuarantee>();
    }

    public Long getId() {
        return id;
    }

    public void setId(Long id) {
        this.id = id;
    }

    public String getNumCode() {
        return numCode;
    }

    public void setNumCode(String numCode) {
        this.numCode = numCode;
    }

    public String getLouNo() {
        return louNo;
    }

    public void setLouNo(String louNo) {
        this.louNo = louNo;
    }

    public String getCustomerNo() {
        return customerNo;
    }

    public void setCustomerNo(String customerNo) {
        this.customerNo = customerNo;
    }

    public Long getBorrowerId() {
        return borrowerId;
    }

    public void setBorrowerId(Long borrowerId) {
        this.borrowerId = borrowerId;
    }

    public String getBorrowerName() {
        return borrowerName;
    }

    public void setBorrowerName(String borrowerName) {
        this.borrowerName = borrowerName;
    }

    public String getIsImpersonate() {
        return isImpersonate;
    }

    public void setIsImpersonate(String isImpersonate) {
        this.isImpersonate = isImpersonate;
    }

    public Double getAmount() {
        return amount;
    }

    public void setAmount(Double amount) {
        this.amount = amount;
    }

    public Date getIssueDate() {
        return issueDate;
    }

    public void setIssueDate(Date issueDate) {
        this.issueDate = issueDate;
    }

    public Date getDueDate() {
        return dueDate;
    }

    public void setDueDate(Date dueDate) {
        this.dueDate = dueDate;
    }

    public Double getInterestRate() {
        return interestRate;
    }

    public void setInterestRate(Double interestRate) {
        this.interestRate = interestRate;
    }

    public String getOfficer() {
        return officer;
    }

    public void setOfficer(String officer) {
        this.officer = officer;
    }

    public String getCorporateOrgName() {
        return corporateOrgName;
    }

    public void setCorporateOrgName(String corporateOrgName) {
        this.corporateOrgName = corporateOrgName;
    }

    public String getGuaranteeMode() {
        return guaranteeMode;
    }

    public void setGuaranteeMode(String guaranteeMode) {
        this.guaranteeMode = guaranteeMode;
    }

    public String getDisposeMode() {
        return disposeMode;
    }

    public void setDisposeMode(String disposeMode) {
        this.disposeMode = disposeMode;
    }

    public String getLitigationStat() {
        return litigationStat;
    }

    public void setLitigationStat(String litigationStat) {
        this.litigationStat = litigationStat;
    }
    
    public String getStat() {
        return stat;
    }

    public void setStat(String stat) {
        this.stat = stat;
    }

    public String getIsSubmit() {
        return isSubmit;
    }

    public void setIsSubmit(String isSubmit) {
        this.isSubmit = isSubmit;
    }

    public Date getInterestDate() {
        return interestDate;
    }

    public void setInterestDate(Date interestDate) {
        this.interestDate = interestDate;
    }

    public Double getRecoveryPrincipal() {
        return recoveryPrincipal;
    }

    public void setRecoveryPrincipal(Double recoveryPrincipal) {
        this.recoveryPrincipal = recoveryPrincipal;
    }

    public Double getRecoveryInterest() {
        return recoveryInterest;
    }

    public void setRecoveryInterest(Double recoveryInterest) {
        this.recoveryInterest = recoveryInterest;
    }

    public Double getHangInteres() {
        return hangInteres;
    }

    public void setHangInteres(Double hangInteres) {
        this.hangInteres = hangInteres;
    }

    public String getCreateBy() {
        return createBy;
    }

    public void setCreateBy(String createBy) {
        this.createBy = createBy;
    }

    public Date getCreateDate() {
        return createDate;
    }

    public void setCreateDate(Date createDate) {
        this.createDate = createDate;
    }

    public String getIdNumber() {
        return idNumber;
    }

    public void setIdNumber(String idNumber) {
        this.idNumber = idNumber;
    }

    public List<LoanContractGuarantee> getLoanContractGuarantees() {
        return loanContractGuarantees;
    }

    public void setLoanContractGuarantees(List<LoanContractGuarantee> loanContractGuarantees) {
        this.loanContractGuarantees = loanContractGuarantees;
    }

    public String getGuaranteesName() {
        StringBuffer names = new StringBuffer();
        for (LoanContractGuarantee guarantee : loanContractGuarantees)
            names.append(guarantee.getGuaranteeName()).append(",");

        if (names.lastIndexOf(",") > -1)
            names.deleteCharAt(names.length() - 1);

        return names.toString();
    }

    public String getGuaranteesIdNumber() {
        StringBuffer idNumbers = new StringBuffer();
        for (LoanContractGuarantee guarantee : loanContractGuarantees)
            idNumbers.append(guarantee.getGuarantee().getIdNumber()).append(",");

        if (idNumbers.lastIndexOf(",") > -1)
            idNumbers.deleteCharAt(idNumbers.length() - 1);

        return idNumbers.toString();
    }

}
