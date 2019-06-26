package nsh.xinmi.npa.recoveryMoney.entity;

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

/**
 * RecoveryMoney entity. @author MyEclipse Persistence Tools
 */
@Entity
@Table(name = "npa_recovery_money")
public class RecoveryMoney implements java.io.Serializable {
    private static final long serialVersionUID = -6143523340707844970L;

    // Fields
    private Long id;  //
    private Long loanContracId;  //借款合同id
    private Double interestBearingPrincipal;  //计息本金
    private Date interestDate;  //起息日
    private Double interestRate;  //利率
    private Date recoveryDate;  //收回时间
    private String recoveryPerson;  //收回人
    private Double recoveryPrincipal;  //收回本金
    private Double recoveryInterest;  //收回利息
    private String recoveryMode;  //收回方式 c:现金收回 d:法院扣划
    private Double hangInterest;  //挂息
    private String isEffect;  //是否生效
    private String createBy; // 新建人
    private Date createDate; // 新建时间
    private String updateBy; // 修改人
    private Date updateDate; // 修改时间
    private String isDelete; // 是否删除
    private Date deleteDate; // 删除时间

    // Constructors

    /** default constructor */
    public RecoveryMoney() {}

    /** minimal constructor */
    public RecoveryMoney(Long loanContracId, Double interestBearingPrincipal, Date interestDate, Double interestRate, Date recoveryDate, String recoveryPerson,
            Double recoveryPrincipal, String  recoveryMode, Double recoveryInterest, Double hangInterest, String isEffect) {
        this.loanContracId = loanContracId;
        this.interestBearingPrincipal = interestBearingPrincipal;
        this.interestDate = interestDate;
        this.interestRate = interestRate;
        this.recoveryDate = recoveryDate;
        this.recoveryPerson = recoveryPerson;
        this.recoveryPrincipal = recoveryPrincipal;
        this.recoveryMode = recoveryMode;
        this.recoveryInterest = recoveryInterest;
        this.hangInterest = hangInterest;
        this.isEffect = isEffect;
    }

    /** full constructor */
    public RecoveryMoney(Long loanContracId, Double interestBearingPrincipal, Date interestDate, Double interestRate, Date recoveryDate, String recoveryPerson,
            Double recoveryPrincipal, Double recoveryInterest, Double hangInterest, String isEffect, String createBy, Date createDate, String updateBy, Date updateDate,
            String isDelete, Date deleteDate) {
        this.loanContracId = loanContracId;
        this.interestBearingPrincipal = interestBearingPrincipal;
        this.interestDate = interestDate;
        this.interestRate = interestRate;
        this.recoveryDate = recoveryDate;
        this.recoveryPerson = recoveryPerson;
        this.recoveryPerson = recoveryPerson;
        this.recoveryPrincipal = recoveryPrincipal;
        this.recoveryInterest = recoveryInterest;
        this.isEffect = isEffect;
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

    @Column(name = "loan_contrac_id", nullable = false)
    public Long getLoanContracId() {
        return this.loanContracId;
    }

    public void setLoanContracId(Long loanContracId) {
        this.loanContracId = loanContracId;
    }

    @Column(name = "interest_bearing_principal", nullable = false, precision = 11, scale = 3)
    public Double getInterestBearingPrincipal() {
        return this.interestBearingPrincipal;
    }

    public void setInterestBearingPrincipal(Double interestBearingPrincipal) {
        this.interestBearingPrincipal = interestBearingPrincipal;
    }

    @Temporal(TemporalType.DATE)
    @Column(name = "interest_date", nullable = false, length = 10)
    public Date getInterestDate() {
        return this.interestDate;
    }

    public void setInterestDate(Date interestDate) {
        this.interestDate = interestDate;
    }

    @Column(name = "interest_rate", nullable = false, precision = 6, scale = 4)
    public Double getInterestRate() {
        return this.interestRate;
    }

    public void setInterestRate(Double interestRate) {
        this.interestRate = interestRate;
    }

    @Temporal(TemporalType.DATE)
    @Column(name = "recovery_date", nullable = false, length = 10)
    public Date getRecoveryDate() {
        return this.recoveryDate;
    }

    public void setRecoveryDate(Date recoveryDate) {
        this.recoveryDate = recoveryDate;
    }

    @Column(name = "recovery_person", nullable = false, length = 15)
    public String getRecoveryPerson() {
        return this.recoveryPerson;
    }

    public void setRecoveryPerson(String recoveryPerson) {
        this.recoveryPerson = recoveryPerson;
    }

    @Column(name = "recovery_principal", nullable = false, precision = 11, scale = 3)
    public Double getRecoveryPrincipal() {
        return recoveryPrincipal;
    }

    public void setRecoveryPrincipal(Double recoveryPrincipal) {
        this.recoveryPrincipal = recoveryPrincipal;
    }

    @Column(name = "recovery_interest", nullable = false, precision = 11, scale = 3)
    public Double getRecoveryInterest() {
        return recoveryInterest;
    }

    public void setRecoveryInterest(Double recoveryInterest) {
        this.recoveryInterest = recoveryInterest;
    }

    @Column(name = "recovery_mode", length = 1)
    public String getRecoveryMode() {
        return recoveryMode;
    }

    public void setRecoveryMode(String recoveryMode) {
        this.recoveryMode = recoveryMode;
    }

    @Column(name = "hang_interest", nullable = false, precision = 11, scale = 3)
    public Double getHangInterest() {
        return hangInterest;
    }

    public void setHangInterest(Double hangInterest) {
        this.hangInterest = hangInterest;
    }

    @Column(name = "is_effect", nullable = false, length = 1)
    public String getIsEffect() {
        return this.isEffect;
    }

    public void setIsEffect(String isEffect) {
        this.isEffect = isEffect;
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
    public String getRecoveryMode_s() {
        if (oConvertUtils.isEmpty(recoveryMode))
            return "";
        RecoveryModeStatEnum e = RecoveryModeStatEnum.getEnumByKey(recoveryMode);
        return e.getDesc();
    }
}
