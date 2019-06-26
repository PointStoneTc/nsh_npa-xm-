package nsh.xinmi.npa.util;

import java.io.IOException;

import org.jeecgframework.core.util.oConvertUtils;

import com.itextpdf.text.DocumentException;
import com.itextpdf.text.Font;
import com.itextpdf.text.PageSize;
import com.itextpdf.text.Rectangle;
import com.itextpdf.text.pdf.BaseFont;

/**
 * 文件打印配置文件
 * 
 * @author 赵琦
 *
 */
public class PdfConfig {
    private Rectangle docment_page_size = PageSize.A4; // 文件大小
    private Float docment_margin_left = new Float(50); // 左外边框间距
    private Float docment_margin_right = new Float(50); // 右外边框间距
    private Float docment_margin_top = new Float(50); // 上外边框间距
    private Float docment_margin_bottom = new Float(50); // 下外边框间距

    private String font_name = "STSongStd-Light"; // 字体名称
    private String font_encoding = "UniGB-UCS2-H"; // 字体编码
    private Integer font_size_general = new Integer(10); // 普通字体字号
    private Integer font_size_big = new Integer(20); // 大字体的字号
    private String docment_basePath; // 文件存储路径

    private BaseFont bfChinese; // 字体
    private Font font; // 正常字体
    private Font fontBold; // 正常加粗字体
    private Font fontBig;// 大字体
    private Font fontBigBold;;// 加粗大字体

    private String pdfVersionImp; // 版本
    private String title; // 标题
    private String author; // 作者
    private String subject; // 主题
    private String keywords; // 关键字
    private String creator; // 创建者

    private static PdfConfig cf;

    @SuppressWarnings("unused")
    private PdfConfig() {}

    // 构造函数
    public PdfConfig(Rectangle docment_page_size, Float docment_margin_left, Float docment_margin_right, Float docment_margin_top, Float docment_margin_bottom, String font_name,
            String font_encoding, Integer font_size_general, Integer font_size_big, String docment_basePath, String pdfVersionImp, String title, String author, String subject,
            String keywords, String creator) throws DocumentException, IOException {
        if (docment_page_size != null)
            this.docment_page_size = docment_page_size;
        if (docment_margin_left != null)
            this.docment_margin_left = docment_margin_left;
        if (docment_margin_right != null)
            this.docment_margin_right = docment_margin_right;
        if (docment_margin_top != null)
            this.docment_margin_top = docment_margin_top;
        if (docment_margin_bottom != null)
            this.docment_margin_bottom = docment_margin_bottom;
        if (oConvertUtils.isNotEmpty(font_name))
            this.font_name = font_name;
        if (oConvertUtils.isNotEmpty(font_encoding))
            this.font_encoding = font_encoding;
        if (font_size_general != null)
            this.font_size_general = font_size_general;
        if (font_size_big != null)
            this.font_size_big = font_size_big;
        if (oConvertUtils.isNotEmpty(docment_basePath))
            this.docment_basePath = docment_basePath;
        bfChinese = BaseFont.createFont(this.font_name, this.font_encoding, BaseFont.NOT_EMBEDDED);
        font = new Font(bfChinese, this.font_size_general.floatValue());
        fontBold = new Font(bfChinese, this.font_size_general.floatValue(), Font.BOLD);
        fontBig = new Font(bfChinese, this.font_size_big.floatValue());
        fontBigBold = new Font(bfChinese, this.font_size_big.floatValue(), Font.BOLD);
        this.pdfVersionImp = pdfVersionImp;
        this.title = title;
        this.author = author;
        this.subject = subject;
        this.keywords = keywords;
        this.creator = creator;
    }

    // 工厂方法
    public static PdfConfig getInstance(String docment_basePath, String pdfVersionImp, String title, String author, String subject, String keywords, String creator)
            throws DocumentException, IOException {
        cf = new PdfConfig(null, null, null, null, null, "", "", null, null, docment_basePath, pdfVersionImp, title, author, subject, keywords, creator);
        return cf;
    }

    public Rectangle getDocment_page_size() {
        return docment_page_size;
    }

    public void setDocment_page_size(Rectangle docment_page_size) {
        this.docment_page_size = docment_page_size;
    }

    public Float getDocment_margin_left() {
        return docment_margin_left;
    }

    public void setDocment_margin_left(Float docment_margin_left) {
        this.docment_margin_left = docment_margin_left;
    }

    public Float getDocment_margin_right() {
        return docment_margin_right;
    }

    public void setDocment_margin_right(Float docment_margin_right) {
        this.docment_margin_right = docment_margin_right;
    }

    public Float getDocment_margin_top() {
        return docment_margin_top;
    }

    public void setDocment_margin_top(Float docment_margin_top) {
        this.docment_margin_top = docment_margin_top;
    }

    public Float getDocment_margin_bottom() {
        return docment_margin_bottom;
    }

    public void setDocment_margin_bottom(Float docment_margin_bottom) {
        this.docment_margin_bottom = docment_margin_bottom;
    }

    public String getFont_name() {
        return font_name;
    }

    public void setFont_name(String font_name) {
        this.font_name = font_name;
    }

    public String getFont_encoding() {
        return font_encoding;
    }

    public void setFont_encoding(String font_encoding) {
        this.font_encoding = font_encoding;
    }

    public Integer getFont_size_general() {
        return font_size_general;
    }

    public void setFont_size_general(Integer font_size_general) {
        this.font_size_general = font_size_general;
    }

    public Integer getFont_size_big() {
        return font_size_big;
    }

    public void setFont_size_big(Integer font_size_big) {
        this.font_size_big = font_size_big;
    }

    public String getDocment_basePath() {
        return docment_basePath;
    }

    public void setDocment_basePath(String docment_basePath) {
        this.docment_basePath = docment_basePath;
    }

    public BaseFont getBfChinese() {
        return bfChinese;
    }

    public void setBfChinese(BaseFont bfChinese) {
        this.bfChinese = bfChinese;
    }

    public Font getFont() {
        return font;
    }

    public void setFont(Font font) {
        this.font = font;
    }

    public Font getFontBold() {
        return fontBold;
    }

    public void setFontBold(Font fontBold) {
        this.fontBold = fontBold;
    }

    public Font getFontBig() {
        return fontBig;
    }

    public void setFontBig(Font fontBig) {
        this.fontBig = fontBig;
    }

    public Font getFontBigBold() {
        return fontBigBold;
    }

    public void setFontBigBold(Font fontBigBold) {
        this.fontBigBold = fontBigBold;
    }

    public String getPdfVersionImp() {
        return pdfVersionImp;
    }

    public void setPdfVersionImp(String pdfVersionImp) {
        this.pdfVersionImp = pdfVersionImp;
    }

    public String getTitle() {
        return title;
    }

    public void setTitle(String title) {
        this.title = title;
    }

    public String getAuthor() {
        return author;
    }

    public void setAuthor(String author) {
        this.author = author;
    }

    public String getSubject() {
        return subject;
    }

    public void setSubject(String subject) {
        this.subject = subject;
    }

    public String getKeywords() {
        return keywords;
    }

    public void setKeywords(String keywords) {
        this.keywords = keywords;
    }

    public String getCreator() {
        return creator;
    }

    public void setCreator(String creator) {
        this.creator = creator;
    }

}
