package nsh.xinmi.npa.loanContract.service;

import java.util.Date;
import org.jeecgframework.core.common.service.CommonService;

public interface LoanContractExportServiceI extends CommonService {
  /**
   * @Title: 导出所有数据
   * 
   * @param fileSavePath
   */
  String all(String fileSavePath);

  /**
   * @Title: 导出收回款所有数据
   * 
   * @param startDate
   * @param endDate
   * @param fileSavePath
   */
  String recovery(Date startDate, Date endDate, String fileSavePath);
}
