package nsh.xinmi.npa.corporateOrg.controller;

import java.util.List;
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
import nsh.xinmi.npa.corporateOrg.entity.CorporateOrg;
import nsh.xinmi.npa.corporateOrg.entity.CorporateOrgUser;
import nsh.xinmi.npa.corporateOrg.service.CorporateOrgServiceI;

/**
 * @Title: Controller
 * @Description: 法人组织机构
 * @author 赵琦
 * @date 2019-01-21 13:00:00
 * @version V1.0
 *
 */
@Controller
@RequestMapping("/corporateOrg")
public class CorporateOrgController extends BaseController {
    private static final Logger logger = LoggerFactory.getLogger(CorporateOrgController.class);

    /*--------------------------------------------
    |             Variable                       |
    ============================================*/
    private String message;

    /*--------------------------------------------
    |             Injection                      |
    ============================================*/
    @Autowired
    private CorporateOrgServiceI corporateOrgService;

    @Autowired
    private SystemService systemService;

    /*--------------------------------------------
    |             method                       |
    ============================================*/
    /**
     * @Title:获取法人组织机构列表
     * @param request
     * @return
     */
    @RequestMapping(params = "list", method = RequestMethod.GET)
    public String list(HttpServletRequest request) {
        List<CorporateOrg> list = corporateOrgService.getAllList();
        StringBuffer sb = new StringBuffer();
        for (CorporateOrg org : list) {
            sb.append(org.getId()).append(":").append(org.getNameShorter()).append(";");
        }
        if (sb.length() > 0)
            sb.deleteCharAt(sb.length() - 1);
        request.setAttribute("orgList", sb.toString());
        return "npa/corporateOrg/corporateOrg_list";
    }

    /**
     * @Title:获取法人组织机构datagrid数据
     * @param corporateOrg
     * @param request
     * @param response
     * @param dataGrid
     */
    @RequestMapping(params = "datagrid", method = RequestMethod.POST)
    @ResponseBody
    public void datagrid(CorporateOrg corporateOrg, HttpServletRequest request, HttpServletResponse response, DataGrid dataGrid) {
        corporateOrgService.getAllList(corporateOrg, dataGrid);
        TagUtil.datagrid(response, dataGrid);
    }

    /**
     * @Title:获取法人组织机构操作员datagrid数据
     * @param id
     * @param request
     * @param response
     * @param dataGrid
     */
    @RequestMapping(value = "/operator", params = "datagrid", method = RequestMethod.POST)
    @ResponseBody
    public void userDatagrid(Long id, HttpServletRequest request, HttpServletResponse response, DataGrid dataGrid) {
        corporateOrgService.getOperatorListByCorporateOrgId(id, dataGrid);
        TagUtil.datagrid(response, dataGrid);
    }

    /**
     * @Title:获取法人组织机构操作员新增
     * @param corporateOrgUser
     * @param request
     * @return
     */
    @RequestMapping(value = "/operator", params = "saveOrUpdate", method = RequestMethod.POST)
    @ResponseBody
    public AjaxJson userSaveOrUpdate(CorporateOrgUser corporateOrgUser, HttpServletRequest request) {
        AjaxJson j = new AjaxJson();
        try {
            corporateOrgService.save(corporateOrgUser);
            j.setSuccess(true);
            j.setMsg("保存成功!");
            logger.info("save sucess: " + corporateOrgUser);
        } catch (Exception e) {
            j.setSuccess(false);
            j.setMsg("保存异常, 请联系管理员!");
            logger.error("saveOrUpdate error", e.getMessage());
        }
        return j;
    }

    /**
     * @Title:获取法人组织机构操作员删除
     * @param id
     * @param req
     * @return
     */
    @RequestMapping(value = "/operator", params = "del", method = RequestMethod.POST)
    @ResponseBody
    public AjaxJson registerDel(@RequestParam(value = "id", required = true) Long id, HttpServletRequest req) {
        AjaxJson j = new AjaxJson();
        try {
            systemService.deleteEntityById(CorporateOrgUser.class, id);
            j.setSuccess(true);
            j.setMsg("删除成功!");
            logger.info("update sucess: " + id);
        } catch (Exception e) {
            j.setSuccess(false);
            j.setMsg("删除异常, 请联系管理员!");
            logger.error("update error", e.getMessage());
        }
        return j;
    }

    /**
     * @Title:获取法人组织机构操作员调动
     * @param id
     * @param orgid
     * @param req
     * @return
     */
    @RequestMapping(value = "/operator", params = "dep", method = RequestMethod.POST)
    @ResponseBody
    public AjaxJson registerDep(@RequestParam(value = "id", required = true) Long id, @RequestParam(value = "orgId", required = true) Long orgId, HttpServletRequest req) {
        AjaxJson j = new AjaxJson();
        boolean success = false;
        try {
            success = corporateOrgService.optOperator(id, orgId);
            if (success)
                j.setMsg("调动成功!");
            else
                j.setMsg("调动失败,此人已经在调动部门,重新选择!");
            j.setSuccess(true);
            logger.info("dep sucess: " + id);
        } catch (Exception e) {
            j.setSuccess(false);
            j.setMsg("调动异常, 请联系管理员!");
            logger.error("dep error", e.getMessage());
        }
        return j;
    }

    /**
     * @Title:选择一个用户
     * @param orgId
     * @param request
     * @return
     */
    @RequestMapping(value = "/operator/select", params = "one", method = RequestMethod.GET)
    public ModelAndView selectOneOperator(@RequestParam(value = "orgId", required = true) Long orgId, HttpServletRequest request) {
        ModelAndView mv = new ModelAndView("npa/corporateOrg/selectOneOperator_dialog");
        mv.addObject("orgId", orgId);
        return mv;
    }

    /**
     * @Title:选择一个用户datagrid数据
     * @param orgId
     * @param request
     * @param response
     * @param dataGrid
     */
    @RequestMapping(value = "/operator/select", params = "oneDatagrid", method = RequestMethod.POST)
    @ResponseBody
    public void selectOneOperatorDatagrid(Long orgId, HttpServletRequest request, HttpServletResponse response, DataGrid dataGrid) {
        corporateOrgService.getOneOperatorList(orgId, dataGrid);
        TagUtil.datagrid(response, dataGrid);
    }

    public String getMessage() {
        return message;
    }

    public void setMessage(String message) {
        this.message = message;
    }
}
