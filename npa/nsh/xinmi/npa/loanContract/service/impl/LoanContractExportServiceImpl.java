package nsh.xinmi.npa.loanContract.service.impl;

import java.io.File;
import java.io.FileOutputStream;
import java.io.IOException;
import java.util.Date;
import java.util.List;
import java.util.Map;
import java.util.Optional;
import org.apache.poi.ss.usermodel.CellStyle;
import org.apache.poi.ss.usermodel.IndexedColors;
import org.apache.poi.xssf.usermodel.XSSFCell;
import org.apache.poi.xssf.usermodel.XSSFCellStyle;
import org.apache.poi.xssf.usermodel.XSSFRow;
import org.apache.poi.xssf.usermodel.XSSFSheet;
import org.apache.poi.xssf.usermodel.XSSFWorkbook;
import org.jeecgframework.core.common.service.impl.CommonServiceImpl;
import org.jeecgframework.core.util.DateUtils;
import org.jeecgframework.core.util.ResourceUtil;
import org.jeecgframework.web.system.pojo.base.TSUser;
import org.jeecgframework.web.system.service.UserService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import nsh.xinmi.npa.corporateOrg.entity.CorporateOrgUser;
import nsh.xinmi.npa.corporateOrg.service.CorporateOrgUserServiceI;
import nsh.xinmi.npa.loanContract.service.LoanContractExportServiceI;

@Service("loanContractExportService")
public class LoanContractExportServiceImpl extends CommonServiceImpl implements LoanContractExportServiceI {
  private static final Logger log = LoggerFactory.getLogger(LoanContractExportServiceImpl.class);

  @Autowired
  private UserService userService;

  @Autowired
  private CorporateOrgUserServiceI corporateOrgUserService;

  @Override
  public String all(String fileSavePath) {
    StringBuilder sql = new StringBuilder(
        "select c.id, c.num_code, c.customer_no, c.lou_no, c.borrower_name, p.id_number,if(c.is_impersonate = 0, '否', '是') is_impersonate, c.amount, c.issue_date, c.due_date, c.interest_rate, ") //
            .append("date_add(c.due_date, interval 90 day) unhealthy_date, ") //
            .append("c.officer, c.corporate_org_name, ") //            
            .append("CASE c.guarantee_mode WHEN 'x' THEN '信用' WHEN 'b' THEN '保证' WHEN 'd' THEN '抵押' WHEN 'f' THEN '复合' ELSE '' END guarantee_mode, ") //
            .append("CASE c.dispose_mode WHEN 'h' THEN '核销贷款' WHEN 't' THEN '土地置换' WHEN 'y' THEN '央票置换' ELSE '' END dispose_mode, ") //
            .append(
                "CASE c.litigation_stat WHEN 'n' THEN '未诉讼' WHEN 'l' THEN '立案' WHEN 'f' THEN '一审' WHEN 's' THEN '二审' WHEN 'g' THEN '再审' WHEN '调解' THEN '调解' WHEN 'e' THEN '诉讼终结' WHEN 'i' THEN '申请执行' WHEN 'a' THEN '执行' WHEN 'b' THEN '中止执行'  WHEN 'c' THEN '终止本次执行'  WHEN 'd' THEN '执行终结' ELSE '' END litigation_stat, ") //
            .append("c.stat, c.interest_date, c.recovery_principal, c.recovery_interest, c.hang_interes, t.guarantee_name, t.guarantee_idnumber, ")
            .append("if(ce.is_submit = 0, '否', '是') is_error ") //
            .append("from npa_loan_contract c left join npa_natural_person p on c.borrower_id = p.id ") //
            .append(
                "LEFT JOIN  (select  loan_contrac_id , GROUP_CONCAT(g.guarantee_name) guarantee_name, GROUP_CONCAT(p.id_number) guarantee_idnumber from npa_loan_contract_guarantee g ")
            .append("LEFT JOIN npa_natural_person p ON g.guarantee_id = p.id group  by g.loan_contrac_id) t ON c.id = t.loan_contrac_id ")
            .append("LEFT JOIN npa_loan_contract_error ce ON ce.loan_contract_id = c.id");

    // 根据用户过滤查看的数据,只有admin可以查看所有的,其它用户只能查看自己所属支行的数据
    TSUser loginUser = ResourceUtil.getSessionUser();
    String userRoles = userService.getUserRole(loginUser);
    String npa_mag_role_code = ResourceUtil.getConfigByName("npa_mag_role_code");

    if (!"admin".equals(loginUser.getUserName()) && userRoles.indexOf(npa_mag_role_code) == -1) {
      List<CorporateOrgUser> couList = corporateOrgUserService.findByProperty(CorporateOrgUser.class, "userid", loginUser.getId());
      if (couList.size() == 0)
        sql.append("where c.corporate_org_id = -1");
      else {
        sql.append("where c.corporate_org_id in (");
        for (CorporateOrgUser cou : couList)
          sql.append(cou.getCorporateOrgId()).append(",");
        sql.deleteCharAt(sql.lastIndexOf(","));
        sql.append(")");
      }
    }

    // 查询数据总数,如果总数等于退出
    int count = (int) getCountForJdbc("select count(1) from (" + sql.toString() + ") t").longValue();
    int page = 0, pagesize = 1000;
    page = count / pagesize + (count % pagesize > 0 ? 1 : 0);

    // 创建xls
    String[] titles = new String[] {"序号", "档案编号", "客户号", "借据号", "借款人姓名", "借款人身份证号", "是否借冒名", "担保人姓名", "担保人身份证号", "贷款金额(元)", "贷款发放日", "贷款到期日", "利率(‰)", "不良形成日期", "信贷员", "所属支行",
        "诉讼状态", "担保方式", "处理方式", "起息日", "收回本金(元)", "收回利息(元)", "挂息(元)", "是否正式数据"};
    String[] vals = new String[] {"num_code", "customer_no", "c.lou_no", "borrower_name", "id_number", "is_impersonate", "guarantee_name", "guarantee_idnumber", "amount",
        "issue_date", "due_date", "interest_rate", "unhealthy_date", "officer", "corporate_org_name", "litigation_stat", "guarantee_mode", "dispose_mode", "interest_date",
        "recoveryPrincipal", "recovery_interest", "hang_interes", "is_error"};
    int rowHeightInPoints = 24;
    XSSFWorkbook workbook = new XSSFWorkbook();
    XSSFSheet sheet = workbook.createSheet("全部档案");
    XSSFRow row = sheet.createRow(0);
    row.setHeightInPoints(rowHeightInPoints);

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

    int index = 1;
    for (int i = 1; i <= page; i++) {
      log.info("第" + i + "次导出");
      List<Map<String, Object>> rs = findForJdbc(sql.toString(), i, pagesize);
      for (int y = 0; y < rs.size(); y++) {
        row = sheet.createRow(y + (i - 1) * pagesize + 1);
        row.setHeightInPoints(rowHeightInPoints);
        XSSFCell cell = row.createCell(0);
        cell.setCellValue(index++);
        for (int x = 0; x < vals.length; x++) {
          cell = row.createCell(x + 1);
          cell.setCellValue(Optional.ofNullable(rs.get(y).get(vals[x])).orElse("") + "");
        }
      }

      log.info("导出数据:" + rs.size() + "行");
    }

    String fileName = String.valueOf(new Date().getTime()) + ".xlsx";
    File file = new File(fileSavePath + fileName);
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

    return fileName;
  }

  @Override
  public String recovery(Date startDate, Date endDate, String fileSavePath) {
    StringBuilder sql = new StringBuilder(
        "select o.code corporate_org_code, o.name corporate_org_name, c.customer_no, c.num_code, c.borrower_name, '身份证' borrower_zj_type, p.id_number, c.lou_no, c.amount, ") //
            .append(
                "IFNULL((select c.amount - sum(rm.recovery_principal) from npa_recovery_money rm where rm.loan_contrac_id = m.loan_contrac_id AND rm.recovery_date <= m.recovery_date), 0 ) jjye, ")
            .append("m.recovery_principal, m.recovery_interest, c.issue_date, c.due_date, ") //
            .append("date_add(c.due_date, interval 90 day) unhealthy_date, m.recovery_date, ") //
            .append("CASE c.guarantee_mode WHEN 'x' THEN '信用' WHEN 'b' THEN '保证' WHEN 'd' THEN '抵押' WHEN 'f' THEN '复合' ELSE '' END guarantee_mode, ") //
            .append("'' wjfl, c.officer, ") //
            .append(
                "CASE c.litigation_stat WHEN 'n' THEN '未诉讼' WHEN 'l' THEN '立案' WHEN 'f' THEN '一审' WHEN 's' THEN '二审' WHEN 'g' THEN '再审' WHEN '调解' THEN '调解' WHEN 'e' THEN '诉讼终结' WHEN 'i' THEN '申请执行' WHEN 'a' THEN '执行' WHEN 'b' THEN '中止执行'  WHEN 'c' THEN '终止本次执行'  WHEN 'd' THEN '执行终结' ELSE '' END litigation_stat, ") //
            .append("CASE c.dispose_mode WHEN 'h' THEN '核销贷款' WHEN 't' THEN '土地置换' WHEN 'y' THEN '央票置换' ELSE '' END dispose_mode ") //
            .append("from npa_loan_contract c JOIN npa_corporate_org o ON o.id = c.corporate_org_id ") //
            .append("JOIN npa_recovery_money m ON c.id = m.loan_contrac_id ") //
            .append("LEFT JOIN npa_natural_person p ON c.borrower_id = p.id ") //
            .append("where m.recovery_date BETWEEN '").append(DateUtils.formatDate(startDate, "yyyy-MM-dd")).append("' AND ");

    if (null == endDate)
      sql.append("NOW() ");
    else
      sql.append("'").append(DateUtils.formatDate(endDate, "yyyy-MM-dd")).append("' ");

    // 根据用户过滤查看的数据,只有admin可以查看所有的,其它用户只能查看自己所属支行的数据
    TSUser loginUser = ResourceUtil.getSessionUser();
    String userRoles = userService.getUserRole(loginUser);
    String npa_mag_role_code = ResourceUtil.getConfigByName("npa_mag_role_code");

    if (!"admin".equals(loginUser.getUserName()) && userRoles.indexOf(npa_mag_role_code) == -1) {
      List<CorporateOrgUser> couList = corporateOrgUserService.findByProperty(CorporateOrgUser.class, "userid", loginUser.getId());
      if (couList.size() == 0)
        sql.append("and c.corporate_org_id = -1");
      else {
        sql.append("and c.corporate_org_id in (");
        for (CorporateOrgUser cou : couList)
          sql.append(cou.getCorporateOrgId()).append(",");
        sql.deleteCharAt(sql.lastIndexOf(","));
        sql.append(")");
      }
    }

    // 创建xls
    String[] titles = new String[] {"序号", "机构代码", "机构名称", "客户号", "客户姓名", "证件类型", "证件号码", "借据号", "借据金额(元)", "借据余额(元)", "本次收回本金(元)", "本次收回利息(元)", "开始日期", "到期日期", "不良形成日期",
        "现金收回发生日期", "担保方式", "五级分类", "客户经理", "诉讼状态", "形态（核销贷款、土地置换、票据置换)"};
    String[] vals =
        new String[] {"corporate_org_code", "corporate_org_name", "customer_no", "borrower_name", "borrower_zj_type", "id_number", "lou_no", "amount", "jjye", "recovery_principal",
            "recovery_interest", "issue_date", "due_date", "unhealthy_date", "recovery_date", "guarantee_mode", "wjfl", "officer", "litigation_stat", "dispose_mode"};
    int rowHeightInPoints = 24;
    XSSFWorkbook workbook = new XSSFWorkbook();
    XSSFSheet sheet = workbook.createSheet("回收款历史");
    XSSFRow row = sheet.createRow(0);
    row.setHeightInPoints(rowHeightInPoints);

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

    int rowOffset = 1, index = 1;
    sql.append(" order by m.loan_contrac_id, m.recovery_date DESC ");
    List<Map<String, Object>> rs = findForJdbc(sql.toString());
    for (int i = 0; i < rs.size(); i++) {
      row = sheet.createRow(i + rowOffset);
      row.setHeightInPoints(rowHeightInPoints);
      XSSFCell cell = row.createCell(0);
      cell.setCellValue(index++);
      for (int x = 0; x < vals.length; x++) {
        cell = row.createCell(x + 1);
        cell.setCellValue(Optional.ofNullable(rs.get(i).get(vals[x])).orElse("") + "");
      }
    }

    log.info("导出数据:" + rs.size() + "行");

    String fileName = String.valueOf(new Date().getTime()) + ".xlsx";
    File file = new File(fileSavePath + fileName);
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

    return fileName;
  }

}
