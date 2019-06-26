package nsh.xinmi.npa.recoveryMoney.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.jeecgframework.core.common.controller.BaseController;
import org.jeecgframework.core.common.hibernate.qbc.CriteriaQuery;
import org.jeecgframework.core.common.model.json.AjaxJson;
import org.jeecgframework.core.common.model.json.DataGrid;
import org.jeecgframework.core.util.oConvertUtils;
import org.jeecgframework.tag.core.easyui.TagUtil;
import org.jeecgframework.web.system.service.SystemService;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import nsh.xinmi.npa.recoveryMoney.entity.RecoveryMoney;
import nsh.xinmi.npa.recoveryMoney.service.RecoveryMoneyServiceI;

/**
 * @Title: Controller
 * @Description: 借款合同回款
 * @author 赵琦
 * @date 2019-01-21 13:00:00
 * @version V1.0
 *
 */
@Controller
@RequestMapping("/recoveryMoney")
public class RecoveryMoneyController extends BaseController {
    private static final Logger logger = LoggerFactory.getLogger(RecoveryMoneyController.class);

    /*--------------------------------------------
    |             Variable                       |
    ============================================*/
    private String message;

    /*--------------------------------------------
    |             Injection                      |
    ============================================*/
    @Autowired
    private RecoveryMoneyServiceI recoveryMoneyService;

    @Autowired
    private SystemService systemService;

    /*--------------------------------------------
    |             method                       |
    ============================================*/
    /**
     * @Title:收回款列表
     * @param id
     * @param req
     * @return
     */
    @RequestMapping(params = "list", method = RequestMethod.GET)
    public ModelAndView list(@RequestParam(value = "id", required = true) Long id, HttpServletRequest req) {
        ModelAndView mv = new ModelAndView("npa/contract/recovery_list");
        mv.addObject("id", id);
        return mv;
    }

    /**
     * @Title:收回款列表datagrid数据
     * @param id
     * @param request
     * @param response
     * @param dataGrid
     */
    @RequestMapping(params = "datagrid", method = RequestMethod.POST)
    @ResponseBody
    public void datagrid(@RequestParam(value = "id", required = true) Long id, HttpServletRequest request, HttpServletResponse response, DataGrid dataGrid) {
        CriteriaQuery cq = new CriteriaQuery(RecoveryMoney.class, dataGrid);
        cq.eq("loanContracId", id);
        cq.eq("isDelete", "0");
        cq.add();
        systemService.getDataGridReturn(cq, true);
        TagUtil.datagrid(response, dataGrid);
    }

    /**
     * @Title:借款合同登记保存或更新
     * 
     * @param recoveryMoney
     * @param req
     * @return
     */
    @RequestMapping(params = "saveOrUpdate", method = RequestMethod.POST)
    @ResponseBody
    public AjaxJson saveOrUpdate(RecoveryMoney recoveryMoney, HttpServletRequest req) {
        AjaxJson j = new AjaxJson();
        boolean sucess = false;
        try {
            if (oConvertUtils.isNotEmpty(recoveryMoney.getId())) { // 更新
                j.setSuccess(true);
                j.setMsg("更新成功!");
                logger.info("update sucess: " + recoveryMoney);
            } else {
                sucess = recoveryMoneyService.saveMain(recoveryMoney);
                j.setSuccess(sucess);
                j.setMsg("保存成功!");
                logger.info("save sucess: " + recoveryMoney);
            }
        } catch (Exception e) {
            j.setSuccess(sucess);
            j.setMsg("保存异常, 请联系管理员!");
            logger.error("saveOrUpdate error", e.getMessage());
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
