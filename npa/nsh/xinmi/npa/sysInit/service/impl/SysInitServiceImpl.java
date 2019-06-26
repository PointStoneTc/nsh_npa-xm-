package nsh.xinmi.npa.sysInit.service.impl;

import java.io.IOException;
import java.util.ArrayList;
import java.util.List;
import java.util.Map;

import org.jeecgframework.core.common.model.json.DataGrid;
import org.jeecgframework.core.common.service.impl.CommonServiceImpl;
import org.jeecgframework.poi.excel.ExcelImportUtil;
import org.jeecgframework.poi.excel.entity.ImportParams;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import org.springframework.web.multipart.MultipartFile;

import jodd.bean.BeanUtil;
import nsh.xinmi.npa.sysInit.entity.LoanContractImp;
import nsh.xinmi.npa.sysInit.entity.LoanContractImpVi;
import nsh.xinmi.npa.sysInit.entity.NaturalPersonImp;
import nsh.xinmi.npa.sysInit.service.SysInitServiceI;

@Service("sysInitService")
@Transactional
public class SysInitServiceImpl extends CommonServiceImpl implements SysInitServiceI {
    @Override
    public boolean deleteAllData() throws Exception {
        String cg_sql = "delete from npa_loan_contract_guarantee_imp";
        executeSql(cg_sql);

        String np_sql = "delete from npa_natural_person_imp";
        executeSql(np_sql);

        String lt_sql = "delete from npa_loan_contract_imp";
        executeSql(lt_sql);
        return true;
    }

    @Override
    public void initltDatagrid(DataGrid dataGrid) {
        String hql = "from LoanContractImpVi";
        List<LoanContractImpVi> list = this.findHql(hql);
        dataGrid.setResults(list);

    }

    @Override
    public void initBorrowerDatagrid(DataGrid dataGrid) {
        StringBuffer sql = new StringBuffer("select DISTINCT i.name, i.id_number, ").append("(select count(1) from npa_natural_person p where p.id_number = i.id_number) existing ")
                .append("from npa_natural_person_imp i ").append("where i.is_borrower = '1'");

        List<Map<String, Object>> rs = findForJdbc(sql.toString());
        List<NaturalPersonImp> list = new ArrayList<NaturalPersonImp>();
        for (Map<String, Object> rsMap : rs) {
            NaturalPersonImp npi = new NaturalPersonImp();
            BeanUtil.setProperty(npi, "name", rsMap.get("name"));
            BeanUtil.setProperty(npi, "idNumber", rsMap.get("id_number"));
            BeanUtil.setProperty(npi, "existing", rsMap.get("existing"));
            list.add(npi);
        }

        dataGrid.setResults(list);
    }

    @Override
    public void initGuaranteeDatagrid(DataGrid dataGrid) {
        StringBuffer sql = new StringBuffer("select DISTINCT i.name, i.id_number, ").append("(select count(1) from npa_natural_person p where p.id_number = i.id_number) existing ")
                .append("from npa_natural_person_imp i ").append("where i.is_guarantee = '1'");

        List<Map<String, Object>> rs = findForJdbc(sql.toString());
        List<NaturalPersonImp> list = new ArrayList<NaturalPersonImp>();
        for (Map<String, Object> rsMap : rs) {
            NaturalPersonImp npi = new NaturalPersonImp();
            BeanUtil.setProperty(npi, "name", rsMap.get("name"));
            BeanUtil.setProperty(npi, "idNumber", rsMap.get("id_number"));
            BeanUtil.setProperty(npi, "existing", rsMap.get("existing"));
            list.add(npi);
        }

        dataGrid.setResults(list);
    }

    @Override
    public void initIdNumberFixDatagrid(DataGrid dataGrid) {
        StringBuffer sql = new StringBuffer("SELECT p.name, p.id_number FROM npa_natural_person_imp p INNER JOIN ").append("(SELECT id_number FROM ").append(
                "(SELECT DISTINCT npi. NAME, npi.id_number FROM npa_natural_person_imp npi LEFT JOIN npa_natural_person p ON npi.id_number = p.id_number WHERE p.id_number IS NULL) t ")
                .append("GROUP BY t.id_number HAVING count(1) > 1) t ").append("ON p.id_number = t.id_number ORDER BY p.id_number");

        List<Map<String, Object>> rs = findForJdbc(sql.toString());
        List<NaturalPersonImp> list = new ArrayList<NaturalPersonImp>();
        for (Map<String, Object> rsMap : rs) {
            NaturalPersonImp npi = new NaturalPersonImp();
            BeanUtil.setProperty(npi, "name", rsMap.get("name"));
            BeanUtil.setProperty(npi, "idNumber", rsMap.get("id_number"));
            list.add(npi);
        }

        dataGrid.setResults(list);
    }

    @Override
    public int ltImportExcel(Map<String, MultipartFile> fileMap) throws Exception {
        // 1.先清除imp临时表里的数据
        deleteAllData();

        // 2.插入Excel表的数据
        for (Map.Entry<String, MultipartFile> entity : fileMap.entrySet()) {
            MultipartFile file = entity.getValue();// 获取上传文件对象
            ImportParams params = new ImportParams();
            params.setHeadRows(1);
            params.setNeedSave(true);
            try {
                List<LoanContractImp> loanContractImpExcelEntitys = ExcelImportUtil.importExcel(file.getInputStream(), LoanContractImp.class, params);
                batchSave(loanContractImpExcelEntitys);
            } catch (Exception e) {
                throw e;
            } finally {
                try {
                    file.getInputStream().close();
                } catch (IOException e) {
                    e.printStackTrace();
                }
            }
        }
        return fileMap.size();
    }

    @Override
    public boolean createResult() throws Exception {
        // 1.删除临时表
        String sql = "delete from npa_natural_person_imp";
        executeSql(sql);

        // 2.1插入临时自然人表(借款人)
        sql = "insert into npa_natural_person_imp(name, id_number, is_borrower, is_guarantee) select borrower_name, borrower_number, '1', '0' from npa_loan_contract_imp";
        executeSql(sql);

        // 2.2插入临时自然人表(担保人)
        String hql = "from LoanContractImp where guarantees is not null";
        List<LoanContractImp> lciList = this.findHql(hql);

        if (lciList.size() > 0) {
            List<NaturalPersonImp> list = new ArrayList<NaturalPersonImp>();
            for (LoanContractImp lci : lciList) {
                String[] temp = lci.getGuarantees().split(";");
                for (String s : temp) {
                    String[] t = s.split(",");
                    NaturalPersonImp nplt = new NaturalPersonImp();
                    nplt.setName(t[0]);
                    nplt.setIdNumber(t[1]);
                    nplt.setIsBorrower("0");
                    nplt.setIsGuarantee("1");
                    list.add(nplt);
                }
            }
            batchSave(list);
        }

        return true;
    }

}
