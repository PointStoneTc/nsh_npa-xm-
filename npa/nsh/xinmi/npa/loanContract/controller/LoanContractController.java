package nsh.xinmi.npa.loanContract.controller;

import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.util.Date;
import java.util.List;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.jeecgframework.core.common.controller.BaseController;
import org.jeecgframework.core.common.model.json.AjaxJson;
import org.jeecgframework.core.common.model.json.DataGrid;
import org.jeecgframework.core.util.ResourceUtil;
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
import nsh.xinmi.npa.corporateOrg.service.CorporateOrgUserServiceI;
import nsh.xinmi.npa.loanContract.entity.LoanContract;
import nsh.xinmi.npa.loanContract.service.LoanContractServiceI;
import nsh.xinmi.npa.loanContract.view.LoanContractRegisterView;
import nsh.xinmi.npa.loanContract.view.LoanContractView;
import nsh.xinmi.npa.loanContract.view.ViContractQyView;
import nsh.xinmi.npa.loanContractGuarantee.entity.LoanContractGuarantee;
import nsh.xinmi.npa.loanContractGuarantee.service.LoanContractGuaranteeServiceI;
import nsh.xinmi.npa.naturalPerson.entity.NaturalPerson;

/**
 * @Title: Controller
 * @Description: 借款合同
 * @author 赵琦
 * @date 2019-01-21 13:00:00
 * @version V1.0
 *
 */
@Controller
@RequestMapping("/loancontract")
public class LoanContractController extends BaseController {
  private static final Logger logger = LoggerFactory.getLogger(LoanContractController.class);

  /*--------------------------------------------
  |             Variable                       |
  ============================================*/
  private String message;

  /*--------------------------------------------
  |             Injection                      |
  ============================================*/
  @Autowired
  private LoanContractServiceI loanContractService;

  @Autowired
  private LoanContractGuaranteeServiceI loanContractGuaranteeService;

  @Autowired
  private CorporateOrgUserServiceI corporateOrgUserService;

  @Autowired
  private SystemService systemService;

  /*--------------------------------------------
  |             method                       |
  ============================================*/

  /**
   * @Title:借款合同登记列表
   * 
   * @param req
   * @return
   */
  @RequestMapping(value = "/register", params = "list", method = RequestMethod.GET)
  public ModelAndView registerList(HttpServletRequest req) {
    ModelAndView mv = new ModelAndView("npa/contract/register_list");
    return mv;
  }

  /**
   * @Title:借款合同登记datagrid数据
   * 
   * @param loanContractRegisterView
   * @param request
   * @param response
   * @param dataGrid
   */
  @RequestMapping(value = "/register", params = "datagrid", method = RequestMethod.POST)
  @ResponseBody
  public void registerDatagrid(LoanContractRegisterView loanContractRegisterView, HttpServletRequest request, HttpServletResponse response, DataGrid dataGrid) {
    loanContractService.getLoanContractRegisterList(loanContractRegisterView, dataGrid);
    TagUtil.datagrid(response, dataGrid);
  }

  /**
   * @Title:借款合同登记新增
   * 
   * @param req
   * @return
   */
  @RequestMapping(value = "/register", params = "toAdd", method = RequestMethod.GET)
  public ModelAndView registerToAdd(HttpServletRequest req) {
    ModelAndView mv = new ModelAndView("npa/contract/register_view");
    mv.addObject("view", new LoanContractView());
    mv.addObject("dictOrg", corporateOrgUserService.getDictSelectByUser());
    return mv;
  }

  /**
   * @Title:借款合同登记更新
   * 
   * @param id 合同id
   * @param req
   * @return
   */
  @RequestMapping(value = "/register", params = "toUpdate", method = RequestMethod.GET)
  public ModelAndView registerToUpdate(@RequestParam(value = "id", required = true) Long id, HttpServletRequest req) {
    ModelAndView mv = new ModelAndView("npa/contract/register_view");
    LoanContractView loanContractView = new LoanContractView();
    LoanContract loanContract = systemService.getEntity(LoanContract.class, id);
    NaturalPerson borrower = systemService.get(NaturalPerson.class, loanContract.getBorrowerId()); // 借款人
    List<LoanContractGuarantee> loanContractGuarantees = loanContractGuaranteeService.getListByContractId(id);
    loanContractView.setLoanContract(loanContract);
    loanContractView.setBorrower(borrower);
    loanContractView.setLoanContractGuarantees(loanContractGuarantees);
    mv.addObject("view", loanContractView);
    mv.addObject("dictOrg", corporateOrgUserService.getDictSelectByUser());
    return mv;
  }

  /**
   * @Title:借款合同登记查看详情
   * 
   * @param id 合同id
   * @param req
   * @return
   */
  @RequestMapping(value = "/register", params = "toDetail", method = RequestMethod.GET)
  public ModelAndView registerToDetail(@RequestParam(value = "id", required = true) Long id, HttpServletRequest req) {
    ModelAndView mv = new ModelAndView("npa/contract/register_detail");
    LoanContractView loanContractView = new LoanContractView();
    LoanContract loanContract = systemService.getEntity(LoanContract.class, id);
    NaturalPerson borrower = systemService.get(NaturalPerson.class, loanContract.getBorrowerId()); // 借款人
    List<LoanContractGuarantee> loanContractGuarantees = loanContractGuaranteeService.getListByContractId(id);
    loanContractView.setLoanContract(loanContract);
    loanContractView.setBorrower(borrower);
    loanContractView.setLoanContractGuarantees(loanContractGuarantees);
    mv.addObject("view", loanContractView);
    return mv;
  }

  /**
   * @Title:借款合同登记保存或更新
   * 
   * @param loanContractView
   * @param req
   * @return
   */
  @RequestMapping(value = "/register", params = "saveOrUpdate", method = RequestMethod.POST)
  @ResponseBody
  public AjaxJson registerSaveOrUpdate(LoanContractView loanContractView, HttpServletRequest req) {
    AjaxJson j = new AjaxJson();
    boolean sucess = false;
    try {
      if (oConvertUtils.isNotEmpty(loanContractView.getLoanContract().getId())) { // 更新
        sucess = loanContractService.updateMain(loanContractView);
        j.setSuccess(sucess);
        j.setMsg("更新成功!");
        logger.info("update sucess: " + loanContractView);
      } else {
        sucess = loanContractService.saveMain(loanContractView);
        j.setSuccess(sucess);
        j.setMsg("保存成功!");
        logger.info("save sucess: " + loanContractView);
      }
    } catch (Exception e) {
      j.setSuccess(sucess);
      j.setMsg("保存异常, 请联系管理员!");
      logger.error("saveOrUpdate error", e.getMessage());
    }
    return j;
  }

  /**
   * @Title:借款合同登记删除
   * 
   * @param id 合同id
   * @param req
   * @return
   */
  @RequestMapping(value = "/register", params = "del", method = RequestMethod.POST)
  @ResponseBody
  public AjaxJson registerDel(@RequestParam(value = "id", required = true) Long id, HttpServletRequest req) {
    AjaxJson j = new AjaxJson();
    boolean sucess = false;
    try {
      sucess = loanContractService.deleteMain(id);
      j.setSuccess(sucess);
      j.setMsg("删除成功!");
      logger.info("update sucess: " + id);
    } catch (Exception e) {
      j.setSuccess(sucess);
      j.setMsg("删除异常, 请联系管理员!");
      logger.error("update error", e.getMessage());
    }
    return j;
  }

  /**
   * @Title:借款合同登记收回款初始化
   * 
   * @param id 合同id
   * @param req
   * @return
   */
  @RequestMapping(value = "/register", params = "toInitRecoveryMoney", method = RequestMethod.GET)
  public ModelAndView registerToInitRecoveryMoney(@RequestParam(value = "id", required = true) Long id, @RequestParam(value = "index", required = true) Integer index,
      HttpServletRequest req) {
    ModelAndView mv = new ModelAndView("npa/contract/register_initRecoveryMoney");
    LoanContract loanContract = systemService.getEntity(LoanContract.class, id);
    mv.addObject("loanContract", loanContract);
    mv.addObject("index", index);
    return mv;
  }

  /**
   * @Title:借款合同登记更新收回款初始化
   * 
   * @param id 合同id
   * @param recoveryPrincipal 收回本金
   * @param recoveryInterest 收回利息
   * @param hangInteres 挂息金额
   * @param interestDate 起息日
   * @param req
   * @return
   */
  @RequestMapping(value = "/register", params = "updateInitRecoveryMoney", method = RequestMethod.POST)
  @ResponseBody
  public AjaxJson registerUpdateInitRecoveryMoney(@RequestParam(value = "id", required = true) Long id,
      @RequestParam(value = "recoveryPrincipal", required = true) Double recoveryPrincipal, @RequestParam(value = "recoveryInterest", required = true) Double recoveryInterest,
      @RequestParam(value = "hangInteres", required = true) Double hangInteres, @RequestParam(value = "interestDate") Date interestDate, HttpServletRequest req) {
    AjaxJson j = new AjaxJson();
    boolean sucess = false;
    try {
      sucess = loanContractService.updateInitRecoveryMoney(id, recoveryPrincipal, recoveryInterest, hangInteres, interestDate);
      j.setSuccess(sucess);
      j.setMsg("更新成功!");
      logger.info("update sucess:{ " + id + "," + recoveryPrincipal + "," + recoveryInterest + "," + hangInteres + "}");
    } catch (Exception e) {
      j.setSuccess(sucess);
      j.setMsg("更新异常, 请联系管理员!");
      logger.error("update error", e.getMessage());
    }
    return j;
  }

  /**
   * @Title:借款合同登记提交(可以回款操作 设置commit为1)
   * 
   * @param id 合同id
   * @param req
   * @return
   */
  @RequestMapping(value = "/register", params = "commit", method = RequestMethod.POST)
  @ResponseBody
  public AjaxJson registerCommit(@RequestParam(value = "id", required = true) Long id, HttpServletRequest req) {
    AjaxJson j = new AjaxJson();
    boolean sucess = false;
    try {
      sucess = loanContractService.commitMain(id);
      j.setSuccess(sucess);
      j.setMsg("更新成功!");
      logger.info("update sucess:" + id);
    } catch (Exception e) {
      j.setSuccess(sucess);
      j.setMsg("更新异常, 请联系管理员!");
      logger.error("update error", e.getMessage());
    }
    return j;
  }

  /**
   * @Title:借款合同登记提交(结束)
   * 
   * @param id 合同id
   * @param req
   * @return
   */
  @RequestMapping(value = "/register", params = "endCommit", method = RequestMethod.POST)
  @ResponseBody
  public AjaxJson registerEndCommit(@RequestParam(value = "id", required = true) Long id, HttpServletRequest req) {
    AjaxJson j = new AjaxJson();
    boolean sucess = false;
    try {
      sucess = loanContractService.commitEnd(id);
      j.setSuccess(sucess);
      j.setMsg("更新成功!");
      logger.info("update sucess:" + id);
    } catch (Exception e) {
      j.setSuccess(sucess);
      j.setMsg("更新异常, 请联系管理员!");
      logger.error("update error", e.getMessage());
    }
    return j;
  }

  /**
   * @Title:借款合同登记提交(终止)
   * 
   * @param id 合同id
   * @param req
   * @return
   */
  @RequestMapping(value = "/register", params = "termCommit", method = RequestMethod.POST)
  @ResponseBody
  public AjaxJson registerTermCommit(@RequestParam(value = "id", required = true) Long id, HttpServletRequest req) {
    AjaxJson j = new AjaxJson();
    boolean sucess = false;
    try {
      sucess = loanContractService.commitTern(id);
      j.setSuccess(sucess);
      j.setMsg("更新成功!");
      logger.info("update sucess:" + id);
    } catch (Exception e) {
      j.setSuccess(sucess);
      j.setMsg("更新异常, 请联系管理员!");
      logger.error("update error", e.getMessage());
    }
    return j;
  }

  /**
   * @Title:借款合同登记贷款人借冒名设置
   * 
   * @param id 合同id
   * @param isImpersonate 是否借冒名
   * @param req
   * @return
   */
  @RequestMapping(value = "/register", params = "updateImpersonate", method = RequestMethod.POST)
  @ResponseBody
  public AjaxJson registerUpdateImpersonate(@RequestParam(value = "id", required = true) Long id, @RequestParam(value = "isImpersonate", required = true) Boolean isImpersonate,
      HttpServletRequest req) {
    AjaxJson j = new AjaxJson();
    boolean sucess = false;
    try {
      sucess = loanContractService.updateImpersonate(id, isImpersonate);
      j.setSuccess(sucess);
      j.setMsg("更新成功!");
      logger.info("update sucess:" + id);
    } catch (Exception e) {
      j.setSuccess(sucess);
      j.setMsg("更新异常, 请联系管理员!");
      logger.error("update error", e.getMessage());
    }
    return j;
  }

  /**
   * @Title:检查合同编号的有效性
   * @param id 合同id
   * @param numCode 合同编号
   * @param req
   * @return
   */
  @RequestMapping(value = "/register", params = "checkNumCodeValid", method = RequestMethod.POST)
  @ResponseBody
  public AjaxJson registerCheckNumCodeValid(@RequestParam(value = "id", required = true) Long id, @RequestParam(value = "numCode", required = true) String numCode,
      HttpServletRequest req) {
    AjaxJson j = new AjaxJson();
    boolean sucess = false;
    try {
      sucess = loanContractService.checkNumCodeValid(id, numCode);
      j.setSuccess(sucess);
      j.setMsg("查询成功!");
      logger.info("query sucess:" + id);
    } catch (Exception e) {
      j.setSuccess(false);
      j.setMsg("查询异常, 请联系管理员!");
      logger.error("update error", e.getMessage());
    }
    return j;
  }

  /**
   * @Title:收回款列表
   * @param request
   * @return
   */
  @RequestMapping(value = "/recall", params = "list", method = RequestMethod.GET)
  public String recall(HttpServletRequest request) {
    return "npa/contract/recall_list";
  }

  /**
   * @Title:收回款datagrid数据
   * @param loanContractRegisterView
   * @param request
   * @param response
   * @param dataGrid
   */
  @RequestMapping(value = "/recall", params = "datagrid", method = RequestMethod.POST)
  @ResponseBody
  public void recallDatagrid(LoanContractRegisterView loanContractRegisterView, HttpServletRequest request, HttpServletResponse response, DataGrid dataGrid) {
    loanContractService.getLoanContractRecallList(loanContractRegisterView, dataGrid);
    TagUtil.datagrid(response, dataGrid);
  }

  /**
   * @Title:收回款详情页
   * @param id 合同id
   * @param index 选择的selectRowIndex
   * @return
   */
  @RequestMapping(value = "/recall", params = "toAdd", method = RequestMethod.GET)
  public ModelAndView recallToAdd(@RequestParam(value = "id", required = true) Long id, @RequestParam(value = "selectRowIndex", required = true) Long selectRowIndex) {
    ModelAndView mv = new ModelAndView();
    mv.addObject("view", loanContractService.getLoanContractRecallView(id));
    mv.addObject("selectRowIndex", selectRowIndex);
    mv.setViewName("npa/contract/recall_view");
    return mv;
  }

  /**
   * @Title:收回款详情页
   * @param id 合同id
   * @return
   */
  @RequestMapping(value = "/recall", params = "toDetail", method = RequestMethod.GET)
  public ModelAndView recallToDetail(@RequestParam(value = "id", required = true) Long id) {
    ModelAndView mv = new ModelAndView();
    mv.addObject("view", loanContractService.getLoanContractRecallView(id));
    mv.setViewName("npa/contract/recall_detail");
    return mv;
  }

  /**
   * @Title:综合查询列表
   * 
   * @param req
   * @return
   */
  @RequestMapping(value = "/query", params = "list", method = RequestMethod.GET)
  public ModelAndView queryList(HttpServletRequest req) {
    ModelAndView mv = new ModelAndView("npa/contract/query_list");
    return mv;
  }

  /**
   * @Title:综合查询datagrid数据
   * 
   * @param userName
   * @param viContractQy
   * @param request
   * @param response
   * @param dataGrid
   */
  @RequestMapping(value = "/query", params = "datagrid", method = RequestMethod.POST)
  @ResponseBody
  public void queryDatagrid(String userName, ViContractQyView viContractQyView, HttpServletRequest request, HttpServletResponse response, DataGrid dataGrid) {
    loanContractService.viQuery(userName, viContractQyView, dataGrid);
    TagUtil.datagrid(response, dataGrid);
  }

  /**
   * @Title:综合查询datagrid数据
   * @param list 找到的黑名单信息
   * @param nfParam 未找到的黑名单信息
   * @param request
   * @param response
   */
  @RequestMapping(value = "/query", params = "savePdf", method = RequestMethod.POST)
  public void querySavePdf(@RequestParam(value = "list") String list, @RequestParam(value = "nfParam") String nfParam, HttpServletRequest request, HttpServletResponse response) {
    InputStream bis = null;
    BufferedOutputStream bos = null;
    long fileLength = 0;
    try {
      String fileName = loanContractService.querySavePdf(list, nfParam);
      String filePath = ResourceUtil.getConfigByName("npa_query_pdf_docment_basePath") + fileName;
      fileLength = new File(filePath).length();
      response.setContentType("UTF-8");
      response.setCharacterEncoding("UTF-8");
      response.setContentType("application/pdf;");
      response.setHeader("Content-disposition", "attachment; filename=" + new String((fileName).getBytes("GBK"), "ISO8859-1"));
      response.setHeader("Content-Length", String.valueOf(fileLength));
      bis = new BufferedInputStream(new FileInputStream(filePath));
      bos = new BufferedOutputStream(response.getOutputStream());
      byte[] buff = new byte[2048];
      int bytesRead;
      while (-1 != (bytesRead = bis.read(buff, 0, buff.length))) {
        bos.write(buff, 0, bytesRead);
      }
    } catch (IOException e) {
      e.printStackTrace();
    } catch (Exception e) {
      // TODO Auto-generated catch block
      e.printStackTrace();
    } finally {
      try {
        if (bis != null)
          bis.close();

        if (bos != null)
          bos.close();
      } catch (IOException e) {
        e.printStackTrace();
      }
    }
  }

  /**
   * @title 临时删除
   * 
   * @param id
   * @param req
   */
  @RequestMapping(value = "/recall", params = "deleteTemp", method = RequestMethod.POST)
  @ResponseBody
  public AjaxJson deleteTemp(@RequestParam(value = "id", required = true) Long id, HttpServletRequest req) {
    AjaxJson j = new AjaxJson();
    boolean sucess = false;
    try {
      sucess = loanContractService.deleteTemp(id);
      j.setSuccess(sucess);
      j.setMsg("删除成功!");
      logger.info("deleteTemp sucess:" + id);
    } catch (Exception e) {
      j.setSuccess(sucess);
      j.setMsg("删除异常, 请联系管理员!");
      logger.error("deleteTemp error", e.getMessage());
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
