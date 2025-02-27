package nsh.xinmi.npa.loanContract.controller;

import java.util.Date;
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
import nsh.xinmi.npa.loanContract.service.LoanContractErrorServiceI;
import nsh.xinmi.npa.loanContract.view.LoanContractRegisterView;
import nsh.xinmi.npa.naturalPerson.service.NaturalPersonServiceI;

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
  private NaturalPersonServiceI naturalPersonService;

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
    mv.addObject("address", req.getParameter("address"));
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
   * @param idNumber 身份证号
   * @param req
   * @return
   */
  @RequestMapping(params = "updateBorrower", method = RequestMethod.POST)
  @ResponseBody
  public AjaxJson updateBorrower(@RequestParam(value = "ids", required = true) String ids, @RequestParam(value = "name", required = true) String name,
      @RequestParam(value = "sex", required = true) String sex, @RequestParam(value = "birthday", required = true) Date birthday,
      @RequestParam(value = "idNumber", required = true) String idNumber, @RequestParam(value = "address", required = false) String address, HttpServletRequest req) {
    AjaxJson j = new AjaxJson();
    boolean sucess = false;
    try {
      sucess = loanContractErrorService.updateBorrower(ids, name, sex, birthday, idNumber, address);
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
    mv.addObject("id", req.getParameter("id"));
    String guaranteesNames = (String) req.getParameter("guaranteesNames");
    String guaranteesIdNumbers = (String) req.getParameter("guaranteesIdNumbers");
    String guaranteesAddresses = (String) req.getParameter("guaranteesAddresses");
    mv.addObject("guaranteesNames", "".equals(guaranteesNames) ? new String[] {} : guaranteesNames.split(","));
    mv.addObject("guaranteesIdNumbers", "".equals(guaranteesIdNumbers) ? new String[] {} : guaranteesIdNumbers.split(","));
    mv.addObject("guaranteesAddresses", "".equals(guaranteesIdNumbers) ? new String[] {} : guaranteesAddresses.split(","));
    mv.addObject("index", req.getParameter("index"));
    return mv;
  }

  /**
   * @Title:更新错误借款合同担保人信息
   * 
   * @param id 主键
   * @param guaranteesNames 担保人姓名s
   * @param guaranteesIdNumbers 担保人身份证号s
   * @param guaranteesAddresses 担保人地址s
   * @param req
   * @return
   */
  @RequestMapping(params = "updateGuarantee", method = RequestMethod.POST)
  @ResponseBody
  public AjaxJson updateGuarantee(@RequestParam(value = "id", required = true) String id, @RequestParam(value = "guaranteesNames", required = true) String guaranteesNames,
      @RequestParam(value = "guaranteesIdNumbers", required = true) String guaranteesIdNumbers,
      @RequestParam(value = "guaranteesAddresses", required = true) String guaranteesAddresses, HttpServletRequest req) {
    AjaxJson j = new AjaxJson();
    boolean sucess = false;
    try {
      sucess = loanContractErrorService.updateGuarantee(id, guaranteesNames, guaranteesIdNumbers, guaranteesAddresses);
      j.setSuccess(sucess);
      j.setMsg("更新成功!");
      logger.info("updateGuarantee sucess:" + id);
    } catch (Exception e) {
      e.printStackTrace();
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
   * @Title:更新错误借款合同贷款其它信息跳转
   * 
   * @param req
   * @return
   */
  @RequestMapping(params = "toUpdateOther", method = RequestMethod.GET)
  public ModelAndView toUpOther(HttpServletRequest req) {
    ModelAndView mv = new ModelAndView("npa/contract/error_updateOther");
    mv.addObject("id", req.getParameter("id"));
    mv.addObject("interestRate", req.getParameter("interestRate"));
    mv.addObject("officer", req.getParameter("officer"));
    mv.addObject("guaranteeMode", req.getParameter("guaranteeMode"));
    mv.addObject("disposeMode", req.getParameter("disposeMode"));
    mv.addObject("litigationStat", req.getParameter("litigationStat"));
    mv.addObject("index", req.getParameter("index"));
    return mv;
  }

  /**
   * @Title: 更新错误借款合同贷款其它信息信息
   * 
   * @param id 主键
   * @param interestRate 利率
   * @param officer 信贷员
   * @param guaranteeMode 担保方式
   * @param disposeMode 处理方式
   * @param litigationStat 诉讼状态
   * @param req
   * @return
   */
  @RequestMapping(params = "updateOther", method = RequestMethod.POST)
  @ResponseBody
  public AjaxJson updateOther(@RequestParam(value = "id", required = true) Long id, @RequestParam(value = "interestRate", required = true) Double interestRate,
      @RequestParam(value = "officer", required = true) String officer, @RequestParam(value = "guaranteeMode", required = true) String guaranteeMode,
      @RequestParam(value = "disposeMode", required = true) String disposeMode, @RequestParam(value = "litigationStat", required = true) String litigationStat,
      HttpServletRequest req) {
    AjaxJson j = new AjaxJson();
    boolean sucess = false;
    try {
      sucess = loanContractErrorService.updateOther(id, interestRate, officer, guaranteeMode, disposeMode, litigationStat);
      j.setSuccess(sucess);
      j.setMsg("更新成功!");
      logger.info("updateOther sucess:" + id);
    } catch (Exception e) {
      j.setSuccess(sucess);
      j.setMsg("更新异常, 请联系管理员!");
      logger.error("updateOther error", e.getMessage());
    }
    return j;
  }

  /**
   * @Title: 更新错误借款合同贷款地址信息
   * 
   * @param idNumber 身份证号码
   * @param address 地址
   * @param req
   * @return
   */
  @RequestMapping(params = "updateAddress", method = RequestMethod.POST)
  @ResponseBody
  public AjaxJson updateAddress(@RequestParam(value = "idNumber", required = true) String idNumber, @RequestParam(value = "address", required = true) String address,
      HttpServletRequest req) {
    AjaxJson j = new AjaxJson();
    boolean sucess = false;
    try {
      sucess = loanContractErrorService.updateAddress(idNumber, address);
      j.setSuccess(sucess);
      j.setMsg("更新成功!");
      logger.info("updateAddress sucess:" + idNumber);
    } catch (Exception e) {
      j.setSuccess(sucess);
      j.setMsg("更新异常, 请联系管理员!");
      logger.error("updateOther error", e.getMessage());
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
      logger.info("commit sucess:" + ids);
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
