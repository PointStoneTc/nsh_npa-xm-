package nsh.xinmi.npa.loanContract.controller;

import java.io.BufferedInputStream;
import java.io.BufferedOutputStream;
import java.io.File;
import java.io.FileInputStream;
import java.io.IOException;
import java.io.InputStream;
import java.util.Date;
import javax.servlet.http.HttpServletRequest;
import javax.servlet.http.HttpServletResponse;
import org.jeecgframework.core.common.controller.BaseController;
import org.jeecgframework.core.util.ResourceUtil;
import org.jeecgframework.web.system.pojo.base.TSUser;
import org.slf4j.Logger;
import org.slf4j.LoggerFactory;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestMethod;
import org.springframework.web.bind.annotation.RequestParam;
import nsh.xinmi.npa.loanContract.service.LoanContractExportServiceI;

/**
 * @Title: Controller
 * @Description: 借款合同导出
 * @author 赵琦
 * @date 2020-05-02 10:58:00
 * @version V1.0
 *
 */
@Controller
@RequestMapping("/loancontract/export")
public class LoanContractExportController extends BaseController {
  private static final Logger log = LoggerFactory.getLogger(LoanContractExportController.class);
  private static final String EXPORT_PATH = "d:\\all_export_";

  /*--------------------------------------------
  |                            Variable                       |
  ============================================*/
  private String message;

  /*--------------------------------------------
  |                            Injection                      |
  ============================================*/
  @Autowired
  private LoanContractExportServiceI loanContractExportService;

  /*--------------------------------------------
  |             method                       |
  ============================================*/
  /**
   * @Title: 导出所有数据
   * 
   * @param request
   * @param response
   */
  @RequestMapping(params = "all", method = RequestMethod.POST)
  public void all(HttpServletRequest request, HttpServletResponse response) {
    InputStream bis = null;
    BufferedOutputStream bos = null;
    long fileLength = 0;
    try {
      TSUser loginUser = ResourceUtil.getSessionUser();
      log.info(">>>>>>>>>>(全量)开始导出excel,操作人:" + loginUser.getUserName());
      String fileName = loanContractExportService.all(EXPORT_PATH);
      if (fileName == null) {
        log.info(">>>>>>>>>>没有可以导出的数据,或者发生了错误!");
        return;
      }

      String filePath = EXPORT_PATH + fileName;
      fileLength = new File(filePath).length();
      response.setContentType("UTF-8");
      response.setCharacterEncoding("UTF-8");
      response.setContentType("application/vnd.openxmlformats-officedocument.spreadsheetml.sheet");
      response.setHeader("Content-disposition", "attachment; filename=" + new String((fileName).getBytes("GBK"), "ISO8859-1"));
      response.setHeader("Content-Length", String.valueOf(fileLength));
      bis = new BufferedInputStream(new FileInputStream(filePath));
      bos = new BufferedOutputStream(response.getOutputStream());
      byte[] buff = new byte[2048];
      int bytesRead;
      while (-1 != (bytesRead = bis.read(buff, 0, buff.length))) {
        bos.write(buff, 0, bytesRead);
      }
      log.info(">>>>>>>>>>导出成功:" + fileName);
    } catch (IOException e) {
      e.printStackTrace();
    } catch (Exception e) {
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
   * @Title: 导出收回款所有数据
   * 
   * @param startDate
   * @param endDate
   * @param request
   * @param response
   */
  @RequestMapping(params = "recovery", method = RequestMethod.POST)
  public void recovery(@RequestParam("start") Date startDate, @RequestParam(value = "end", required = false) Date endDate, HttpServletRequest request,
      HttpServletResponse response) {
    InputStream bis = null;
    BufferedOutputStream bos = null;
    long fileLength = 0;
    try {
      TSUser loginUser = ResourceUtil.getSessionUser();
      log.info(">>>>>>>>>>(收回款)开始导出excel,操作人:" + loginUser.getUserName());
      String fileName = loanContractExportService.recovery(startDate, endDate, EXPORT_PATH);
      if (fileName == null) {
        log.info(">>>>>>>>>>没有可以导出的数据,或者发生了错误!");
        return;
      }

      String filePath = EXPORT_PATH + fileName;
      fileLength = new File(filePath).length();
      response.setContentType("UTF-8");
      response.setCharacterEncoding("UTF-8");
      response.setContentType("application/vnd.openxmlformats-officedocument.spreadsheetml.sheet");
      response.setHeader("Content-disposition", "attachment; filename=" + new String((fileName).getBytes("GBK"), "ISO8859-1"));
      response.setHeader("Content-Length", String.valueOf(fileLength));
      bis = new BufferedInputStream(new FileInputStream(filePath));
      bos = new BufferedOutputStream(response.getOutputStream());
      byte[] buff = new byte[2048];
      int bytesRead;
      while (-1 != (bytesRead = bis.read(buff, 0, buff.length))) {
        bos.write(buff, 0, bytesRead);
      }
      log.info(">>>>>>>>>>导出成功:" + fileName);
    } catch (IOException e) {
      e.printStackTrace();
    } catch (Exception e) {
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


  public String getMessage() {
    return message;
  }

  public void setMessage(String message) {
    this.message = message;
  }

}
