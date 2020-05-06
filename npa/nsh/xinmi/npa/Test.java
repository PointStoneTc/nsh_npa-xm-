package nsh.xinmi.npa;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.math.BigDecimal;
import java.util.Date;
import org.apache.poi.ss.usermodel.CellStyle;
import org.apache.poi.ss.usermodel.IndexedColors;
import org.apache.poi.xssf.usermodel.XSSFCell;
import org.apache.poi.xssf.usermodel.XSSFCellStyle;
import org.apache.poi.xssf.usermodel.XSSFRow;
import org.apache.poi.xssf.usermodel.XSSFSheet;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;

public class Test {
  private static final Logger log = LoggerFactory.getLogger(Test.class);

  public static String t() {
    // 创建xls
    String[] titles = new String[] {"id", "贷款金额", "借据余额", "本次收回本金(元)"};
    String[][] vals = new String[][] {{"1", "1000", "100", "10"}, {"1", "1000", "100", "10"}, {"1", "1000", "100", "10"}, {"2", "1500", "100", "11"}, {"2", "1500", "100", "22"},
        {"3", "2000", "100", "33"}};


    int rowHeightInPoints = 24;
    XSSFWorkbook workbook = new XSSFWorkbook();
    XSSFSheet sheet = workbook.createSheet("回收款历史");
    XSSFRow row = sheet.createRow(0);
    row.setHeightInPoints(rowHeightInPoints);

    log.info(">>>>>开始生成excel");
    for (int i = 0; i < titles.length; i++) {
      XSSFCell cell = row.createCell(i);
      cell.setCellValue(titles[i]);
      XSSFCellStyle cellStyle = workbook.createCellStyle();
      cellStyle.setFillBackgroundColor(IndexedColors.AQUA.getIndex());
      cellStyle.setAlignment(CellStyle.ALIGN_CENTER);
      cellStyle.setVerticalAlignment(CellStyle.VERTICAL_CENTER);
      cell.setCellStyle(cellStyle);
      sheet.autoSizeColumn(i);
      sheet.setColumnWidth(i, sheet.getColumnWidth(i) * 17 / 10);
    }

    String tid = null;
    for (int x = 0; x < vals.length; x++) {
      row = sheet.createRow(x + 1);
      row.setHeightInPoints(rowHeightInPoints);

      for (int y = 0; y < vals[x].length; y++) {
        XSSFCell cell = row.createCell(y);
        if (y == 2) {
          if (tid == null) { //第一次插入数据
            cell.setCellValue(vals[x][2]);
          } else {
            if (tid.equals(vals[x][0])) { //同组数据
              cell.setCellFormula("C" + (x + 1) + "-D" + (x + 2));
            } else { //不同组数据,且是第一次插入
              cell.setCellValue(vals[x][2]);
            }
          }
        } else {
          cell.setCellValue(vals[x][y]);
        }
      }

      tid = vals[x][0];
    }

    String fileName = String.valueOf(new Date().getTime()) + ".xlsx";
    File file = new File("d:\\1\\export_" + fileName);
    FileOutputStream stream = null;
    try {
      stream = new FileOutputStream(file);
      workbook.write(stream);
    } catch (Exception e) {
      e.printStackTrace();
      return null;
    } finally {
      if (stream != null)
        try {
          stream.close();
        } catch (IOException e) {
          e.printStackTrace();
        }
    }

    log.info(">>>>>生成完毕:" + fileName);
    return fileName;
  }

  public static void main(String[] args) {
    t();
  }
}
