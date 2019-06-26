CREATE DEFINER=`npa`@`%` PROCEDURE `pro_sysinit_lt`(IN `dotId` tinyint,OUT `msg` varchar(30))
label: BEGIN
	DECLARE checkResult INT UNSIGNED DEFAULT 0;
	DECLARE dotName VARCHAR(20) DEFAULT '';
  #01)数据校验
  -- 01.01 不为空校验
	SELECT COUNT(1)
		FROM npa_loan_contract_imp
	 WHERE num_code IS NULL
			OR borrower_name IS NULL
			OR borrower_number IS NULL
			OR amount IS NULL
			OR issue_date IS NULL
			OR due_date IS NULL
			OR interest_rate IS NULL
			OR officer IS NULL
			OR corporate_org_name IS NULL
			OR dispose_mode IS NULL
			OR litigation_stat IS NULL
			OR stat IS NULL INTO checkResult;
  IF checkResult > 0 THEN
		SET msg = '有空值';
		LEAVE label;
	END IF;

  -- 01.02 档案号自身不能重名
	SELECT COUNT(1)
		FROM (SELECT num_code
						FROM npa_loan_contract_imp
					 GROUP BY num_code
					HAVING COUNT(1) > 1) t INTO checkResult;
  IF checkResult > 0 THEN
		SET msg = '档案号自身有重名';
		LEAVE label;
	END IF;

  -- 01.03 档案号自身不能与现有数据重名
	SELECT COUNT(1)
		FROM (SELECT c.num_code
						FROM npa_loan_contract_imp i
					 INNER JOIN npa_loan_contract c
							ON i.num_code = c.num_code) t INTO checkResult;
  IF checkResult > 0 THEN
		SET msg = '档案号与与现有数据重名';
		LEAVE label;
	END IF;

	-- 01.04 借据号自身不能重名
	SELECT COUNT(1)
		FROM (SELECT lou_no
						FROM npa_loan_contract_imp
					 GROUP BY lou_no
					HAVING COUNT(1) > 1) t INTO checkResult;
  IF checkResult > 0 THEN
		SET msg = '借据号自身有重名';
		LEAVE label;
	END IF;

	-- 01.05 贷款到期日不能小于贷款发放日
	SELECT COUNT(1)
		FROM npa_loan_contract_imp
	 WHERE issue_date >= due_date INTO checkResult;
  IF checkResult > 0 THEN
		SET msg = '贷款到期日有小于贷款发放日';
		LEAVE label;
	END IF;

	-- 01.06 导入支行名称正确
	SELECT name_shorter FROM npa_corporate_org WHERE id = dotId LIMIT 1 INTO dotName;
	IF dotName = '' THEN
		SET msg = '传入的支行id错误';
		LEAVE label;
	END IF;

	-- 01.07 起息日不能小于贷款到期日
	SELECT COUNT(1)
		FROM npa_loan_contract_imp
	 WHERE issue_date >= interest_date AND interest_date IS NOT NULL INTO checkResult;
  IF checkResult > 0 THEN
		SET msg = '起息日有小于贷款到期日';
		LEAVE label;
	END IF;
  
	-- 01.08起息日存在,收回本金、收回利息、挂息不能大于0
	SELECT COUNT(1)
		FROM npa_loan_contract_imp
	 WHERE interest_date IS NULL
		 AND (recovery_principal > 0 OR recovery_interest > 0 OR
				 hang_interes > 0) INTO checkResult;
  IF checkResult > 0 THEN
		SET msg = '起息日存在,收回本金、收回利息、挂息大于0';
		LEAVE label;
	END IF;

	-- 01.08起息日存在,收回本金不能大于贷款金额
	SELECT COUNT(1)		
		FROM npa_loan_contract_imp
	 WHERE interest_date IS NOT NULL AND recovery_principal > amount INTO checkResult;
  IF checkResult > 0 THEN
		SET msg = '收回本金有大于贷款金额';
		LEAVE label;
	END IF;

	-- 01.09判断是否有身份证相同,姓名不同的数据
	SELECT
		COUNT(1)
	FROM
		(
			SELECT
				id_number
			FROM
				(
					SELECT DISTINCT
						npi. NAME,
						npi.id_number
					FROM
						npa_natural_person_imp npi
					LEFT JOIN npa_natural_person p ON npi.id_number = p.id_number
					WHERE
						p.id_number IS NULL
				) t
			GROUP BY
				t.id_number
			HAVING
				COUNT(1) > 1
		) t INTO checkResult;
  
  IF checkResult > 0 THEN
		SET msg = '身份证相同,姓名不同';
		LEAVE label;
	END IF;

	#02)删除dotId下的所有历史数据
	DELETE m FROM npa_recovery_money m LEFT JOIN npa_loan_contract t ON m.loan_contrac_id = t.id
	 WHERE t.corporate_org_id = dotId;

	DELETE g FROM npa_loan_contract_guarantee g LEFT JOIN npa_loan_contract t ON g.loan_contrac_id = t.id
	 WHERE t.corporate_org_id = dotId;

	DELETE FROM npa_loan_contract WHERE corporate_org_id = dotId;

	#03)插入所有新增的借款人和担保人
	INSERT INTO npa_natural_person (NAME, id_number, create_by, create_date, is_delete) SELECT
		np.`name`,
		np.id_number,
		'admin',
		NOW(),
		'0'
	FROM
		npa_natural_person_imp np
	LEFT JOIN npa_natural_person npi ON np.id_number = npi.id_number
	WHERE
		npi.id_number IS NULL;

	#04)插入合同表
	INSERT INTO npa_loan_contract
		(num_code,
		 customer_no,
		 lou_no,
		 borrower_id,
		 borrower_name,
		 is_impersonate,
		 amount,
		 issue_date,
		 due_date,
		 interest_rate,
		 officer,
		 corporate_org_id,
		 corporate_org_name,
		 guarantee_mode,
		 dispose_mode,
		 litigation_stat,
		 is_submit,
		 interest_date,
		 recovery_principal,
		 recovery_interest,
		 hang_interes,
		 create_by,
		 create_date,
		 is_delete)
		SELECT c.num_code,
					 c.customer_no,
					 c.lou_no,
					 p.id,
					 c.borrower_name,
					 '0',
					 c.amount,
					 c.issue_date,
					 c.due_date,
					 c.interest_rate,
					 c.officer,
					 dotId,
					 dotName,
					 c.guarantee_mode,
					 c.dispose_mode,
					 c.litigation_stat,
					 '1',
					 c.interest_date,
					 c.recovery_principal,
					 c.recovery_interest,
					 c.hang_interes,
					 'admin',
					 NOW(),
					 '0'
			FROM npa_loan_contract_imp c
		 INNER JOIN npa_natural_person p
				ON c.borrower_number = p.id_number;

	#05)插入担保人表
	INSERT INTO npa_loan_contract_guarantee
  (loan_contrac_id, guarantee_id, guarantee_name, is_impersonate)
  SELECT c.id, p.id, p.name, 0
    FROM npa_natural_person_imp i
   INNER JOIN npa_natural_person p
      ON i.id_number = p.id_number
   INNER JOIN npa_loan_contract c
      ON i.num_code = c.num_code
   WHERE i.is_guarantee = '1';

  #06)更新自然人的是否借款人、是否担保人、生日及性别
	UPDATE npa_natural_person p JOIN (SELECT id_number
                                    FROM npa_natural_person_imp
                                   WHERE is_borrower = '1') t ON p.id_number = t.id_number
   set is_borrower = '1';

	UPDATE npa_natural_person p JOIN (SELECT id_number
                                    FROM npa_natural_person_imp
                                   WHERE is_guarantee = '1') t ON p.id_number = t.id_number
   set is_guarantee = '1';

	UPDATE npa_natural_person p JOIN (SELECT id_number
																			FROM npa_natural_person_imp) t ON p.id_number = t.id_number
		 set p.birthday = CASE
												WHEN LENGTH(p.id_number) = 18 THEN
												 SUBSTRING(p.id_number, 7, 8)
												WHEN LENGTH(p.id_number) = 15 THEN
												 CONCAT('19', SUBSTRING(p.id_number, 7, 6))
											END,
				 p.sex = CASE
									 WHEN LENGTH(p.id_number) = 18 THEN
										IF(MOD(SUBSTRING(p.id_number, 17, 1), 2), 'm', 'f')
									 WHEN LENGTH(p.id_number) = 15 THEN
										IF(MOD(SUBSTRING(p.id_number, 15, 1), 2), 'm', 'f')
								 END;

	SET msg = 'true';
END