package nsh.xinmi.npa.naturalPerson.controller;

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
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.ResponseBody;
import org.springframework.web.servlet.ModelAndView;

import nsh.xinmi.npa.naturalPerson.entity.NaturalPerson;
import nsh.xinmi.npa.naturalPerson.service.NaturalPersonServiceI;

/**
 * @Title: Controller
 * @Description: 自然人
 * @author 赵琦
 * @date 2019-01-21 13:00:00
 * @version V1.0
 *
 */
@Controller
@RequestMapping("/naturalPerson")
public class NaturalPersonController extends BaseController {
    private static final Logger logger = LoggerFactory.getLogger(NaturalPersonController.class);

    /*--------------------------------------------
    |             Variable                       |
    ============================================*/
    private String message;

    /*--------------------------------------------
    |             Injection                      |
    ============================================*/
    @Autowired
    private NaturalPersonServiceI naturalPersonService;

    /*--------------------------------------------
    |             method                       |
    ============================================*/
    /**
     * @Title:借款人列表
     * @param request
     * @return
     */
    @RequestMapping(value = "/borrower", params = "list", method = RequestMethod.GET)
    public String borrowerList(HttpServletRequest request) {
        return "npa/naturalPerson/borrower_list";
    }

    /**
     * @Title:借款人列表datagrid数据
     * @param naturalPerson
     * @param request
     * @param response
     * @param dataGrid
     */
    @RequestMapping(value = "/borrower", params = "datagrid", method = RequestMethod.POST)
    @ResponseBody
    public void borrowerDatagrid(NaturalPerson naturalPerson, HttpServletRequest request, HttpServletResponse response, DataGrid dataGrid) {
        naturalPersonService.getBorrowerList(naturalPerson, dataGrid);
        TagUtil.datagrid(response, dataGrid);
    }

    /**
     * @Title:担保人列表
     * @param request
     * @return
     */
    @RequestMapping(value = "/guarantee", params = "list", method = RequestMethod.GET)
    public String guaranteeList(HttpServletRequest request) {
        return "npa/naturalPerson/guarantee_list";
    }

    /**
     * @Title:担保人datagrid数据
     * @param naturalPerson
     * @param request
     * @param response
     * @param dataGrid
     */
    @RequestMapping(value = "/guarantee", params = "datagrid", method = RequestMethod.POST)
    @ResponseBody
    public void guaranteeDatagrid(NaturalPerson naturalPerson, HttpServletRequest request, HttpServletResponse response, DataGrid dataGrid) {
        naturalPersonService.getGuaranteeList(naturalPerson, dataGrid);
        TagUtil.datagrid(response, dataGrid);
    }

    /**
     * @Title: 借款人修改跳转
     * @param id
     * @param request
     * @return
     */
    @RequestMapping(value = "/borrower", params = "toUpdateDetail", method = RequestMethod.GET)
    public ModelAndView borrowerToUpdateDetail(@RequestParam(value = "id", required = true) Long id, HttpServletRequest request) {
        ModelAndView mv = new ModelAndView("npa/naturalPerson/person_update_detail");
        NaturalPerson person = naturalPersonService.get(NaturalPerson.class, id);
        mv.addObject("person", person);
        return mv;
    }

    /**
     * @Title: 担保人修改跳转
     * @param id
     * @param request
     * @return
     */
    @RequestMapping(value = "/guarantee", params = "toUpdateDetail", method = RequestMethod.GET)
    public ModelAndView guaranteeToUpdateDetail(@RequestParam(value = "id", required = true) Long id, HttpServletRequest request) {
        ModelAndView mv = new ModelAndView("npa/naturalPerson/person_update_detail");
        NaturalPerson person = naturalPersonService.get(NaturalPerson.class, id);
        mv.addObject("person", person);
        return mv;
    }

    /**
     * @Title: 借款人修改
     * @param naturalPerson
     * @param request
     * @param response
     * @return
     */
    @RequestMapping(value = "/borrower", params = "saveOrUpdate", method = RequestMethod.POST)
    @ResponseBody
    public AjaxJson borrowerSaveOrUpdate(NaturalPerson naturalPerson, HttpServletRequest request, HttpServletResponse response) {
        AjaxJson j = new AjaxJson();
        boolean sucess = false;
        try {
            sucess = naturalPersonService.updateDetail(naturalPerson);
            j.setSuccess(sucess);
            j.setMsg("更新成功!");
            logger.info("update sucess: " + naturalPerson);
        } catch (Exception e) {
            j.setSuccess(sucess);
            j.setMsg("保存异常, 请联系管理员!");
            logger.error("saveOrUpdate error", e.getMessage());
        }
        return j;
    }

    /**
     * @Title: 借款人修改
     * @param naturalPerson
     * @param request
     * @param response
     * @return
     */
    @RequestMapping(value = "/guarantee", params = "saveOrUpdate", method = RequestMethod.POST)
    @ResponseBody
    public AjaxJson guaranteeSaveOrUpdate(NaturalPerson naturalPerson, HttpServletRequest request, HttpServletResponse response) {
        AjaxJson j = new AjaxJson();
        boolean sucess = false;
        try {
            sucess = naturalPersonService.updateDetail(naturalPerson);
            j.setSuccess(sucess);
            j.setMsg("更新成功!");
            logger.info("update sucess: " + naturalPerson);
        } catch (Exception e) {
            j.setSuccess(sucess);
            j.setMsg("保存异常, 请联系管理员!");
            logger.error("saveOrUpdate error", e.getMessage());
        }
        return j;
    }

    /**
     * @Title:选择一个自然人
     * @param excludeIds
     * @param request
     * @return
     */
    @RequestMapping(value = "/select", params = "one", method = RequestMethod.GET)
    public ModelAndView selectOnePerson(String excludeIdNumbers, HttpServletRequest request) {
        ModelAndView mv = new ModelAndView("npa/naturalPerson/selectOnePerson_dialog");
        mv.addObject("excludeIdNumbers", excludeIdNumbers);
        return mv;
    }

    /**
     * @Title:选择一个自然人datagrid数据
     * @param excludeIdNumbers
     * @param naturalPerson
     * @param request
     * @param response
     * @param dataGrid
     * @return
     */
    @RequestMapping(value = "/select", params = "oneDatagrid", method = RequestMethod.POST)
    @ResponseBody
    public void selectOnePersonDatagrid(String excludeIdNumbers, NaturalPerson naturalPerson, HttpServletRequest request, HttpServletResponse response, DataGrid dataGrid) {
        naturalPersonService.getOnePersonList(excludeIdNumbers, naturalPerson, dataGrid);
        TagUtil.datagrid(response, dataGrid);
    }

    /**
     * @Title: 查询身份证号是否存在
     * @param idNumber
     * @param request
     * @param response
     * @return
     */
    @RequestMapping(value = "/idNumber", params = "isExist", method = RequestMethod.POST)
    @ResponseBody
    public AjaxJson idNumberIsExist(@RequestParam(value = "idNumber", required = true) String idNumber, HttpServletRequest request, HttpServletResponse response) {
        AjaxJson j = new AjaxJson();
        try {
            NaturalPerson person = naturalPersonService.isExist(idNumber);
            j.setSuccess(person != null);
            j.setMsg("查询成功!");
            logger.info("query idNumberIsExist sucess: " + idNumber);
        } catch (Exception e) {
            j.setSuccess(false);
            j.setMsg("请求异常, 请联系管理员!");
            logger.error("query idNumberIsExist error", e.getMessage());
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
