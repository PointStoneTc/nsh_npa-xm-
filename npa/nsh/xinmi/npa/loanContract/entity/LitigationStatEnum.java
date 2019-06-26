package nsh.xinmi.npa.loanContract.entity;

/**
 * 诉讼状态
 * 
 * @author 赵琦
 *
 */
public enum LitigationStatEnum {
    WSS("n", "未诉讼"), LA("l", "立案"), YS("f", "一审"), ES("s", "二审"), ZS("g", "再审"), TJ("t", "调解"), SSZJ("e", "诉讼终结"), SQZX("i", "申请执行"), ZX("a", "执行"), ZZZX("b", "中止执行"), ZZBCZX("c",
            "终止本次执行"), ZXZZ("d", "执行终结");
    private String key;
    private String desc;

    private LitigationStatEnum(String key, String desc) {
        this.key = key;
        this.desc = desc;
    }

    /**
     * 
     * 通过key查找
     */
    public static LitigationStatEnum getEnumByKey(String key) {
        for (LitigationStatEnum e : LitigationStatEnum.values()) {
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
