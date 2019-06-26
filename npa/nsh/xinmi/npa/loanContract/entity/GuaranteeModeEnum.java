package nsh.xinmi.npa.loanContract.entity;

/**
 * 担保方式
 * 
 * @author 赵琦
 *
 */
public enum GuaranteeModeEnum {
    XY("x", "信用"), BZ("b", "保证"), DY("d", "抵押"), FH("f", "复合");
    private String key;
    private String desc;

    private GuaranteeModeEnum(String key, String desc) {
        this.key = key;
        this.desc = desc;
    }

    /**
     * 
     * 通过key查找GasCommandTypeCons
     */
    public static GuaranteeModeEnum getEnumByKey(String key) {
        for (GuaranteeModeEnum gasCommandType : GuaranteeModeEnum.values()) {
            if (key.equals(gasCommandType.key)) {
                return gasCommandType;
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
