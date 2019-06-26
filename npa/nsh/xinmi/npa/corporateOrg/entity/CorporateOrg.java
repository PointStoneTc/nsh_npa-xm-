package nsh.xinmi.npa.corporateOrg.entity;

import static javax.persistence.GenerationType.IDENTITY;

import java.util.Date;

import javax.persistence.Column;
import javax.persistence.Entity;
import javax.persistence.GeneratedValue;
import javax.persistence.Id;
import javax.persistence.Table;
import javax.persistence.UniqueConstraint;

/**
 * NpaCorporateOrg entity. @author MyEclipse Persistence Tools
 */
@Entity
@Table(name = "npa_corporate_org", uniqueConstraints = @UniqueConstraint(columnNames = "name"))
public class CorporateOrg implements java.io.Serializable {
    private static final long serialVersionUID = 5560986451693741445L;

    // Fields
    private Long id;
    private String name;  //名称
    private String nameShorter;  //简称
    private String address;  //地址
    private String code;  //单位代码
    private String phone;  //电话
    private String isEffect;  //是否生效
    private String createBy; // 新建人
    private Date createDate; // 新建时间
    private String updateBy; // 修改人
    private Date updateDate; // 修改时间
    private String isDelete; // 是否删除
    private Date deleteDate; // 删除时间

    // Constructors

    /** default constructor */
    public CorporateOrg() {}

    /** minimal constructor */
    public CorporateOrg(String name, String nameShorter, String address, String code, String phone, String isEffect) {
        this.name = name;
        this.nameShorter = nameShorter;
        this.phone = phone;
        this.address = address;
        this.code = code;
        this.isEffect = isEffect;
    }

    /** full constructor */
    public CorporateOrg(String name, String nameShorter, String address, String code, String phone, String isEffect, String createBy, Date createDate, String updateBy,
            Date updateDate, String isDelete, Date deleteDate) {
        this.name = name;
        this.nameShorter = nameShorter;
        this.address = address;
        this.code = code;
        this.phone = phone;
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

    @Column(name = "name", unique = true, nullable = false, length = 50)
    public String getName() {
        return this.name;
    }

    public void setName(String name) {
        this.name = name;
    }

    @Column(name = "name_shorter", length = 50)
    public String getNameShorter() {
        return nameShorter;
    }

    public void setNameShorter(String nameShorter) {
        this.nameShorter = nameShorter;
    }

    @Column(name = "address", length = 50)
    public String getAddress() {
        return this.address;
    }

    public void setAddress(String address) {
        this.address = address;
    }

    @Column(name = "code", length = 20)
    public String getCode() {
        return this.code;
    }

    public void setCode(String code) {
        this.code = code;
    }

    @Column(name = "phone", length = 11)
    public String getPhone() {
        return phone;
    }

    public void setPhone(String phone) {
        this.phone = phone;
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

}
