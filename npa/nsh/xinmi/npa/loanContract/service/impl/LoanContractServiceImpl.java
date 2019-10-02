package nsh.xinmi.npa.loanContract.service.impl;

import java.util.ArrayList;
import java.util.Date;
import java.util.HashMap;
import java.util.List;
import java.util.Map;
import org.jeecgframework.core.common.model.json.DataGrid;
import org.jeecgframework.core.common.service.impl.CommonServiceImpl;
import org.jeecgframework.core.util.DateUtils;
import org.jeecgframework.core.util.MyBeanUtils;
import org.jeecgframework.core.util.ResourceUtil;
import org.jeecgframework.core.util.oConvertUtils;
import org.jeecgframework.web.system.pojo.base.TSUser;
import org.jeecgframework.web.system.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import jodd.bean.BeanUtil;
import nsh.xinmi.npa.corporateOrg.entity.CorporateOrgUser;
import nsh.xinmi.npa.corporateOrg.service.CorporateOrgUserServiceI;
import nsh.xinmi.npa.loanContract.entity.LoanContract;
import nsh.xinmi.npa.loanContract.service.LoanContractServiceI;
import nsh.xinmi.npa.loanContract.view.LoanContractRecallView;
import nsh.xinmi.npa.loanContract.view.LoanContractRegisterView;
import nsh.xinmi.npa.loanContract.view.LoanContractView;
import nsh.xinmi.npa.loanContract.view.ViContractQyView;
import nsh.xinmi.npa.loanContractGuarantee.entity.LoanContractGuarantee;
import nsh.xinmi.npa.loanContractGuarantee.service.LoanContractGuaranteeServiceI;
import nsh.xinmi.npa.naturalPerson.entity.NaturalPerson;
import nsh.xinmi.npa.naturalPerson.service.NaturalPersonServiceI;
import nsh.xinmi.npa.recoveryMoney.service.RecoveryMoneyServiceI;
import nsh.xinmi.npa.util.PdfConfig;
import nsh.xinmi.npa.util.PdfUtils;

@Service("loanContractService")
@Transactional
public class LoanContractServiceImpl extends CommonServiceImpl implements LoanContractServiceI {
  @Autowired
  private NaturalPersonServiceI naturalPersonService;

  @Autowired
  private LoanContractGuaranteeServiceI loanContractGuaranteeService;

  @Autowired
  private RecoveryMoneyServiceI recoveryMoneyService;

  @Autowired
  private CorporateOrgUserServiceI corporateOrgUserService;

  @Autowired
  private UserService userService;

  @Override
  public void getLoanContractRecallList(LoanContractRegisterView loanContractRegisterView, DataGrid dataGrid) {
    StringBuffer sql = new StringBuffer(
        "select c.id, c.num_code, c.customer_no, c.lou_no, c.borrower_name, p.id_number, c.is_impersonate, c.amount, c.issue_date, c.due_date, c.interest_rate, c.officer, c.corporate_org_name, c.litigation_stat, c.guarantee_mode, c.dispose_mode, c.recovery_principal, c.interest_date, c.recovery_interest, c.hang_interes, c.create_by, c.create_date ")
            .append("from npa_loan_contract c, npa_natural_person p where c.borrower_id = p.id and c.stat = 'n' and c.is_submit = '1' and c.is_delete = '0'");
    if (oConvertUtils.isNotEmpty(loanContractRegisterView.getBorrowerName())) // 借款人
      sql.append(" and c.borrower_name like '%").append(loanContractRegisterView.getBorrowerName()).append("%'");

    if (oConvertUtils.isNotEmpty(loanContractRegisterView.getIdNumber())) // 身份证号
      sql.append(" and p.id_number = '").append(loanContractRegisterView.getIdNumber()).append("'");

    if (oConvertUtils.isNotEmpty(loanContractRegisterView.getNumCode())) // 合同编号
      sql.append(" and c.num_code = '").append(loanContractRegisterView.getNumCode()).append("'");

    // 根据用户过滤查看的数据,只有admin,或者npa_admin的管理员可以查看所有的,其它用户只能查看自己所属支行的数据
    TSUser loginUser = ResourceUtil.getSessionUser();
    String userRoles = userService.getUserRole(loginUser);
    String npa_mag_role_code = ResourceUtil.getConfigByName("npa_mag_role_code");

    if (!"admin".equals(loginUser.getUserName()) && userRoles.indexOf(npa_mag_role_code) == -1) {
      List<CorporateOrgUser> couList = corporateOrgUserService.findByProperty(CorporateOrgUser.class, "userid", loginUser.getId());
      if (couList.size() == 0)
        sql.append(" and c.corporate_org_id = -1");
      else {
        sql.append(" and c.corporate_org_id in (");
        for (CorporateOrgUser cou : couList)
          sql.append(cou.getCorporateOrgId()).append(",");
        sql.deleteCharAt(sql.lastIndexOf(","));
        sql.append(")");
      }
    }

    Long count = getCountForJdbc("select count(1) from (" + sql.toString() + ") t");
    List<Map<String, Object>> rs = findForJdbc(sql.toString(), dataGrid.getPage(), dataGrid.getRows());
    List<LoanContract> list = new ArrayList<LoanContract>();
    for (Map<String, Object> rsMap : rs) {
      LoanContract lc = new LoanContract();
      BeanUtil.setProperty(lc, "id", rsMap.get("id"));
      BeanUtil.setProperty(lc, "numCode", rsMap.get("num_code"));
      BeanUtil.setProperty(lc, "customerNo", rsMap.get("customer_no"));
      BeanUtil.setProperty(lc, "louNo", rsMap.get("lou_no"));
      BeanUtil.setProperty(lc, "borrowerName", rsMap.get("borrower_name"));
      NaturalPerson borrower = new NaturalPerson();
      BeanUtil.setProperty(borrower, "idNumber", rsMap.get("id_number"));
      BeanUtil.setProperty(lc, "isImpersonate", rsMap.get("is_impersonate"));
      BeanUtil.setProperty(lc, "amount", rsMap.get("amount"));
      BeanUtil.setProperty(lc, "issueDate", rsMap.get("issue_date"));
      BeanUtil.setProperty(lc, "dueDate", rsMap.get("due_date"));
      BeanUtil.setProperty(lc, "interestRate", rsMap.get("interest_rate"));
      BeanUtil.setProperty(lc, "officer", rsMap.get("officer"));
      BeanUtil.setProperty(lc, "corporateOrgName", rsMap.get("corporate_org_name"));
      BeanUtil.setProperty(lc, "litigationStat", rsMap.get("litigation_stat"));
      BeanUtil.setProperty(lc, "guaranteeMode", rsMap.get("guarantee_mode"));
      BeanUtil.setProperty(lc, "disposeMode", rsMap.get("dispose_mode"));
      BeanUtil.setProperty(lc, "interestDate", rsMap.get("interest_date"));
      BeanUtil.setProperty(lc, "recoveryPrincipal", rsMap.get("recovery_principal"));
      BeanUtil.setProperty(lc, "recoveryInterest", rsMap.get("recovery_interest"));
      BeanUtil.setProperty(lc, "hangInteres", rsMap.get("hang_interes"));
      BeanUtil.setProperty(lc, "createBy", rsMap.get("create_by"));
      BeanUtil.setProperty(lc, "createDate", rsMap.get("create_date"));
      lc.setBorrower(borrower);
      list.add(lc);
    }

    dataGrid.setTotal(count.intValue());
    dataGrid.setResults(list);
  }

  @Override
  public LoanContractRecallView getLoanContractRecallView(Long id) {
    LoanContractRecallView loanContractRecallLoanView = new LoanContractRecallView();
    LoanContract loanContract = get(LoanContract.class, id); // 合同信息
    loanContractRecallLoanView.setLoanContract(loanContract);
    loanContractRecallLoanView.setRecoveryMoneies(recoveryMoneyService.getListByContractId(id)); // 收回款
    return loanContractRecallLoanView;
  }

  @Override
  public void getLoanContractRegisterList(LoanContractRegisterView loanContractRegisterView, DataGrid dataGrid) {
    StringBuffer sql = new StringBuffer(
        "select c.id, c.num_code, c.customer_no, c.lou_no, c.borrower_name, p.id_number,c.is_impersonate, c.amount, c.issue_date, c.due_date, c.interest_rate, c.officer, c.corporate_org_name, c.guarantee_mode, c.dispose_mode, c.litigation_stat, c.stat, c.interest_date, c.recovery_principal, c.recovery_interest, c.hang_interes, c.is_submit, c.create_by, c.create_date")
            .append(" from npa_loan_contract c, npa_natural_person p").append(" where c.borrower_id = p.id and c.is_delete = '0'");
    if (oConvertUtils.isNotEmpty(loanContractRegisterView.getBorrowerName())) // 借款人
      sql.append(" and c.borrower_name like '%").append(loanContractRegisterView.getBorrowerName()).append("%'");

    if (oConvertUtils.isNotEmpty(loanContractRegisterView.getIdNumber())) // 身份证号
      sql.append(" and p.id_number = '").append(loanContractRegisterView.getIdNumber()).append("'");

    if (oConvertUtils.isNotEmpty(loanContractRegisterView.getNumCode())) // 合同编号
      sql.append(" and c.num_code = '").append(loanContractRegisterView.getNumCode()).append("'");

    if (oConvertUtils.isNotEmpty(loanContractRegisterView.getOfficer())) // 信贷员
      sql.append(" and c.officer = '").append(loanContractRegisterView.getOfficer()).append("'");

    if (oConvertUtils.isNotEmpty(loanContractRegisterView.getStat())) // 合同状态
      sql.append(" and c.stat = '").append(loanContractRegisterView.getStat()).append("'");

    // 根据用户过滤查看的数据,只有admin可以查看所有的,其它用户只能查看自己所属支行的数据
    TSUser loginUser = ResourceUtil.getSessionUser();
    String userRoles = userService.getUserRole(loginUser);
    String npa_mag_role_code = ResourceUtil.getConfigByName("npa_mag_role_code");

    if (!"admin".equals(loginUser.getUserName()) && userRoles.indexOf(npa_mag_role_code) == -1) {
      List<CorporateOrgUser> couList = corporateOrgUserService.findByProperty(CorporateOrgUser.class, "userid", loginUser.getId());
      if (couList.size() == 0)
        sql.append(" and c.corporate_org_id = -1");
      else {
        sql.append(" and c.corporate_org_id in (");
        for (CorporateOrgUser cou : couList)
          sql.append(cou.getCorporateOrgId()).append(",");
        sql.deleteCharAt(sql.lastIndexOf(","));
        sql.append(")");
      }
    }

    Long count = getCountForJdbc("select count(1) from (" + sql.toString() + ") t");
    List<Map<String, Object>> rs = findForJdbc(sql.toString(), dataGrid.getPage(), dataGrid.getRows());
    List<LoanContractRegisterView> list = new ArrayList<LoanContractRegisterView>();
    Map<Long, LoanContractRegisterView> tempMap = new HashMap<Long, LoanContractRegisterView>();

    for (Map<String, Object> rsMap : rs) {
      LoanContractRegisterView lcv = new LoanContractRegisterView();
      BeanUtil.setProperty(lcv, "id", rsMap.get("id"));
      BeanUtil.setProperty(lcv, "numCode", rsMap.get("num_code"));
      BeanUtil.setProperty(lcv, "customerNo", rsMap.get("customer_no"));
      BeanUtil.setProperty(lcv, "louNo", rsMap.get("lou_no"));
      BeanUtil.setProperty(lcv, "borrowerName", rsMap.get("borrower_name"));
      BeanUtil.setProperty(lcv, "idNumber", rsMap.get("id_number"));
      BeanUtil.setProperty(lcv, "isImpersonate", rsMap.get("is_impersonate"));
      BeanUtil.setProperty(lcv, "amount", rsMap.get("amount"));
      BeanUtil.setProperty(lcv, "issueDate", rsMap.get("issue_date"));
      BeanUtil.setProperty(lcv, "dueDate", rsMap.get("due_date"));
      BeanUtil.setProperty(lcv, "interestRate", rsMap.get("interest_rate"));
      BeanUtil.setProperty(lcv, "officer", rsMap.get("officer"));
      BeanUtil.setProperty(lcv, "corporateOrgName", rsMap.get("corporate_org_name"));
      BeanUtil.setProperty(lcv, "guaranteeMode", rsMap.get("guarantee_mode"));
      BeanUtil.setProperty(lcv, "disposeMode", rsMap.get("dispose_mode"));
      BeanUtil.setProperty(lcv, "interestDate", rsMap.get("interest_date"));
      BeanUtil.setProperty(lcv, "litigationStat", rsMap.get("litigation_stat"));
      BeanUtil.setProperty(lcv, "recoveryPrincipal", rsMap.get("recovery_principal"));
      BeanUtil.setProperty(lcv, "recoveryInterest", rsMap.get("recovery_interest"));
      BeanUtil.setProperty(lcv, "hangInteres", rsMap.get("hang_interes"));
      BeanUtil.setProperty(lcv, "createBy", rsMap.get("create_by"));
      BeanUtil.setProperty(lcv, "createDate", rsMap.get("create_date"));
      BeanUtil.setProperty(lcv, "stat", rsMap.get("stat"));
      BeanUtil.setProperty(lcv, "isSubmit", rsMap.get("is_submit"));
      list.add(lcv);
      tempMap.put(lcv.getId(), lcv);
    }

    if (list.size() > 0) {
      sql.setLength(0);
      sql = new StringBuffer(
          "select g.id, g.guarantee_id, g.loan_contrac_id, p.name, p.id_number from npa_loan_contract_guarantee g, npa_natural_person p where g.guarantee_id = p.id and g.loan_contrac_id in(");
      for (LoanContractRegisterView item : list)
        sql.append(item.getId()).append(",");
      sql.deleteCharAt(sql.length() - 1);
      sql.append(")");

      List<Map<String, Object>> rsgt = findForJdbc(sql.toString());
      List<LoanContractGuarantee> listgt = new ArrayList<LoanContractGuarantee>();

      for (Map<String, Object> rsMap : rsgt) {
        LoanContractGuarantee lcg = new LoanContractGuarantee();
        BeanUtil.setProperty(lcg, "id", rsMap.get("id"));
        BeanUtil.setProperty(lcg, "guaranteeId", rsMap.get("guarantee_id"));
        BeanUtil.setProperty(lcg, "loanContracId", rsMap.get("loan_contrac_id"));
        BeanUtil.setProperty(lcg, "guaranteeName", rsMap.get("name"));
        NaturalPerson guarantee = new NaturalPerson();
        BeanUtil.setProperty(guarantee, "idNumber", rsMap.get("id_number"));
        lcg.setGuarantee(guarantee);
        listgt.add(lcg);
      }

      for (LoanContractGuarantee guarantee : listgt) {
        LoanContractRegisterView view = tempMap.get(guarantee.getLoanContracId());
        if (view != null) // 防止脏数据
          view.getLoanContractGuarantees().add(guarantee);
      }
    }
    dataGrid.setTotal(count.intValue());
    dataGrid.setResults(list);
  }

  @Override
  public boolean saveMain(LoanContractView loanContractView) throws Exception {
    // 1.保存借款人
    NaturalPerson newBorrowerPerson = naturalPersonService.saveOrUpdateItem(loanContractView.getBorrower(), true);

    // 2.保存借款合同
    loanContractView.getLoanContract().setBorrowerId(newBorrowerPerson.getId());
    loanContractView.getLoanContract().setBorrowerName(newBorrowerPerson.getName());
    loanContractView.getLoanContract().setStat("n");
    loanContractView.getLoanContract().setIsSubmit("0");
    loanContractView.getLoanContract().setIsDelete("0");
    loanContractView.getLoanContract().setRecoveryPrincipal(new Double(0));
    loanContractView.getLoanContract().setRecoveryInterest(new Double(0));
    loanContractView.getLoanContract().setHangInteres(new Double(0));
    save(loanContractView.getLoanContract());

    // 3.保存担保人
    for (LoanContractGuarantee item : loanContractView.getLoanContractGuarantees()) {
      if (item.getGuarantee() == null)
        continue;
      NaturalPerson newGuaranteePerson = naturalPersonService.saveOrUpdateItem(item.getGuarantee(), false);
      item.setGuaranteeId(newGuaranteePerson.getId());
      item.setGuaranteeName(newGuaranteePerson.getName());
      item.setLoanContracId(loanContractView.getLoanContract().getId());
      loanContractGuaranteeService.save(item);
    }
    return true;
  }

  @Override
  public boolean updateMain(LoanContractView loanContractView) throws Exception {
    LoanContract c = get(LoanContract.class, loanContractView.getLoanContract().getId());
    MyBeanUtils.copyBeanNotNull2Bean(loanContractView.getLoanContract(), c);

    // 1.保存借款人
    NaturalPerson newBorrowerPerson = naturalPersonService.saveOrUpdateItem(loanContractView.getBorrower(), true);

    // 2.保存借款合同
    loanContractView.getLoanContract().setBorrowerId(newBorrowerPerson.getId());
    loanContractView.getLoanContract().setBorrowerName(newBorrowerPerson.getName());
    saveOrUpdate(c);

    // 3.保存担保人
    String sql = "delete from npa_loan_contract_guarantee where loan_contrac_id = ?";
    executeSql(sql, c.getId());
    for (LoanContractGuarantee item : loanContractView.getLoanContractGuarantees()) {
      if (item.getGuarantee() == null)
        continue;
      NaturalPerson newGuaranteePerson = naturalPersonService.saveOrUpdateItem(item.getGuarantee(), false);
      item.setGuaranteeId(newGuaranteePerson.getId());
      item.setGuaranteeName(newGuaranteePerson.getName());
      item.setLoanContracId(loanContractView.getLoanContract().getId());
      loanContractGuaranteeService.save(item);
    }

    return true;
  }

  @Override
  public boolean deleteMain(Long id) throws Exception {
    // 1.删除关联的担保人
    String sql = "delete from npa_loan_contract_guarantee where loan_contrac_id = ?";
    executeSql(sql, id);
    // 2.删除主表
    deleteEntityById(LoanContract.class, id);
    return true;
  }

  @Override
  public boolean updateInitRecoveryMoney(Long id, double recoveryPrincipal, double recoveryInterest, double hangInteres, Date interestDate) throws Exception {
    StringBuffer sql = new StringBuffer("update npa_loan_contract set recovery_principal = ?, recovery_interest = ?, hang_interes = ?");
    if (interestDate != null)
      sql.append(", interest_date = DATE_FORMAT('").append(DateUtils.date2Str(interestDate, DateUtils.date_sdf)).append("','%Y-%m-%d')");
    sql.append(" where id = ?");
    Integer i = executeSql(sql.toString(), recoveryPrincipal, recoveryInterest, hangInteres, id);
    return i.intValue() > 0 ? true : false;
  }

  @Override
  public boolean commitMain(Long id) {
    String sql = "update npa_loan_contract set is_submit = 1 where id = ?";
    Integer i = executeSql(sql, id);
    return i.intValue() > 0 ? true : false;
  }

  @Override
  public boolean commitEnd(Long id) {
    String sql = "update npa_loan_contract set stat = 'e' where id = ?";
    Integer i = executeSql(sql, id);
    return i.intValue() > 0 ? true : false;
  }

  @Override
  public boolean commitTern(Long id) {
    String sql = "update npa_loan_contract set stat = 't' where id = ?";
    Integer i = executeSql(sql, id);
    return i.intValue() > 0 ? true : false;
  }

  @Override
  public boolean updateImpersonate(Long id, boolean isImpersonate) {
    String sql = "update npa_loan_contract set is_impersonate = ? where id = ?";
    Integer i = executeSql(sql, isImpersonate ? 1 : 0, id);
    return i.intValue() > 0 ? true : false;
  }

  @Override
  public boolean checkNumCodeValid(Long id, String numCode) {
    StringBuffer sql = new StringBuffer("select count(1) ct from npa_loan_contract where num_code = '").append(numCode).append("'");
    if (id != null) {
      sql.append(" and id <> '").append(id).append("'");
    }

    List<Map<String, Object>> rs = findForJdbc(sql.toString());
    long ct = (long) (rs.get(0).get("ct"));
    return ct > 0 ? false : true;
  }

  @Override
  public void viQuery(String userName, ViContractQyView viContractQyView, DataGrid dataGrid) {
    boolean isInitStat = true;
    List<ViContractQyView> list = new ArrayList<ViContractQyView>();
    StringBuffer sql = new StringBuffer("select * from vi_contract_qy where id in(")
        .append("select DISTINCT q.id from vi_contract_qy q LEFT JOIN npa_loan_contract_guarantee g ON q.id = g.loan_contrac_id ")
        .append("LEFT JOIN npa_natural_person p ON g.guarantee_id = p.id where ");
    if (oConvertUtils.isNotEmpty(viContractQyView.getNumCode())) {
      sql.append("q.num_code = '").append(viContractQyView.getNumCode()).append("'");
      isInitStat = false;
    }

    if (oConvertUtils.isNotEmpty(userName)) {
      if (!isInitStat)
        sql.append(" AND");
      sql.append(" (q.borrower_name IN (").append(split(userName)).append(")").append("OR p.name IN (").append(split(userName)).append("))");
      isInitStat = false;
    }

    if (oConvertUtils.isNotEmpty(viContractQyView.getIdNumber())) {
      if (!isInitStat)
        sql.append(" AND");
      sql.append(" (q.id_number IN (").append(split(viContractQyView.getIdNumber())).append(")").append("OR p.id_number IN (").append(split(viContractQyView.getIdNumber()))
          .append("))");
      isInitStat = false;
    }
    sql.append(")");

    if (!isInitStat) {
      list = combinationViContractQyView(sql);
    }

    dataGrid.setTotal(list.size());
    dataGrid.setResults(list);
  }

  @Override
  public String querySavePdf(String idList, String nfParam) throws Exception {
    List<ViContractQyView> vList = new ArrayList<ViContractQyView>();

    StringBuffer sql = new StringBuffer("select * from vi_contract_qy where id in(");
    if (oConvertUtils.isNotEmpty(idList)) {
      for (String id : idList.split(",")) {
        sql.append(id).append(",");
      }
      sql.deleteCharAt(sql.lastIndexOf(","));
      sql.append(")");
      vList = combinationViContractQyView(sql);
    }

    String fileName = String.valueOf(new Date().getTime());
    String docment_basePath = ResourceUtil.getConfigByName("npa_query_pdf_docment_basePath");
    String pdfVersionImp = ResourceUtil.getConfigByName("npa_query_pdf_pdfVersionImp");
    String title = ResourceUtil.getConfigByName("npa_query_pdf_title");
    String author = ResourceUtil.getConfigByName("npa_query_pdf_author");
    String subject = ResourceUtil.getConfigByName("npa_query_pdf_subject");
    String keywords = ResourceUtil.getConfigByName("npa_query_pdf_keywords");
    String creator = ResourceUtil.getConfigByName("npa_query_pdf_creator");
    PdfConfig pdfConfig = PdfConfig.getInstance(docment_basePath, pdfVersionImp, title, author, subject, keywords, creator);
    PdfUtils.turnToPdf(pdfConfig, vList, nfParam, fileName);

    return fileName + ".pdf";
  }

  /**
   * 拼接字符串
   * 
   * @param str
   * @return
   */
  private String split(String str) {
    return split(str, "'", ",", ",");
  }

  /**
   * 拼接字符串
   * 
   * @param str 目标字符串
   * @param prefix 前后缀
   * @param separator 分隔符
   * @param connector 连接符
   * @return
   */
  private String split(String str, String prefix, String separator, String connector) {
    String[] splits = str.split(separator);
    StringBuffer sb = new StringBuffer();
    for (String s : splits)
      sb.append(prefix).append(s).append(prefix).append(connector);
    sb.deleteCharAt(sb.lastIndexOf(connector));
    return sb.toString();
  }

  /**
   * 组合ViContractQyView对象
   * 
   * @param sql
   * @return
   */
  private List<ViContractQyView> combinationViContractQyView(StringBuffer sql) {
    List<ViContractQyView> list = new ArrayList<ViContractQyView>();
    List<Map<String, Object>> rs = findForJdbc(sql.toString());
    Map<Long, ViContractQyView> tempMap = new HashMap<Long, ViContractQyView>();

    for (Map<String, Object> rsMap : rs) {
      ViContractQyView vq = new ViContractQyView();
      BeanUtil.setProperty(vq, "id", rsMap.get("id"));
      BeanUtil.setProperty(vq, "numCode", rsMap.get("num_code"));
      BeanUtil.setProperty(vq, "customerNo", rsMap.get("customer_no"));
      BeanUtil.setProperty(vq, "louNo", rsMap.get("lou_no"));
      BeanUtil.setProperty(vq, "borrowerName", rsMap.get("borrower_name"));
      BeanUtil.setProperty(vq, "idNumber", rsMap.get("id_number"));
      BeanUtil.setProperty(vq, "amount", rsMap.get("amount"));
      BeanUtil.setProperty(vq, "amountSurplus", rsMap.get("amount_surplus"));
      BeanUtil.setProperty(vq, "oInterestRate", rsMap.get("o_interest_rate"));
      BeanUtil.setProperty(vq, "issueDate", rsMap.get("issue_date"));
      BeanUtil.setProperty(vq, "dueDate", rsMap.get("due_date"));
      BeanUtil.setProperty(vq, "interestDate", rsMap.get("interest_date"));
      BeanUtil.setProperty(vq, "adjustInterestRate", rsMap.get("adjust_interest_rate"));
      BeanUtil.setProperty(vq, "officer", rsMap.get("officer"));
      BeanUtil.setProperty(vq, "corporateOrgName", rsMap.get("corporate_org_name"));
      BeanUtil.setProperty(vq, "hangInteres", rsMap.get("hang_interes"));
      BeanUtil.setProperty(vq, "guaranteeMode", rsMap.get("guarantee_mode"));
      BeanUtil.setProperty(vq, "disposeMode", rsMap.get("dispose_mode"));
      BeanUtil.setProperty(vq, "litigationStat", rsMap.get("litigation_stat"));
      BeanUtil.setProperty(vq, "stat", rsMap.get("stat"));
      list.add(vq);
      tempMap.put(vq.getId(), vq);
    }

    if (list.size() > 0) {
      sql.setLength(0);
      sql.append(
          "select g.id, g.guarantee_id, g.loan_contrac_id, p.name, p.id_number from npa_loan_contract_guarantee g, npa_natural_person p where g.guarantee_id = p.id and g.loan_contrac_id in(");
      for (ViContractQyView item : list)
        sql.append(item.getId()).append(",");
      sql.deleteCharAt(sql.length() - 1);
      sql.append(")");

      List<Map<String, Object>> rsgt = findForJdbc(sql.toString());
      List<LoanContractGuarantee> listgt = new ArrayList<LoanContractGuarantee>();

      for (Map<String, Object> rsMap : rsgt) {
        LoanContractGuarantee lcg = new LoanContractGuarantee();
        BeanUtil.setProperty(lcg, "id", rsMap.get("id"));
        BeanUtil.setProperty(lcg, "guaranteeId", rsMap.get("guarantee_id"));
        BeanUtil.setProperty(lcg, "loanContracId", rsMap.get("loan_contrac_id"));
        BeanUtil.setProperty(lcg, "guaranteeName", rsMap.get("name"));
        NaturalPerson guarantee = new NaturalPerson();
        BeanUtil.setProperty(guarantee, "idNumber", rsMap.get("id_number"));
        lcg.setGuarantee(guarantee);
        listgt.add(lcg);
      }

      for (LoanContractGuarantee guarantee : listgt) {
        ViContractQyView vq = tempMap.get(guarantee.getLoanContracId());
        if (vq != null) // 防止脏数据
          vq.getLoanContractGuarantees().add(guarantee);
      }
    }

    return list;
  }

  @Override
  public boolean deleteTemp(Long id) throws Exception {
    StringBuffer sql = new StringBuffer("from LoanContract where id = ?");
    LoanContract contract = getEntity(LoanContract.class, id);

    // 查看借款人是否存在其他合同信息中,如果没有,删除借款人
    sql.setLength(0);
    sql.append("select count(1) from npa_loan_contract where borrower_id = ? and id <> ?");
    Long count = getCountForJdbcParam(sql.toString(), contract.getBorrowerId(), id);
    if (count == 0) {
      sql.setLength(0);
      sql.append("delete from npa_natural_person where id = ?");
      executeSql(sql.toString(), contract.getBorrowerId());
    }

    // 查看担保人是否存在其他合同信息中,如果没有,删除担保人
    sql.setLength(0);
    sql.append("from LoanContractGuarantee where loanContracId = ?");
    List<LoanContractGuarantee> guaranteeList = findHql(sql.toString(), id);
    for (LoanContractGuarantee gua : guaranteeList) {
      sql.setLength(0);
      sql.append("select count(1) from npa_loan_contract_guarantee where guarantee_id = ? and loan_contrac_id <> ?");
      count = getCountForJdbcParam(sql.toString(), gua.getGuaranteeId(), id);
      if (count == 0) {
        sql.setLength(0);
        sql.append("delete from npa_natural_person where id = ?");
        executeSql(sql.toString(), gua.getGuaranteeId());
      }
    }
    
    // 删除担保人中间表
    sql.setLength(0);
    sql.append("delete from npa_loan_contract_guarantee where loan_contrac_id = ?");
    executeSql(sql.toString(), id);

    // 删除合同回款明细
    sql.setLength(0);
    sql.append("delete from npa_recovery_money where loan_contrac_id = ?");
    executeSql(sql.toString(), id);

    // 删除合同修正错误信息表
    sql.setLength(0);
    sql.append("delete from npa_loan_contract_error where loan_contract_id = ?");
    executeSql(sql.toString(), id);

    // 删除合同表
    sql.setLength(0);
    sql.append("delete from npa_loan_contract where id = ?");
    executeSql(sql.toString(), id);

    return true;
  }
}
