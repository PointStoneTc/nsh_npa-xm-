package nsh.xinmi.npa.loanContract.entity;

/**
 * 处理方式
 * 
 * @author 赵琦
 *
 */
public enum DisposeModeEnum {
    HXDK("h", "核销贷款"), TDZH("t", "土地置换"), YPZH("y", "央票置换");
    private String key;
    private String desc;

    private DisposeModeEnum(String key, String desc) {
        this.key = key;
        this.desc = desc;
    }

    /**
     * 
     * 通过key查找
     */
    public static DisposeModeEnum getEnumByKey(String key) {
        for (DisposeModeEnum e : DisposeModeEnum.values()) {
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
