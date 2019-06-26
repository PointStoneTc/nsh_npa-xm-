package nsh.xinmi.npa.loanContract.view;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;

import org.jeecgframework.core.util.oConvertUtils;

import nsh.xinmi.npa.loanContract.entity.DisposeModeEnum;
import nsh.xinmi.npa.loanContract.entity.GuaranteeModeEnum;
import nsh.xinmi.npa.loanContract.entity.LitigationStatEnum;
import nsh.xinmi.npa.loanContract.entity.StatEnum;
import nsh.xinmi.npa.loanContractGuarantee.entity.LoanContractGuarantee;

/**
 * 综合查询视图
 * 
 * @author 赵琦
 *
 */
public class ViContractQyView implements java.io.Serializable {
    private static final long serialVersionUID = -5346105277609349805L;

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
    private List<LoanContractGuarantee> loanContractGuarantees;

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

    public String getBorrowerName() {
        return borrowerName;
    }

    public void setBorrowerName(String borrowerName) {
        this.borrowerName = borrowerName;
    }

    public String getIdNumber() {
        return idNumber;
    }

    public void setIdNumber(String idNumber) {
        this.idNumber = idNumber;
    }

    public Double getAmount() {
        return amount;
    }

    public void setAmount(Double amount) {
        this.amount = amount;
    }

    public Double getAmountSurplus() {
        return amountSurplus;
    }

    public void setAmountSurplus(Double amountSurplus) {
        this.amountSurplus = amountSurplus;
    }

    public Double getoInterestRate() {
        return oInterestRate;
    }

    public void setoInterestRate(Double oInterestRate) {
        this.oInterestRate = oInterestRate;
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

    public Date getInterestDate() {
        return interestDate;
    }

    public void setInterestDate(Date interestDate) {
        this.interestDate = interestDate;
    }

    public Double getAdjustInterestRate() {
        return adjustInterestRate;
    }

    public void setAdjustInterestRate(Double adjustInterestRate) {
        this.adjustInterestRate = adjustInterestRate;
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

    public Double getHangInteres() {
        return hangInteres;
    }

    public void setHangInteres(Double hangInteres) {
        this.hangInteres = hangInteres;
    }

    public List<LoanContractGuarantee> getLoanContractGuarantees() {
        return loanContractGuarantees;
    }

    public void setLoanContractGuarantees(List<LoanContractGuarantee> loanContractGuarantees) {
        this.loanContractGuarantees = loanContractGuarantees;
    }

    public ViContractQyView() {
        loanContractGuarantees = new ArrayList<LoanContractGuarantee>();
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

    public String getGuaranteeMode_s() {
        if (oConvertUtils.isEmpty(guaranteeMode))
            return "";
        GuaranteeModeEnum e = GuaranteeModeEnum.getEnumByKey(guaranteeMode);
        return e.getDesc();
    }

    public String getDisposeMode_s() {
        if (oConvertUtils.isEmpty(disposeMode))
            return "";
        DisposeModeEnum e = DisposeModeEnum.getEnumByKey(disposeMode);
        return e.getDesc();
    }

    public String getLitigationStat_s() {
        if (oConvertUtils.isEmpty(litigationStat))
            return "";
        LitigationStatEnum e = LitigationStatEnum.getEnumByKey(litigationStat);
        return e.getDesc();
    }

    public String getStat_s() {
        if (oConvertUtils.isEmpty(stat))
            return "";
        StatEnum e = StatEnum.getEnumByKey(stat);
        return e.getDesc();
    }
}
