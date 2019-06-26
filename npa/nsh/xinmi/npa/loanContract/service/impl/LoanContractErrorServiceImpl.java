package nsh.xinmi.npa.loanContract.service.impl;

import java.util.ArrayList;
import java.util.Date;
import java.util.List;
import java.util.Map;

import org.jeecgframework.core.common.model.json.DataGrid;
import org.jeecgframework.core.common.service.impl.CommonServiceImpl;
import org.jeecgframework.core.util.DateUtils;
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
import nsh.xinmi.npa.loanContract.service.LoanContractErrorServiceI;
import nsh.xinmi.npa.loanContract.view.LoanContractRegisterView;
import nsh.xinmi.npa.naturalPerson.entity.NaturalPerson;
import nsh.xinmi.npa.naturalPerson.service.NaturalPersonServiceI;

@Service("loanContractErrorService")
@Transactional
public class LoanContractErrorServiceImpl extends CommonServiceImpl implements LoanContractErrorServiceI {
    @Autowired
    private NaturalPersonServiceI naturalPersonService;

    @Autowired
    private CorporateOrgUserServiceI corporateOrgUserService;

    @Autowired
    private UserService userService;

    @Override
    public void getLoanContractRegisterList(LoanContractRegisterView loanContractRegisterView, String errorType, DataGrid dataGrid) {
        StringBuffer sql = new StringBuffer(
                "select c.id, c.num_code, c.customer_no, c.lou_no, c.borrower_name, p.id_number, c.amount, c.issue_date, c.due_date, c.interest_rate, c.officer, c.corporate_org_name, c.litigation_stat, c.guarantee_mode, c.dispose_mode, c.recovery_principal, c.interest_date, c.recovery_interest, c.hang_interes ")
                        .append("from npa_loan_contract c join npa_loan_contract_error r on c.id = r.loan_contract_id and r.is_submit = '0' and c.is_delete = '1'")
                        .append("left join npa_natural_person p on c.borrower_id = p.id where 1 = 1");
        if (oConvertUtils.isNotEmpty(loanContractRegisterView.getBorrowerName())) // 借款人
            sql.append(" and c.borrower_name like '%").append(loanContractRegisterView.getBorrowerName()).append("%'");

        if (oConvertUtils.isNotEmpty(errorType)) {// 错误类型
            if ("e1".equals(errorType)) { // 借款人身份证号为空
                sql.append(" and c.borrower_id is null");
            }

            if ("e2".equals(errorType)) { // 贷款发放日为空
                sql.append(" and c.issue_date is null");
            }

            if ("e3".equals(errorType)) { // 贷款到期日为空
                sql.append(" and c.due_date is null");
            }

            if ("e4".equals(errorType)) { // 贷款到期日>贷款发放日
                sql.append(" and c.due_date < c.issue_date");
            }
        }

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

        sql.append(" order by c.borrower_name, c.issue_date");
        List<Map<String, Object>> rs = findForJdbc(sql.toString(), dataGrid.getPage(), dataGrid.getRows());
        List<LoanContractRegisterView> list = new ArrayList<LoanContractRegisterView>();
        for (Map<String, Object> rsMap : rs) {
            LoanContractRegisterView lcv = new LoanContractRegisterView();
            BeanUtil.setProperty(lcv, "id", rsMap.get("id"));
            BeanUtil.setProperty(lcv, "numCode", rsMap.get("num_code"));
            BeanUtil.setProperty(lcv, "customerNo", rsMap.get("customer_no"));
            BeanUtil.setProperty(lcv, "louNo", rsMap.get("lou_no"));
            BeanUtil.setProperty(lcv, "borrowerName", rsMap.get("borrower_name"));
            BeanUtil.setProperty(lcv, "idNumber", rsMap.get("id_number"));
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
            list.add(lcv);
        }

        dataGrid.setTotal(count.intValue());
        dataGrid.setResults(list);
    }

    @Override
    public boolean updateBorrower(String ids, String name, String sex, Date birthday, String idNumber) throws Exception {
        // 判断身份证号是否存在,如果存在使用存在的身份号,否则新建
        NaturalPerson person = naturalPersonService.isExist(idNumber);
        Long borrower_id;
        if (person == null) {
            NaturalPerson temp = new NaturalPerson(name, sex, birthday, idNumber, "1", "0");
            temp.setIsDelete("0");
            naturalPersonService.save(temp);
            borrower_id = temp.getId();
        } else {
            borrower_id = person.getId();
        }

        StringBuffer sql = new StringBuffer("update npa_loan_contract c set c.borrower_id = ? ").append("where c.id in(").append(ids).append(")");
        Integer i = executeSql(sql.toString(), borrower_id);
        return i.intValue() > 0 ? true : false;
    }

    @Override
    public boolean updateIssueDueDate(Long id, Date issueDate, Date dueDate) throws Exception {
        String sql = "update npa_loan_contract set issue_date = ?, due_date = ? where id = ?";
        Integer i = executeSql(sql, DateUtils.date2Str(issueDate, DateUtils.date_sdf), DateUtils.date2Str(dueDate, DateUtils.date_sdf), id);
        return i.intValue() > 0 ? true : false;
    }

    @Override
    public boolean commit(String ids) {
        TSUser loginUser = ResourceUtil.getSessionUser();
        StringBuffer sql =
                new StringBuffer("update npa_loan_contract_error set is_submit = 1, update_by = ?, update_date = NOW() where loan_contract_id in (").append(ids).append(")");
        executeSql(sql.toString(), loginUser.getUserName());

        sql.setLength(0);
        sql.append("update npa_loan_contract set is_submit = '1', is_delete = '0' where id in(").append(ids).append(")");
        Integer i = executeSql(sql.toString());
        return i.intValue() > 0 ? true : false;
    }
}
