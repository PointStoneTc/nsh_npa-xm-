package nsh.xinmi.npa.loanContract.service.impl;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.jeecgframework.core.common.service.impl.CommonServiceImpl;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import jodd.bean.BeanUtil;
import nsh.xinmi.npa.loanContract.service.LoanContractAnalysisServiceI;
import nsh.xinmi.npa.loanContract.view.LoanContractAnalsisErrorView;
import nsh.xinmi.npa.loanContract.view.LoanContractAnalsisOrgAmountView;
import nsh.xinmi.npa.loanContract.view.LoanContractAnalsisOrgBorrower;

@Service("loanContractAnalysisService")
@Transactional
public class LoanContractAnalysisServiceImp extends CommonServiceImpl implements LoanContractAnalysisServiceI {

    @Override
    public List<LoanContractAnalsisOrgAmountView> getLoanContractlOrgAmount() {
        String sql = "select * from vi_contract_org_amount";
        List<Map<String, Object>> rs = findForJdbc(sql);

        List<LoanContractAnalsisOrgAmountView> list = new ArrayList<LoanContractAnalsisOrgAmountView>();
        for (Map<String, Object> rsMap : rs) {
            LoanContractAnalsisOrgAmountView view = new LoanContractAnalsisOrgAmountView();
            BeanUtil.setProperty(view, "orgId", rsMap.get("orgId"));
            BeanUtil.setProperty(view, "orgName", rsMap.get("orgName"));
            BeanUtil.setProperty(view, "v1", rsMap.get("v1"));
            BeanUtil.setProperty(view, "v2", rsMap.get("v2"));
            list.add(view);
        }
        return list;
    }

    @Override
    public List<LoanContractAnalsisOrgBorrower> getLoanContractlOrgBorrower() {
        String sql = "select * from vi_contract_org_borrower";
        List<Map<String, Object>> rs = findForJdbc(sql);

        List<LoanContractAnalsisOrgBorrower> list = new ArrayList<LoanContractAnalsisOrgBorrower>();
        for (Map<String, Object> rsMap : rs) {
            LoanContractAnalsisOrgBorrower view = new LoanContractAnalsisOrgBorrower();
            BeanUtil.setProperty(view, "orgId", rsMap.get("orgId"));
            BeanUtil.setProperty(view, "orgName", rsMap.get("orgName"));
            BeanUtil.setProperty(view, "ct", rsMap.get("ct"));
            list.add(view);
        }
        return list;
    }

    @Override
    public List<LoanContractAnalsisErrorView> getLoanContractlOrgError() {
        String sql = "select * from vi_contract_error";
        List<Map<String, Object>> rs = findForJdbc(sql);

        List<LoanContractAnalsisErrorView> list = new ArrayList<LoanContractAnalsisErrorView>();
        for (Map<String, Object> rsMap : rs) {
            LoanContractAnalsisErrorView view = new LoanContractAnalsisErrorView();
            BeanUtil.setProperty(view, "orgName", rsMap.get("corporate_org_name"));
            BeanUtil.setProperty(view, "v1", rsMap.get("amount"));
            BeanUtil.setProperty(view, "v2", rsMap.get("amount_wc"));
            BeanUtil.setProperty(view, "v3", rsMap.get("amount_wwc"));
            list.add(view);
        }
        return list;
    }

}
