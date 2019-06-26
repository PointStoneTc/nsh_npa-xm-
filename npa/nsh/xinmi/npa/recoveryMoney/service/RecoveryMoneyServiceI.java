package nsh.xinmi.npa.recoveryMoney.service;

import java.util.List;

import org.jeecgframework.core.common.service.CommonService;

import nsh.xinmi.npa.recoveryMoney.entity.RecoveryMoney;

public interface RecoveryMoneyServiceI extends CommonService {
    /**
     * @Title: 根据合同id查询所有的回款记录
     * @param contractId
     * @return
     */
    List<RecoveryMoney> getListByContractId(Long contractId);

    /**
     * @Title: 保存回款记录
     * @param recoveryMoney
     * @return
     * @throws Exception
     */
    boolean saveMain(RecoveryMoney recoveryMoney) throws Exception;
}
