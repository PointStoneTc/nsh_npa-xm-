package nsh.xinmi.npa.util;

import com.itextpdf.text.BaseColor;
import com.itextpdf.text.Document;
import com.itextpdf.text.Element;
import com.itextpdf.text.Font;
import com.itextpdf.text.Phrase;
import com.itextpdf.text.pdf.BaseFont;
import com.itextpdf.text.pdf.ColumnText;
import com.itextpdf.text.pdf.PdfContentByte;
import com.itextpdf.text.pdf.PdfGState;
import com.itextpdf.text.pdf.PdfPageEventHelper;
import com.itextpdf.text.pdf.PdfWriter;

/**
 * 实现自定义的水印
 * 
 * @author 赵琦
 *
 */
public class CustomerWaterMark extends PdfPageEventHelper {
    private String text;
    private BaseFont baseFont;
    private Font font;
    private String footerTxt;

    public CustomerWaterMark() {}

    public CustomerWaterMark(String text, BaseFont baseFont, Font font, String footerTxt) {
        this.text = text;
        this.baseFont = baseFont;
        this.font = font;
        this.footerTxt = footerTxt;
    }

    @Override
    public void onStartPage(PdfWriter pdfWriter, Document document) {
        // 加入水印
        PdfContentByte waterMar = pdfWriter.getDirectContentUnder();
        // 开始设置水印
        waterMar.beginText();
        // 设置水印透明度
        PdfGState gs = new PdfGState();
        // 设置填充字体不透明度为0.4f
        gs.setFillOpacity(0.4f);
        try {
            waterMar.setFontAndSize(baseFont, 60);
            // 设置透明度
            waterMar.setGState(gs);
            // 设置水印对齐方式 水印内容 X坐标 Y坐标 旋转角度
            waterMar.showTextAligned(Element.ALIGN_TOP, text, 200, 400, 45);
            // 设置水印颜色
            waterMar.setColorFill(BaseColor.GRAY);
            // 结束设置
            waterMar.endText();
            waterMar.stroke();
        } finally {
            waterMar = null;
            gs = null;
        }

        super.onStartPage(pdfWriter, document);
    }

    @Override
    public void onEndPage(PdfWriter writer, Document document) {
        Phrase footer = new Phrase(footerTxt, font);

        // 3.计算前半部分的foot1的长度，后面好定位最后一部分的'Y页'这俩字的x轴坐标，字体长度也要计算进去 = len
        float len = baseFont.getWidthPoint(footerTxt, 12);

        // 4.拿到当前的PdfContentByte
        PdfContentByte cb = writer.getDirectContent();

        // 5.写入页脚1，x轴就是(右margin+左margin + right() -left()- len)/2.0F 再给偏移20F适合人类视觉感受，否则肉眼看上去就太偏左了
        // ,y轴就是底边界-20,否则就贴边重叠到数据体里了就不是页脚了；注意Y轴是从下往上累加的，最上方的Top值是大于Bottom好几百开外的。
        ColumnText.showTextAligned(cb, Element.ALIGN_LEFT, footer, (document.rightMargin() + document.right() + document.leftMargin() - document.left() - len) / 2.0F + 20F,
                document.bottom() - 20, 0);

        // 6.写入页脚2的模板（就是页脚的Y页这俩字）添加到文档中，计算模板的和Y轴,X=(右边界-左边界 - 前半部分的len值)/2.0F + len ， y 轴和之前的保持一致，底边界-20
        cb.addTemplate(writer.getDirectContent().createTemplate(150, 50), (document.rightMargin() + document.right() + document.leftMargin() - document.left()) / 2.0F + 20F,
                document.bottom() - 20); // 调节模版显示的位置
    }
}
