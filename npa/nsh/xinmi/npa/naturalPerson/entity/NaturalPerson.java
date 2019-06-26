package nsh.xinmi.npa.naturalPerson.entity;

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
import javax.persistence.UniqueConstraint;

import org.jeecgframework.core.util.DateUtils;

/**
 * NaturalPerson entity. @author MyEclipse Persistence Tools
 */
@Entity
@Table(name = "npa_natural_person", uniqueConstraints = @UniqueConstraint(columnNames = "id_number"))
public class NaturalPerson implements java.io.Serializable {
    private static final long serialVersionUID = -5493221703668349158L;

    // Fields
    private Long id;
    private String name;  //姓名
    private String sex;  //性别 男:m 女:f
    private Date birthday;  //出生年月
    private String province;  //省
    private String city;  //市
    private String county;  //县
    private String idNumber;  //身份证号
    private String phone;  //手机号码
    private String address;  //通讯地址
    private String isBorrower;  //是否借款人
    private String isGuarantee;  //是否担保人
    private String createBy; // 新建人
    private Date createDate; // 新建时间
    private String updateBy; // 修改人
    private Date updateDate; // 修改时间
    private String isDelete; // 是否删除
    private Date deleteDate; // 删除时间

    private Integer age;
    // Constructors

    /** default constructor */
    public NaturalPerson() {}

    /** minimal constructor */
    public NaturalPerson(String name, String sex, Date birthday, String idNumber, String isBorrower, String isGuarantee) {
        this.name = name;
        this.sex = sex;
        this.birthday = birthday;
        this.idNumber = idNumber;
        this.isBorrower = isBorrower;
        this.isGuarantee = isGuarantee;
    }

    /** full constructor */
    public NaturalPerson(String name, String sex, Date birthday, String province, String city, String county, String idNumber, String phone, String address, String isBorrower,
            String isGuarantee, String createBy, Date createDate, String updateBy, Date updateDate, String isDelete, Date deleteDate) {
        this.name = name;
        this.sex = sex;
        this.birthday = birthday;
        this.province = province;
        this.city = city;
        this.county = county;
        this.idNumber = idNumber;
        this.phone = phone;
        this.address = address;
        this.isBorrower = isBorrower;
        this.isGuarantee = isGuarantee;
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

    @Column(name = "name", nullable = false, length = 10)
    public String getName() {
        return this.name;
    }

    public void setName(String name) {
        this.name = name;
    }

    @Column(name = "sex", length = 1)
    public String getSex() {
        return this.sex;
    }

    public void setSex(String sex) {
        this.sex = sex;
    }

    @Temporal(TemporalType.DATE)
    @Column(name = "birthday", length = 10)
    public Date getBirthday() {
        return this.birthday;
    }

    public void setBirthday(Date birthday) {
        this.birthday = birthday;
    }

    @Column(name = "province", length = 10)
    public String getProvince() {
        return this.province;
    }

    public void setProvince(String province) {
        this.province = province;
    }

    @Column(name = "city", length = 10)
    public String getCity() {
        return this.city;
    }

    public void setCity(String city) {
        this.city = city;
    }

    @Column(name = "county", length = 10)
    public String getCounty() {
        return this.county;
    }

    public void setCounty(String county) {
        this.county = county;
    }

    @Column(name = "id_number", unique = true, nullable = false, length = 18)
    public String getIdNumber() {
        return this.idNumber;
    }

    public void setIdNumber(String idNumber) {
        this.idNumber = idNumber;
    }

    @Column(name = "phone", length = 11)
    public String getPhone() {
        return this.phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
    }

    @Column(name = "address", length = 50)
    public String getAddress() {
        return this.address;
    }

    public void setAddress(String address) {
        this.address = address;
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
    public Integer getAge() {
        if (birthday != null)
            age = Integer.valueOf(DateUtils.yearDateDiff(birthday, null));
        return age;
    }

    public void setAge(Integer age) {
        this.age = age;
    }

}
