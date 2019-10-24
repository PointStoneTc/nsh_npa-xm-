package nsh.xinmi.npa.naturalPerson.service.impl;

import java.util.List;
import org.jeecgframework.core.common.hibernate.qbc.CriteriaQuery;
import org.jeecgframework.core.common.model.json.DataGrid;
import org.jeecgframework.core.common.service.impl.CommonServiceImpl;
import org.jeecgframework.core.util.MyBeanUtils;
import org.jeecgframework.core.util.oConvertUtils;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import nsh.xinmi.npa.naturalPerson.entity.NaturalPerson;
import nsh.xinmi.npa.naturalPerson.service.NaturalPersonServiceI;

@Service("naturalPersonService")
@Transactional
public class NaturalPersonServiceImpl extends CommonServiceImpl implements NaturalPersonServiceI {

  @Override
  public void getBorrowerList(NaturalPerson naturalPerson, DataGrid dataGrid) {
    // hql = "from NaturalPerson where name like ? and idNumber = ? and isBorrower = 1 and isDelete =
    // 0";
    CriteriaQuery cq = new CriteriaQuery(NaturalPerson.class, dataGrid);
    // 查询条件组装器
    if (oConvertUtils.isNotEmpty(naturalPerson.getName()))
      cq.like("name", naturalPerson.getName());

    if (oConvertUtils.isNotEmpty(naturalPerson.getIdNumber()))
      cq.eq("idNumber", naturalPerson.getIdNumber());
    cq.eq("isBorrower", "1");
    cq.eq("isDelete", "0");

    cq.add();
    this.getDataGridReturn(cq, true);
  }

  @Override
  public void getGuaranteeList(NaturalPerson naturalPerson, DataGrid dataGrid) {
    // hql = "from NaturalPerson where name like ? and idNumber = ? and isGuarantee = 1 and isDelete =
    // 0";
    CriteriaQuery cq = new CriteriaQuery(NaturalPerson.class, dataGrid);
    // 查询条件组装器
    if (oConvertUtils.isNotEmpty(naturalPerson.getName()))
      cq.like("name", naturalPerson.getName());

    if (oConvertUtils.isNotEmpty(naturalPerson.getIdNumber()))
      cq.eq("idNumber", naturalPerson.getIdNumber());
    cq.eq("isGuarantee", "1");
    cq.eq("isDelete", "0");
    cq.add();
    this.getDataGridReturn(cq, true);
  }

  @Override
  public NaturalPerson isExist(String name, String idNumber) {
    String hql = "from NaturalPerson where idNumber = ? and name = ?";
    List<NaturalPerson> list = this.findHql(hql, idNumber, name);
    return list.size() > 0 ? list.get(0) : null;
  }

  @Override
  public void getOnePersonList(String excludeIdNumbers, NaturalPerson naturalPerson, DataGrid dataGrid) {
    // hql = "from NaturalPerson where name like ? and idNumber = ? and isBorrower = 1 and isDelete =
    // 0";
    CriteriaQuery cq = new CriteriaQuery(NaturalPerson.class, dataGrid);
    // 查询条件组装器
    if (oConvertUtils.isNotEmpty(naturalPerson.getName()))
      cq.like("name", naturalPerson.getName());

    if (oConvertUtils.isNotEmpty(naturalPerson.getIdNumber()))
      cq.eq("idNumber", naturalPerson.getIdNumber());
    cq.eq("isDelete", "0");

    if (oConvertUtils.isNotEmpty(excludeIdNumbers)) {
      for (String idNumber : excludeIdNumbers.split(","))
        cq.notEq("idNumber", idNumber);
    }

    cq.add();
    this.getDataGridReturn(cq, true);
  }

  @Override
  public NaturalPerson saveOrUpdateItem(NaturalPerson naturalPerson, boolean isBorrower) throws Exception {
    NaturalPerson temp;
    if (oConvertUtils.isNotEmpty(naturalPerson.getId())) { // 通过选择或者是原来就有的数据
      temp = get(NaturalPerson.class, naturalPerson.getId());
      MyBeanUtils.copyBeanNotNull2Bean(naturalPerson, temp);
      saveOrUpdate(temp);
    } else {
      temp = isExist(naturalPerson.getName(), naturalPerson.getIdNumber()); // 判断借款人是否存在数据库
      if (temp == null) {
        naturalPerson.setIsBorrower(isBorrower ? "1" : "0");
        naturalPerson.setIsGuarantee(isBorrower ? "0" : "1");
        naturalPerson.setIsDelete("0");
        save(naturalPerson);
        return naturalPerson;
      } else {
        MyBeanUtils.copyBeanNotNull2Bean(naturalPerson, temp);
        saveOrUpdate(temp);
      }
    }
    return temp;
  }

  @Override
  public boolean updateDetail(NaturalPerson naturalPerson) throws Exception {
    boolean personNameHasChange = false;
    // 1.更新自然人表
    NaturalPerson temp = get(NaturalPerson.class, naturalPerson.getId());
    personNameHasChange = !temp.getName().equals(naturalPerson.getName());
    MyBeanUtils.copyBeanNotNull2Bean(naturalPerson, temp);
    saveOrUpdate(temp);

    // 2.更新其它缓存表数据
    if (personNameHasChange) {
      String sql = "update npa_loan_contract set borrower_name = ? where borrower_id = ?"; // 合同中的借款人
      executeSql(sql, naturalPerson.getName(), naturalPerson.getId());
      sql = "update npa_loan_contract_guarantee set guarantee_name = ? where guarantee_id = ?"; // 担保人
      executeSql(sql, naturalPerson.getName(), naturalPerson.getId());
    }

    return temp != null;
  }

}
