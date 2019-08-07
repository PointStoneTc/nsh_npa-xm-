package nsh.xinmi.npa.corporateOrg.service.impl;

import java.util.ArrayList;
import java.util.List;
import java.util.Map;
import org.jeecgframework.core.common.hibernate.qbc.CriteriaQuery;
import org.jeecgframework.core.common.model.json.DataGrid;
import org.jeecgframework.core.common.service.impl.CommonServiceImpl;
import org.jeecgframework.core.util.ResourceUtil;
import org.jeecgframework.web.system.pojo.base.TSBaseUser;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import jodd.bean.BeanUtil;
import nsh.xinmi.npa.corporateOrg.entity.CorporateOrg;
import nsh.xinmi.npa.corporateOrg.entity.CorporateOrgUser;
import nsh.xinmi.npa.corporateOrg.service.CorporateOrgServiceI;
import nsh.xinmi.npa.corporateOrg.view.CorporateOrgUserListView;

@Service("corporateOrgService")
@Transactional
public class CorporateOrgServiceImpl extends CommonServiceImpl implements CorporateOrgServiceI {

    @Override
    public void getAllList(CorporateOrg corporateOrg, DataGrid dataGrid) {
        // hql = "from CorporateOrg where isDelete = 0";
        CriteriaQuery cq = new CriteriaQuery(CorporateOrg.class, dataGrid);
        // 查询条件组装器
        cq.eq("isDelete", "0");
        cq.add();
        this.getDataGridReturn(cq, true);
    }

    @Override
    public void getOperatorListByCorporateOrgId(Long id, DataGrid dataGrid) {
        Long count = 0l;
        List<CorporateOrgUserListView> list = new ArrayList<CorporateOrgUserListView>();

        if (id != null) {
            String sql =
                    "select o.id, u.id userid, u.realname, o.corporate_org_id from npa_corporate_org_user o, t_s_base_user u where o.userid = u.id and u.delete_flag = 0 and u.status = 1 and o.corporate_org_id = "
                            + id;
            count = this.getCountForJdbc("select count(1) from (" + sql.toString() + ") t");
            List<Map<String, Object>> rs = this.findForJdbc(sql.toString());
            for (Map<String, Object> rsMap : rs) {
                CorporateOrgUserListView userView = new CorporateOrgUserListView();
                BeanUtil.setProperty(userView, "id", rsMap.get("id"));
                BeanUtil.setProperty(userView, "corporateOrgId", rsMap.get("corporate_org_id"));
                BeanUtil.setProperty(userView, "userid", rsMap.get("userid"));
                BeanUtil.setProperty(userView, "userName", rsMap.get("realname"));
                list.add(userView);
            }
        }

        dataGrid.setTotal(count.intValue());
        dataGrid.setResults(list);
    }

    @Override
    public void getOneOperatorList(Long orgId, DataGrid dataGrid) {
        String roleid = ResourceUtil.getConfigByName("npa_mag_role_id");
        StringBuffer sql = new StringBuffer("select u.id, u.realname, u.username from t_s_role_user r, t_s_base_user u ")
                .append("where r.userid = u.id and u.delete_flag = 0 and u.status = 1 and r.roleid = '").append(roleid).append("'")
                .append(" and u.id not in(select DISTINCT userid from npa_corporate_org_user where corporate_org_id = ").append(orgId).append(")");

        Long count = this.getCountForJdbc("select count(1) from (" + sql.toString() + ") t");
        List<Map<String, Object>> rs = findForJdbc(sql.toString(), dataGrid.getPage(), dataGrid.getRows());
        List<TSBaseUser> list = new ArrayList<TSBaseUser>();
        for (Map<String, Object> rsMap : rs) {
            TSBaseUser user = new TSBaseUser();
            BeanUtil.setProperty(user, "id", rsMap.get("id"));
            BeanUtil.setProperty(user, "realName", rsMap.get("realname"));
            BeanUtil.setProperty(user, "userName", rsMap.get("username"));
            list.add(user);
        }

        dataGrid.setTotal(count.intValue());
        dataGrid.setResults(list);
    }

    @Override
    public List<CorporateOrg> getAllList() {
        String hql = "from CorporateOrg where isEffect = '1'";
        List<CorporateOrg> list = this.findHql(hql);
        return list;
    }

    @Override
    public boolean optOperator(Long id, Long orgId) {
        CorporateOrgUser corporateOrgUser = this.get(CorporateOrgUser.class, id);
        
        //判断调动的支行是否已经存在该人
        String sql = "select count(1) from npa_corporate_org_user where corporate_org_id = ? and userid = ?";
        Long ct = getCountForJdbcParam(sql, orgId, corporateOrgUser.getUserid());
        if(ct > 0) {
            return false;
        }
        corporateOrgUser.setCorporateOrgId(orgId);
        this.updateEntitie(corporateOrgUser);
        return true;
    }

}
