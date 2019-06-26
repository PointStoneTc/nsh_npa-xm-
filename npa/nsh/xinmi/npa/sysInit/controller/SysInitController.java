package nsh.xinmi.npa.sysInit.controller;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.jeecgframework.core.common.controller.BaseController;
import org.jeecgframework.core.common.model.json.AjaxJson;
import org.jeecgframework.core.common.model.json.DataGrid;
import org.jeecgframework.tag.core.easyui.TagUtil;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.multipart.MultipartHttpServletRequest;
import org.springframework.web.servlet.ModelAndView;

import nsh.xinmi.npa.corporateOrg.service.CorporateOrgServiceI;
import nsh.xinmi.npa.sysInit.service.SysInitServiceI;

/**
 * @Title: Controller
 * @Description: 系统初始化
 * @author 赵琦
 * @date 2019-01-29 09:22:00
 * @version V1.0
 *
 */
@Controller
@RequestMapping("/sysInit")
public class SysInitController extends BaseController {
    private static final Logger logger = LoggerFactory.getLogger(SysInitController.class);

    /*--------------------------------------------
    |             Variable                       |
    ============================================*/
    private String message;

    /*--------------------------------------------
    |             Injection                      |
    ============================================*/
    @Autowired
    private SysInitServiceI sysInitServiceI;

    @Autowired
    private CorporateOrgServiceI corporateOrgService;

    /*--------------------------------------------
    |             method                       |
    ============================================*/
    /**
     * @Title:系统初始化index
     * @param req
     * @return
     */
    @RequestMapping(value = "loancontract", params = "index", method = RequestMethod.GET)
    public ModelAndView loancontractIndex(HttpServletRequest req) {
        ModelAndView mv = new ModelAndView("npa/sysInit/loancontract_index");
        mv.addObject("dictOrg", corporateOrgService.getAllList());
        try {
            sysInitServiceI.deleteAllData();
        } catch (Exception e) {
            logger.error(e.getMessage());
        }
        return mv;
    }

    /**
     * @Title:系统初始化index-合同列表datagrid数据
     * @param request
     * @param response
     * @param dataGrid
     */
    @RequestMapping(value = "loancontract", params = "ltDatagrid", method = RequestMethod.GET)
    @ResponseBody
    public void loancontractLtDatagrid(HttpServletRequest request, HttpServletResponse response, DataGrid dataGrid) {
        sysInitServiceI.initltDatagrid(dataGrid);
        TagUtil.datagrid(response, dataGrid);
    }

    /**
     * 导入功能跳转
     * 
     * @return
     */
    @RequestMapping(params = "upload")
    public ModelAndView loancontractUpload(HttpServletRequest req) {
        return new ModelAndView("npa/sysInit/loancontract_excel_upload");
    }

    /**
     * 导入合同
     * 
     * @param request
     * @param response
     * @return
     */
    @RequestMapping(params = "importExcel", method = RequestMethod.POST)
    @ResponseBody
    public AjaxJson loancontractImportExcel(HttpServletRequest request, HttpServletResponse response) {
        AjaxJson j = new AjaxJson();
        try {
            MultipartHttpServletRequest multipartRequest = (MultipartHttpServletRequest) request;
            int rst = sysInitServiceI.ltImportExcel(multipartRequest.getFileMap());
            j.setSuccess(rst > 0);
            j.setMsg("文件导入成功, 共计:" + rst + "条数据!");
        } catch (Exception e) {
            j.setSuccess(false);
            j.setMsg(e.getMessage());
            logger.error(e.getMessage());
        }
        return j;
    }

    /**
     * 生成临时数据
     * 
     * @param request
     * @param response
     * @return
     */
    @RequestMapping(value = "loancontract", params = "createResult", method = RequestMethod.POST)
    @ResponseBody
    public AjaxJson loancontractCreateResult(HttpServletRequest request, HttpServletResponse response) {
        AjaxJson j = new AjaxJson();
        try {
            boolean success = sysInitServiceI.createResult();
            j.setSuccess(success);
            j.setMsg("生成成功!");
        } catch (Exception e) {
            j.setSuccess(false);
            j.setMsg(e.getMessage());
            logger.error(e.getMessage());
        }
        return j;
    }

    /**
     * @Title:系统初始化index-借款人列表datagrid数据
     * @param request
     * @param response
     * @param dataGrid
     */
    @RequestMapping(value = "loancontract/borrower", params = "datagrid", method = RequestMethod.GET)
    @ResponseBody
    public void loancontractBorrowerDatagrid(HttpServletRequest request, HttpServletResponse response, DataGrid dataGrid) {
        sysInitServiceI.initBorrowerDatagrid(dataGrid);
        TagUtil.datagrid(response, dataGrid);
    }

    /**
     * @Title:系统初始化index-担保人列表datagrid数据
     * @param request
     * @param response
     * @param dataGrid
     */
    @RequestMapping(value = "loancontract/guarantee", params = "datagrid", method = RequestMethod.GET)
    @ResponseBody
    public void loancontractGuaranteeDatagrid(HttpServletRequest request, HttpServletResponse response, DataGrid dataGrid) {
        sysInitServiceI.initGuaranteeDatagrid(dataGrid);
        TagUtil.datagrid(response, dataGrid);
    }
    
    /**
     * @Title:系统初始化index-身份证相同,姓名不同的人员列表datagrid数据
     * @param request
     * @param response
     * @param dataGrid
     */
    @RequestMapping(value = "loancontract/idnumberFix", params = "datagrid", method = RequestMethod.GET)
    @ResponseBody
    public void loancontractIdNumberFixDatagrid(HttpServletRequest request, HttpServletResponse response, DataGrid dataGrid) {
        sysInitServiceI.initIdNumberFixDatagrid(dataGrid);
        TagUtil.datagrid(response, dataGrid);
    }

    public String getMessage() {
        return message;
    }

    public void setMessage(String message) {
        this.message = message;
    }

}
