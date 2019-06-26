package nsh.xinmi.npa.corporateOrg.service.impl;

import java.util.List;

import org.jeecgframework.core.common.service.impl.CommonServiceImpl;
import org.jeecgframework.core.util.ResourceUtil;
import org.jeecgframework.web.system.pojo.base.TSUser;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import nsh.xinmi.npa.corporateOrg.entity.CorporateOrg;
import nsh.xinmi.npa.corporateOrg.entity.CorporateOrgUser;
import nsh.xinmi.npa.corporateOrg.service.CorporateOrgUserServiceI;

@Service("corporateOrgUserService")
@Transactional
public class CorporateOrgUserServiceImpl extends CommonServiceImpl implements CorporateOrgUserServiceI {
    @Override
    public List<CorporateOrg> getDictSelectByUser() {
        TSUser loginUser = ResourceUtil.getSessionUser();
        StringBuffer hql = new StringBuffer("from CorporateOrg c where isEffect = '1' and isDelete = '0'");
        if (!"admin".equals(loginUser.getUserName())) {
            List<CorporateOrgUser> couList = findByProperty(CorporateOrgUser.class, "userid", loginUser.getId());

            if (couList.size() == 0)
                hql.append(" and c.id = -1");
            else {
                hql.append(" and c.id in (");
                for (CorporateOrgUser cou : couList)
                    hql.append(cou.getCorporateOrgId()).append(",");
                hql.deleteCharAt(hql.lastIndexOf(","));
                hql.append(")");
            }
        }
        return findByQueryString(hql.toString());
    }

}
