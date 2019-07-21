package nsh.xinmi.npa.authority.service.impl;

import org.jeecgframework.core.common.service.impl.CommonServiceImpl;
import org.jeecgframework.core.util.ResourceUtil;
import org.jeecgframework.web.system.pojo.base.TSUser;
import org.jeecgframework.web.system.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import nsh.xinmi.npa.authority.service.AutorityServiceI;

@Service("autorityService")
@Transactional
public class AutorityServiceImpl extends CommonServiceImpl implements AutorityServiceI {
    @Autowired
    private UserService userService;

    @Override
    public Boolean btn_settle() {
        // 根据用户过滤查看的数据,只有admin,或者npa_admin的管理员可以查看所有的,其它用户只能查看自己所属支行的数据
        TSUser loginUser = ResourceUtil.getSessionUser();
        String userRoles = userService.getUserRole(loginUser);
        String npa_mag_role_code = ResourceUtil.getConfigByName("npa_mag_role_code");

        if ("admin".equals(loginUser.getUserName()) || userRoles.indexOf(npa_mag_role_code) > -1)
            return true;
        else
            return false;
    }


}
