package nsh.xinmi.npa.util;

import java.io.File;
import java.io.FileOutputStream;
import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import org.jeecgframework.core.util.DateUtils;
import com.itextpdf.text.BaseColor;
import com.itextpdf.text.Chunk;
import com.itextpdf.text.Document;
import com.itextpdf.text.Element;
import com.itextpdf.text.Font;
import com.itextpdf.text.FontFactory;
import com.itextpdf.text.Paragraph;
import com.itextpdf.text.pdf.PdfPCell;
import com.itextpdf.text.pdf.PdfPTable;
import com.itextpdf.text.pdf.PdfWriter;
import nsh.xinmi.npa.loanContract.view.ViContractQyView;
import nsh.xinmi.npa.loanContractGuarantee.entity.LoanContractGuarantee;
import nsh.xinmi.npa.naturalPerson.entity.NaturalPerson;

public class PdfUtils {
    public static String waterMarkText = "河南省农村信用社";

    public static void main(String[] args) throws Exception {
        PdfConfig pdfConfig = PdfConfig.getInstance("c:\\1\\", "", "证明", "", "", "", "");
        List<ViContractQyView> lctList = new ArrayList<ViContractQyView>();

        ViContractQyView item1 = new ViContractQyView();
        ViContractQyView item2 = new ViContractQyView();

        item1.setId(1l); // 主键
        item1.setNumCode("102"); // 合同号
        item1.setBorrowerName("借款人1"); // 借款人
        item1.setIdNumber("借款人身份证号1"); // 借款人身份证号
        item1.setAmount(10000d); // 原贷金额
        item1.setAmountSurplus(10000d); // 贷款余额
        item1.setoInterestRate(1.36); // 原贷利率
        item1.setIssueDate(new Date()); // 贷款发放日
        item1.setDueDate(new Date()); // 贷款到期日
        item1.setInterestDate(new Date()); // 起息日
        item1.setAdjustInterestRate(1.36); // 调整利率
        item1.setOfficer("信贷员1"); // 信贷员
        item1.setCorporateOrgName("所属支行1"); // 所属支行
        item1.setGuaranteeMode("x"); // 担保方式
        item1.setDisposeMode("h"); // 处理方式
        item1.setHangInteres(100d); // 挂息金额
        List<LoanContractGuarantee> l1 = new ArrayList<LoanContractGuarantee>();
        LoanContractGuarantee t1 = new LoanContractGuarantee();
        NaturalPerson n1 = new NaturalPerson();
        n1.setName("n1");
        n1.setIdNumber("d1");
        t1.setGuarantee(n1);
        l1.add(t1);

        LoanContractGuarantee t2 = new LoanContractGuarantee();
        NaturalPerson n2 = new NaturalPerson();
        n2.setName("n2");
        n2.setIdNumber("d2");
        t2.setGuarantee(n2);
        l1.add(t2);
        item1.setLoanContractGuarantees(l1);


        item2.setId(1l); // 主键
        item2.setNumCode("103"); // 合同号
        item2.setBorrowerName("借款人2"); // 借款人
        item2.setIdNumber("借款人身份证号2"); // 借款人身份证号
        item2.setAmount(20000d); // 原贷金额
        item2.setAmountSurplus(20000d); // 贷款余额
        item2.setoInterestRate(2.36); // 原贷利率
        item2.setIssueDate(new Date()); // 贷款发放日
        item2.setDueDate(new Date()); // 贷款到期日
        item2.setInterestDate(new Date()); // 起息日
        item2.setAdjustInterestRate(2.36); // 调整利率
        item2.setOfficer("信贷员2"); // 信贷员
        item2.setCorporateOrgName("所属支行2"); // 所属支行
        item2.setGuaranteeMode("d"); // 担保方式
        item2.setDisposeMode("y"); // 处理方式
        item2.setHangInteres(200d); // 挂息金额
        List<LoanContractGuarantee> l2 = new ArrayList<LoanContractGuarantee>();
        item2.setLoanContractGuarantees(l2);

        lctList.add(item1);
        lctList.add(item2);
        String nfParam = "1,3,3,4路不累,高飞";
        turnToPdf(pdfConfig, lctList, nfParam, new Date().getTime() + "");
    }

    private static PdfPCell getCell(String content, int rowSpan, int colSpan, boolean isHead, PdfConfig pdfConfig) {
        PdfPCell cell = new PdfPCell(new Paragraph(content, pdfConfig.getFont()));

        if (isHead) {
            cell.setHorizontalAlignment(Element.ALIGN_RIGHT);
            cell.setVerticalAlignment(Element.ALIGN_MIDDLE);
            cell.setBackgroundColor(new BaseColor(51, 196, 246));
            cell.setPaddingRight(10);
        } else {
            cell.setHorizontalAlignment(Element.ALIGN_LEFT);
            cell.setVerticalAlignment(Element.ALIGN_MIDDLE);
            cell.setPaddingLeft(10);
        }

        if (rowSpan != 0)
            cell.setRowspan(rowSpan);
        if (colSpan != 0)
            cell.setColspan(colSpan);

        return cell;
    }

    public static String turnToPdf(PdfConfig pdfConfig, List<ViContractQyView> lctList, String nfParam, String fileName) {
        File file = new File(pdfConfig.getDocment_basePath());
        if (!file.exists()) {
            file.mkdirs();
        }
        String realPath = "";

        try {
            // 创建文件
            Document document = new Document(pdfConfig.getDocment_page_size(), pdfConfig.getDocment_margin_left(), pdfConfig.getDocment_margin_right(),
                    pdfConfig.getDocment_margin_top(), pdfConfig.getDocment_margin_bottom());

            document.addAuthor(pdfConfig.getAuthor());
            document.addTitle(pdfConfig.getTitle());
            document.addSubject(pdfConfig.getSubject());
            document.addKeywords(pdfConfig.getKeywords());

            // 建立一个书写器
            realPath = pdfConfig.getDocment_basePath() + fileName + ".pdf";
            PdfWriter pdfWriter = PdfWriter.getInstance(document, new FileOutputStream(realPath));
            // 打开文件
            pdfWriter.setPageEvent(new CustomerWaterMark(waterMarkText, pdfConfig.getBfChinese()));
            document.open();

            // 添加主题
            Paragraph title = new Paragraph(pdfConfig.getTitle(), pdfConfig.getFontBigBold());
            title.setAlignment(Element.ALIGN_CENTER);
            title.setSpacingBefore(5f); // 设置上面空白
            title.setSpacingAfter(10f); // 设置段落下空白
            document.add(title);

            document.add(new Paragraph("查询到的人:", pdfConfig.getFontBigBold()));
            for (ViContractQyView item : lctList) {
                PdfPTable table = new PdfPTable(6);
                float[] columnWidths = {1, 1, 1, 1, 1, 1};
                table.setWidths(columnWidths);
                table.setWidthPercentage(100); // 宽度100%填充
                table.setSpacingBefore(10f); // 前间距
                table.setSpacingAfter(10f); // 后间距

                // 行1
                table.addCell(getCell("档案编号 [" + item.getNumCode() + "]", 0, 6, false, pdfConfig));

                // 行2
                table.addCell(getCell("借款人姓名", 0, 0, true, pdfConfig));
                table.addCell(getCell(item.getBorrowerName(), 0, 2, false, pdfConfig));
                table.addCell(getCell("借款人身份证号", 0, 0, true, pdfConfig));
                table.addCell(getCell(item.getIdNumber(), 0, 2, false, pdfConfig));

                // 行3
                table.addCell(getCell("担保人姓名", 0, 0, true, pdfConfig));
                table.addCell(getCell(item.getGuaranteesName(), 0, 2, false, pdfConfig));
                table.addCell(getCell("担保人身份证号", 0, 0, true, pdfConfig));
                table.addCell(getCell(item.getGuaranteesIdNumber(), 0, 2, false, pdfConfig));

                // 行4
                table.addCell(getCell("原贷金额(元)", 0, 0, true, pdfConfig));
                table.addCell(getCell("￥" + String.valueOf(item.getAmount()), 0, 0, false, pdfConfig));
                table.addCell(getCell("贷款余额(元)", 0, 0, true, pdfConfig));
                table.addCell(getCell("￥" + String.valueOf(item.getAmountSurplus()), 0, 0, false, pdfConfig));
                table.addCell(getCell("原贷利率(‰)", 0, 0, true, pdfConfig));
                table.addCell(getCell(String.valueOf(item.getoInterestRate()), 0, 0, false, pdfConfig));

                // 行5
                table.addCell(getCell("贷款发放日", 0, 0, true, pdfConfig));
                table.addCell(getCell(DateUtils.date2Str(item.getIssueDate(), DateUtils.date_sdf), 0, 0, false, pdfConfig));
                table.addCell(getCell("贷款到期日", 0, 0, true, pdfConfig));
                table.addCell(getCell(DateUtils.date2Str(item.getDueDate(), DateUtils.date_sdf), 0, 0, false, pdfConfig));
                table.addCell(getCell("信贷员", 0, 0, true, pdfConfig));
                table.addCell(getCell(item.getOfficer(), 0, 0, false, pdfConfig));

                // 行6
                table.addCell(getCell("所属支行", 0, 0, true, pdfConfig));
                table.addCell(getCell(item.getCorporateOrgName(), 0, 0, false, pdfConfig));
                table.addCell(getCell("诉讼方式", 0, 0, true, pdfConfig));
                table.addCell(getCell(item.getLitigationStat_s(), 0, 0, false, pdfConfig));
                table.addCell(getCell("担保方式", 0, 0, true, pdfConfig));
                table.addCell(getCell(item.getGuaranteeMode_s(), 0, 0, false, pdfConfig));

                // 行7
                table.addCell(getCell("处理方式", 0, 0, true, pdfConfig));
                table.addCell(getCell(item.getDisposeMode_s(), 0, 0, false, pdfConfig));
                table.addCell(getCell("起息日", 0, 0, true, pdfConfig));
                table.addCell(getCell(DateUtils.date2Str(item.getInterestDate(), DateUtils.date_sdf), 0, 0, false, pdfConfig));
                table.addCell(getCell("调整利率(‰)", 0, 0, true, pdfConfig));
                table.addCell(getCell(String.valueOf(item.getAdjustInterestRate()), 0, 0, false, pdfConfig));

                // 行8
                table.addCell(getCell("挂息(元)", 0, 0, true, pdfConfig));
                table.addCell(getCell("￥" + String.valueOf(item.getHangInteres()), 0, 5, false, pdfConfig));
                // 把表格添加到文件中
                document.add(table);
            }

            document.add(new Paragraph("没有查询到的人:", pdfConfig.getFontBigBold()));

            PdfPTable nfTable = new PdfPTable(2);
            float[] columnWidths = {2, 8};
            nfTable.setWidths(columnWidths);
            nfTable.setWidthPercentage(100); // 宽度100%填充
            nfTable.setSpacingBefore(10f); // 前间距
            nfTable.setSpacingAfter(10f); // 后间距

            nfTable.addCell(getCell("序号", 0, 0, false, pdfConfig));
            nfTable.addCell(getCell("名称", 0, 0, false, pdfConfig));
            int i = 0;
            for (String item : nfParam.split(",")) {
                nfTable.addCell(getCell(String.valueOf(++i), 0, 0, false, pdfConfig));
                nfTable.addCell(getCell(item, 0, 0, false, pdfConfig));
            }
            document.add(nfTable);
            document.close();
        } catch (Exception e) {
            e.printStackTrace();
        }

        return realPath;
    }

    /**
     * 设置下划线
     *
     * @return
     */
    public static Chunk getChunk(String str) {
        // 创建Chunk对象，设置下划线的厚度为0.1
        Chunk underline = new Chunk(str);
        underline.setUnderline(0.1f, -1f);
        // 创建Chunk对象，设置下划线的厚度为1
        Chunk strike = new Chunk(str);
        strike.setUnderline(1f, 3f);
        return underline;
    }

    /**
     * 设置段落居中
     *
     * @return
     */
    public static Paragraph getParagraph(String str) {
        Paragraph pg = new Paragraph(str, FontFactory.getFont(FontFactory.COURIER, 16, Font.BOLD));
        pg.setAlignment(1);
        return pg;
    }

    /**
     * 设置下划线段落居中
     *
     * @param str
     * @return
     */
    public static Paragraph getParagraph2(String str) {
        Paragraph pg = new Paragraph(getChunk(str));
        pg.setAlignment(1);
        return pg;
    }

    /**
     * 设置下划线段落居中加大字体
     *
     * @param str
     * @return
     */
    public static Paragraph getParagraph3(String str) {
        Paragraph pg = new Paragraph(getChunk(str));
        pg.setFont(FontFactory.getFont(FontFactory.COURIER, 18, Font.BOLD));
        pg.setAlignment(1);
        return pg;
    }


    /**
     * 中间段落
     *
     * @return @throws
     */
    public static Paragraph midelParagraph() {
        Paragraph manufacturer = getParagraph2("Manufacturer");
        manufacturer.setSpacingBefore(25); // 设置行距
        return manufacturer;
    }

}
