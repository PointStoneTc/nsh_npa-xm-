package nsh.xinmi.npa.loanContract.service;

import java.util.Date;
import org.jeecgframework.core.common.model.json.DataGrid;
import org.jeecgframework.core.common.service.CommonService;
import nsh.xinmi.npa.loanContract.view.LoanContractRecallView;
import nsh.xinmi.npa.loanContract.view.LoanContractRegisterView;
import nsh.xinmi.npa.loanContract.view.LoanContractView;
import nsh.xinmi.npa.loanContract.view.ViContractQyView;

public interface LoanContractServiceI extends CommonService {
  /**
   * @Title:合同登記列表
   * 
   * @param loanContractListView
   * @param dataGrid
   */
  void getLoanContractRegisterList(LoanContractRegisterView loanContractRegisterView, DataGrid dataGrid);

  /**
   * @Title:收回款列表
   * 
   * @param loanContractRegisterView
   * @param dataGrid
   */
  void getLoanContractRecallList(LoanContractRegisterView loanContractRegisterView, DataGrid dataGrid);

  /**
   * @Title:收回款详情页
   * 
   * @param id 合同id
   * @return
   */
  LoanContractRecallView getLoanContractRecallView(Long id);

  /**
   * @Title:保存借款合同
   * 
   * @param loanContractView
   * @return
   * @throws Exception
   */
  boolean saveMain(LoanContractView loanContractView) throws Exception;

  /**
   * @Title:更新借款合同
   * 
   * @param loanContractView
   * @return
   * @throws Exception
   */
  boolean updateMain(LoanContractView loanContractView) throws Exception;

  /**
   * @Title:删除借款合同
   * 
   * @param id 合同id
   * @return
   * @throws Exception
   */
  boolean deleteMain(Long id) throws Exception;

  /**
   * @Title: 更新收回款信息
   * 
   * @param id 合同id
   * @param recoveryPrincipal 收回本金
   * @param recoveryInterest 收回利息
   * @param hangInteres 挂息
   * @param interestDate 起息日
   * @return
   * @throws Exception
   */
  boolean updateInitRecoveryMoney(Long id, double recoveryPrincipal, double recoveryInterest, double hangInteres, Date interestDate) throws Exception;

  /**
   * @Title: 借款合同登记提交
   * 
   * @param id
   * @return
   */
  boolean commitMain(Long id);

  /**
   * @Title: 借款合同登记提交(结束)
   * 
   * @param id
   * @return
   */
  boolean commitEnd(Long id);

  /**
   * @Title: 借款合同登记提交(终止)
   * 
   * @param id
   * @return
   */
  boolean commitTern(Long id);

  /**
   * @Title: 借款合同更新借冒名
   * 
   * @param id 合同id
   * @param sImpersonate 是否借冒名
   * @return
   */
  boolean updateImpersonate(Long id, boolean isImpersonate);

  /**
   * @Title: 检查合同编号的有效性
   * @param id
   * @param numCode
   * @return
   */
  boolean checkNumCodeValid(Long id, String numCode);

  /**
   * @Title: 综合查询
   * @param userName
   * @param viContractQyView
   * @param dataGrid
   */
  void viQuery(String userName, ViContractQyView viContractQyView, DataGrid dataGrid);

  /**
   * @Title: 下载打印的临时文件
   * @param list
   * @param nfParam
   * @return
   * @throws Exception
   */
  String querySavePdf(String list, String nfParam) throws Exception;


  /**
   * @Title: 临时删除
   * 
   * @param id
   * @return
   * @throws Exception
   */
  boolean deleteTemp(Long id) throws Exception;
}
