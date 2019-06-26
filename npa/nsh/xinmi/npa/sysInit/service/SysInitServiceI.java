package nsh.xinmi.npa.sysInit.service;

import java.util.Map;

import org.jeecgframework.core.common.model.json.DataGrid;
import org.jeecgframework.core.common.service.CommonService;
import org.springframework.web.multipart.MultipartFile;

public interface SysInitServiceI extends CommonService {
    /**
     * @Title: 清空所有数据
     * @return
     * @throws Exception
     */
    boolean deleteAllData() throws Exception;

    /**
     * @Title: 初始化导入合同列表
     * @param dataGrid
     */
    void initltDatagrid(DataGrid dataGrid);

    /**
     * @Title: 初始化导入合同借款人列表
     * @param dataGrid
     */
    void initBorrowerDatagrid(DataGrid dataGrid);

    /**
     * @Title: 初始化导入合同担保人列表
     * @param dataGrid
     */
    void initGuaranteeDatagrid(DataGrid dataGrid);

    /**
     * @Title: 身份证相同,姓名不同的人员列表
     * @param dataGrid
     */
    void initIdNumberFixDatagrid(DataGrid dataGrid);

    /**
     * @Title: 导入合同明细
     * @param fileMap
     * @return
     * @throws Exception
     */
    int ltImportExcel(Map<String, MultipartFile> fileMap) throws Exception;

    /**
     * @Title: 生成临时数据
     * @return
     * @throws Exception
     */
    boolean createResult() throws Exception;
}
