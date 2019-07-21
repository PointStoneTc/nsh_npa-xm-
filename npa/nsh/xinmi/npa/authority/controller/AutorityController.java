package nsh.xinmi.npa.authority.controller;

import org.jeecgframework.core.common.controller.BaseController;
import org.jeecgframework.core.common.model.json.AjaxJson;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import nsh.xinmi.npa.authority.service.AutorityServiceI;

/**
 * @Title: Controller
 * @Description: 权限控制
 * @author 赵琦
 * @date 2019-07-21 10:00:00
 * @version V1.0
 *
 */
@Controller
@RequestMapping("/autority")
public class AutorityController extends BaseController {
    private static final Logger logger = LoggerFactory.getLogger(AutorityController.class);

    /*--------------------------------------------
    |             Variable                       |
    ============================================*/
    private String message;

    /*--------------------------------------------
    |             Injection                      |
    ============================================*/
    @Autowired
    private AutorityServiceI autorityService;

    /*--------------------------------------------
    |             method                       |
    ============================================*/

    /**
     * @Title: 查询是否有结清按钮的操作权限
     * @return
     */
    @RequestMapping(value = "/btn", params = "settle", method = RequestMethod.POST)
    @ResponseBody
    public AjaxJson btnSettle() {
        AjaxJson j = new AjaxJson();
        boolean sucess = false;
        try {
            sucess = autorityService.btn_settle();
            j.setSuccess(sucess);
            j.setMsg("查询成功!");
            logger.info("query sucess: btn_settle");
        } catch (Exception e) {
            j.setSuccess(sucess);
            j.setMsg("查询异常, 请联系管理员!");
            logger.error("query error", e.getMessage());
        }
        return j;
    }

    public String getMessage() {
        return message;
    }

    public void setMessage(String message) {
        this.message = message;
    }

}
