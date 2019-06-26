SELECT
	`ci`.`id` AS `id`,
	`ci`.`num_code` AS `num_code`,
	`ci`.`customer_no` AS `customer_no`,
	`ci`.`lou_no` AS `lou_no`,
	`ci`.`borrower_name` AS `borrower_name`,
	`ci`.`borrower_number` AS `borrower_number`,
	`ci`.`is_impersonate` AS `is_impersonate`,
	`ci`.`guarantees` AS `guarantees`,
	`ci`.`amount` AS `amount`,
	`ci`.`issue_date` AS `issue_date`,
	`ci`.`due_date` AS `due_date`,
	`ci`.`interest_rate` AS `interest_rate`,
	`ci`.`officer` AS `officer`,
	`ci`.`corporate_org_name` AS `corporate_org_name`,
	`ci`.`guarantee_mode` AS `guarantee_mode`,
	`ci`.`dispose_mode` AS `dispose_mode`,
	`ci`.`litigation_stat` AS `litigation_stat`,
	`ci`.`stat` AS `stat`,
	`ci`.`interest_date` AS `interest_date`,
	`ci`.`recovery_principal` AS `recovery_principal`,
	`ci`.`recovery_interest` AS `recovery_interest`,
	`ci`.`hang_interes` AS `hang_interes`,
	(
		SELECT
			`t`.`ct`
		FROM
			(
				SELECT
					`npa_loan_contract_imp`.`num_code` AS `num_code`,
					count(1) AS `ct`
				FROM
					`npa_loan_contract_imp`
				WHERE
					(
						`npa_loan_contract_imp`.`num_code` <> ''
					)
				GROUP BY
					`npa_loan_contract_imp`.`num_code`
			) `t`
		WHERE
			(
				`ci`.`num_code` = `t`.`num_code`
			)
	) AS `num_code_count_self`,
	(
		SELECT
			`t`.`ct`
		FROM
			(
				SELECT
					`npa_loan_contract_imp`.`lou_no` AS `lou_no`,
					count(1) AS `ct`
				FROM
					`npa_loan_contract_imp`
				WHERE
					(
						`npa_loan_contract_imp`.`lou_no` <> ''
					)
				GROUP BY
					`npa_loan_contract_imp`.`lou_no`
			) `t`
		WHERE
			(`ci`.`lou_no` = `t`.`lou_no`)
	) AS `lou_no_count_self`,
	`c`.`num_code` AS `real_num_code`
FROM
	(
		`npa_loan_contract_imp` `ci`
		LEFT JOIN `npa_loan_contract` `c` ON (
			(
				`ci`.`num_code` = `c`.`num_code`
			)
		)
	)