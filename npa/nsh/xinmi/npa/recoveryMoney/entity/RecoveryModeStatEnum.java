package nsh.xinmi.npa.recoveryMoney.entity;

/**
 * 收回方式
 * 
 * @author 赵琦
 *
 */
public enum RecoveryModeStatEnum {
    XJSH("c", "现金收回"), FYKH("f", "法院扣划");
    private String key;
    private String desc;

    private RecoveryModeStatEnum(String key, String desc) {
        this.key = key;
        this.desc = desc;
    }

    /**
     * 
     * 通过key查找
     */
    public static RecoveryModeStatEnum getEnumByKey(String key) {
        for (RecoveryModeStatEnum e : RecoveryModeStatEnum.values()) {
            if (key.equals(e.key)) {
                return e;
            }
        }
        return null;
    }

    public String getKey() {
        return key;
    }

    public void setKey(String key) {
        this.key = key;
    }

    public String getDesc() {
        return desc;
    }

    public void setDesc(String desc) {
        this.desc = desc;
    }
}
