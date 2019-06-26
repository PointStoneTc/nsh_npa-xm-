package nsh.xinmi.npa.loanContract.entity;

/**
 * 合同状态
 * 
 * @author 赵琦
 *
 */
public enum StatEnum {
    ZC("n", "正常"), ZZ("t", "终止"), JS("e", "结束");
    private String key;
    private String desc;

    private StatEnum(String key, String desc) {
        this.key = key;
        this.desc = desc;
    }

    /**
     * 
     * 通过key查找
     */
    public static StatEnum getEnumByKey(String key) {
        for (StatEnum e : StatEnum.values()) {
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
