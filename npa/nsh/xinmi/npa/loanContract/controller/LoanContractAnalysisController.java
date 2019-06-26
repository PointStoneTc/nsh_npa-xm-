package nsh.xinmi.npa.loanContract.controller;

import java.util.List;

import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;

import org.jeecgframework.core.common.controller.BaseController;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.ResponseBody;

import nsh.xinmi.npa.loanContract.service.LoanContractAnalysisServiceI;
import nsh.xinmi.npa.loanContract.view.LoanContractAnalsisErrorView;
import nsh.xinmi.npa.loanContract.view.LoanContractAnalsisOrgAmountView;
import nsh.xinmi.npa.loanContract.view.LoanContractAnalsisOrgBorrower;

/**
 * @Title: Controller
 * @Description: 借款合同分析
 * @author 赵琦
 * @date 2019-02-19 10:00:00
 * @version V1.0
 *
 */
@Controller
@RequestMapping("/loancontractAnalysis")
public class LoanContractAnalysisController extends BaseController {
    private static final Logger logger = LoggerFactory.getLogger(LoanContractAnalysisController.class);

    /*--------------------------------------------
    |             Variable                       |
    ============================================*/
    private String message;

    /*--------------------------------------------
    |             Injection                      |
    ============================================*/
    @Autowired
    private LoanContractAnalysisServiceI loanContractAnalysisService;

    /*--------------------------------------------
    |             method                       |
    ============================================*/
    /**
     * @Title:借款合同按支行，贷款金额分析(跳转)
     * @param request
     * @param response
     * @return
     */
    @RequestMapping(params = "toOrgAmount", method = RequestMethod.GET)
    public String toOrgAmountData(HttpServletRequest request, HttpServletResponse response) {
        return "npa/analysis/org_amount";
    }

    /**
     * @Title:借款合同按支行，贷款金额分析(数据)
     * @param request
     * @param response
     * @return
     */
    @RequestMapping(params = "orgAmountData", method = RequestMethod.GET)
    @ResponseBody
    public List<LoanContractAnalsisOrgAmountView> orgAmountData(HttpServletRequest request, HttpServletResponse response) {
        List<LoanContractAnalsisOrgAmountView> list = loanContractAnalysisService.getLoanContractlOrgAmount();
        return list;
    }

    /**
     * @Title:借款合同按支行，贷款人分析(跳转)
     * @param request
     * @param response
     * @return
     */
    @RequestMapping(params = "toOrgBorrower", method = RequestMethod.GET)
    public String toOrgBorrower(HttpServletRequest request, HttpServletResponse response) {
        return "npa/analysis/org_borrower";
    }

    /**
     * @Title:借款合同按支行，贷款人分析(数据)
     * @param request
     * @param response
     * @return
     */
    @RequestMapping(params = "orgBorrowerData", method = RequestMethod.GET)
    @ResponseBody
    public List<LoanContractAnalsisOrgBorrower> orgBorrowerData(HttpServletRequest request, HttpServletResponse response) {
        List<LoanContractAnalsisOrgBorrower> list = loanContractAnalysisService.getLoanContractlOrgBorrower();
        return list;
    }

    /**
     * @Title:错误数据借款合同按支行，修改、未修改数量分析(数据)
     * @param request
     * @param response
     * @return
     */
    @RequestMapping(params = "orgErrorData", method = RequestMethod.GET)
    @ResponseBody
    public List<LoanContractAnalsisErrorView> orgErrorData(HttpServletRequest request, HttpServletResponse response) {
        List<LoanContractAnalsisErrorView> list = loanContractAnalysisService.getLoanContractlOrgError();
        return list;
    }

    public String getMessage() {
        return message;
    }

    public void setMessage(String message) {
        this.message = message;
    }

}
