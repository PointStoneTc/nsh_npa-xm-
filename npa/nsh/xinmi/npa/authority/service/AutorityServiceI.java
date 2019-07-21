package nsh.xinmi.npa.authority.service;

import org.jeecgframework.core.common.service.CommonService;

public interface AutorityServiceI extends CommonService {  
    /**
     * @Title: 根据登录人判断结清按钮是否可以操作
     * 
     * @return
     */
    Boolean btn_settle();
}
