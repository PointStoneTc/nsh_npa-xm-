package nsh.xinmi.npa.loanContract.controller;

import java.util.Date;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.jeecgframework.core.common.controller.BaseController;
import org.jeecgframework.core.common.model.json.AjaxJson;
import org.jeecgframework.core.common.model.json.DataGrid;
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
import nsh.xinmi.npa.loanContract.service.LoanContractErrorServiceI;
import nsh.xinmi.npa.loanContract.view.LoanContractRegisterView;

/**
 * @Title: Controller
 * @Description: 借款合同错误数据修正
 * @author 赵琦
 * @date 2019-05-17 13:00:00
 * @version V1.0
 *
 */
@Controller
@RequestMapping("/loancontract/error")
public class LoanContractErrorController extends BaseController {
    private static final Logger logger = LoggerFactory.getLogger(LoanContractErrorController.class);

    /*--------------------------------------------
    |             Variable                       |
    ============================================*/
    private String message;

    /*--------------------------------------------
    |             Injection                      |
    ============================================*/
    @Autowired
    private LoanContractErrorServiceI loanContractErrorService;

    @Autowired
    private SystemService systemService;

    /*--------------------------------------------
    |             method                       |
    ============================================*/

    /**
     * @Title:错误借款合同列表
     * 
     * @param req
     * @return
     */
    @RequestMapping(params = "list", method = RequestMethod.GET)
    public ModelAndView registerList(HttpServletRequest req) {
        ModelAndView mv = new ModelAndView("npa/contract/error_list");
        return mv;
    }

    /**
     * @Title:错误借款合同datagrid数据
     * 
     * @param loanContractRegisterView
     * @param request
     * @param response
     * @param dataGrid
     */
    @RequestMapping(params = "datagrid", method = RequestMethod.POST)
    @ResponseBody
    public void registerDatagrid(LoanContractRegisterView loanContractRegisterView, String errorType, HttpServletRequest request, HttpServletResponse response, DataGrid dataGrid) {
        loanContractErrorService.getLoanContractRegisterList(loanContractRegisterView, errorType, dataGrid);
        TagUtil.datagrid(response, dataGrid);
    }

    /**
     * @Title:更新错误借款合同借款人信息跳转
     * 
     * @param req
     * @return
     */
    @RequestMapping(params = "toUpdateBorrower", method = RequestMethod.GET)
    public ModelAndView toUpdateBorrower(HttpServletRequest req) {
        ModelAndView mv = new ModelAndView("npa/contract/error_updateBorrower");
        mv.addObject("ids", req.getParameter("ids"));
        mv.addObject("name", req.getParameter("name"));
        mv.addObject("idNumber", req.getParameter("idNumber"));
        mv.addObject("indexs", req.getParameter("indexs"));
        return mv;
    }

    /**
     * @Title:更新错误借款合同借款人信息
     * 
     * @param ids 主键s
     * @param name 姓名
     * @param sex 性别
     * @param birthday 生日
     * @param idNumber 身份证号
     * @param req
     * @return
     */
    @RequestMapping(params = "updateBorrower", method = RequestMethod.POST)
    @ResponseBody
    public AjaxJson updateBorrower(@RequestParam(value = "ids", required = true) String ids, @RequestParam(value = "name", required = true) String name,
            @RequestParam(value = "sex", required = true) String sex, @RequestParam(value = "birthday", required = true) Date birthday,
            @RequestParam(value = "idNumber", required = true) String idNumber, HttpServletRequest req) {
        AjaxJson j = new AjaxJson();
        boolean sucess = false;
        try {
            sucess = loanContractErrorService.updateBorrower(ids, name, sex, birthday, idNumber);
            j.setSuccess(sucess);
            j.setMsg("更新成功!");
            logger.info("updateBorrower sucess:" + ids);
        } catch (Exception e) {
            j.setSuccess(sucess);
            j.setMsg("更新异常, 请联系管理员!");
            logger.error("updateBorrower error", e.getMessage());
        }
        return j;
    }

    /**
     * @Title:更新错误借款合同担保人信息跳转
     * 
     * @param req
     * @return
     */
    @RequestMapping(params = "toUpdateGuarantee", method = RequestMethod.GET)
    public ModelAndView toUpdateGuarantee(HttpServletRequest req) {
        ModelAndView mv = new ModelAndView("npa/contract/error_updateGuarantee");
        mv.addObject("ids", req.getParameter("ids"));
        mv.addObject("names", req.getParameter("names").split(","));
        mv.addObject("idNumbers", req.getParameter("idNumbers").split(","));
        mv.addObject("indexs", req.getParameter("indexs"));
        return mv;
    }

    /**
     * @Title:更新错误借款合同担保人信息
     * 
     * @param ids 主键s
     * @param name 姓名
     * @param sex 性别
     * @param birthday 生日
     * @param idNumber 身份证号
     * @param req
     * @return
     */
    @RequestMapping(params = "updateGuarantee", method = RequestMethod.POST)
    @ResponseBody
    public AjaxJson updateGuarantee(@RequestParam(value = "ids", required = true) String ids, @RequestParam(value = "name", required = true) String name,
            @RequestParam(value = "sex", required = true) String sex, @RequestParam(value = "birthday", required = true) String birthday,
            @RequestParam(value = "idNumber", required = true) String idNumber, HttpServletRequest req) {
        AjaxJson j = new AjaxJson();
        boolean sucess = false;
        try {
            sucess = loanContractErrorService.updateGuarantee(ids, name, sex, birthday, idNumber);
            j.setSuccess(sucess);
            j.setMsg("更新成功!");
            logger.info("updateGuarantee sucess:" + ids);
        } catch (Exception e) {
            j.setSuccess(sucess);
            j.setMsg("更新异常, 请联系管理员!");
            logger.error("updateGuarantee error", e.getMessage());
        }
        return j;
    }

    /**
     * @Title:更新错误借款合同贷款发放日、到期日信息跳转
     * 
     * @param req
     * @return
     */
    @RequestMapping(params = "toUpdateIssueDueDate", method = RequestMethod.GET)
    public ModelAndView toUpdateIssueDueDate(HttpServletRequest req) {
        ModelAndView mv = new ModelAndView("npa/contract/error_updateIssueDueDate");
        mv.addObject("id", req.getParameter("id"));
        mv.addObject("issueDate", req.getParameter("issueDate"));
        mv.addObject("dueDate", req.getParameter("dueDate"));
        mv.addObject("index", req.getParameter("index"));
        return mv;
    }

    /**
     * @Title:更新错误借款合同贷款发放日、到期日信息
     * 
     * @param id 主键
     * @param issueDate 贷款发放日
     * @param dueDate 贷款到期日
     * @param req
     * @return
     */
    @RequestMapping(params = "updateIssueDueDate", method = RequestMethod.POST)
    @ResponseBody
    public AjaxJson updateIssueDueDate(@RequestParam(value = "id", required = true) Long id, @RequestParam(value = "issueDate", required = true) Date issueDate,
            @RequestParam(value = "dueDate", required = true) Date dueDate, HttpServletRequest req) {
        AjaxJson j = new AjaxJson();
        boolean sucess = false;
        try {
            sucess = loanContractErrorService.updateIssueDueDate(id, issueDate, dueDate);
            j.setSuccess(sucess);
            j.setMsg("更新成功!");
            logger.info("updateIssueDueDate sucess:" + id);
        } catch (Exception e) {
            j.setSuccess(sucess);
            j.setMsg("更新异常, 请联系管理员!");
            logger.error("updateIssueDueDate error", e.getMessage());
        }
        return j;
    }

    /**
     * @Title:提交错误借款合同信息
     * 
     * @param ids 主键s
     * @param req
     * @return
     */
    @RequestMapping(params = "commit", method = RequestMethod.POST)
    @ResponseBody
    public AjaxJson commit(@RequestParam(value = "ids", required = true) String ids, HttpServletRequest req) {
        AjaxJson j = new AjaxJson();
        boolean sucess = false;
        try {
            sucess = loanContractErrorService.commit(ids);
            j.setSuccess(sucess);
            j.setMsg("提交成功!");
            logger.info("update sucess:" + ids);
        } catch (Exception e) {
            j.setSuccess(sucess);
            j.setMsg("提交异常, 请联系管理员!");
            logger.error("commit error", e.getMessage());
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
