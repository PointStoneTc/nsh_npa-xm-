SELECT
	`c`.`id` AS `id`,
	`c`.`num_code` AS `num_code`,
	`c`.`customer_no` AS `customer_no`,
	`c`.`lou_no` AS `lou_no`,
	`p`.`name` AS `borrower_name`,
	`p`.`id_number` AS `id_number`,
	`c`.`amount` AS `amount`,
	(
		`c`.`amount` - `c`.`recovery_principal`
	) AS `amount_surplus`,
	`c`.`interest_rate` AS `o_interest_rate`,
	`c`.`issue_date` AS `issue_date`,
	`c`.`due_date` AS `due_date`,
	`r`.`interest_date` AS `interest_date`,
	`r`.`interest_rate` AS `adjust_interest_rate`,
	`c`.`officer` AS `officer`,
	`c`.`corporate_org_name` AS `corporate_org_name`,
	`c`.`hang_interes` AS `hang_interes`,
	`c`.`guarantee_mode` AS `guarantee_mode`,
	`c`.`dispose_mode` AS `dispose_mode`,
	`c`.`litigation_stat` AS `litigation_stat`,
	`c`.`stat` AS `stat`
FROM
	(
		(
			`npa_loan_contract` `c`
			LEFT JOIN `vi_contract_recalllast` `r` ON (
				(
					`c`.`id` = `r`.`loan_contrac_id`
				)
			)
		)
		JOIN `npa_natural_person` `p` ON (
			(`c`.`borrower_id` = `p`.`id`)
		)
	)
WHERE
	(
		(`c`.`is_delete` = 0)
		AND (`c`.`is_submit` = 1)
	)