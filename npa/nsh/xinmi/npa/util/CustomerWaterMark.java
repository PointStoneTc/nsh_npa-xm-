package nsh.xinmi.npa.util;

import com.itextpdf.text.BaseColor;
import com.itextpdf.text.Document;
import com.itextpdf.text.Element;
import com.itextpdf.text.pdf.BaseFont;
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
    private BaseFont font;

    public CustomerWaterMark() {}

    public CustomerWaterMark(String text, BaseFont font) {
        this.text = text;
        this.font = font;
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
            waterMar.setFontAndSize(font, 60);
            // 设置透明度
            waterMar.setGState(gs);
            // 设置水印对齐方式 水印内容 X坐标 Y坐标 旋转角度
            waterMar.showTextAligned(Element.ALIGN_RIGHT, text, 500, 430, 45);
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
}
