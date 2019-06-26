WITH `ranked_recall` AS (
	SELECT
		`m`.`id` AS `id`,
		`m`.`loan_contrac_id` AS `loan_contrac_id`,
		`m`.`interest_bearing_principal` AS `interest_bearing_principal`,
		`m`.`interest_date` AS `interest_date`,
		`m`.`interest_rate` AS `interest_rate`,
		`m`.`recovery_date` AS `recovery_date`,
		`m`.`recovery_person` AS `recovery_person`,
		`m`.`recovery_principal` AS `recovery_principal`,
		`m`.`recovery_interest` AS `recovery_interest`,
		`m`.`hang_interest` AS `hang_interest`,
		`m`.`is_effect` AS `is_effect`,
		`m`.`create_by` AS `create_by`,
		`m`.`create_date` AS `create_date`,
		`m`.`update_by` AS `update_by`,
		`m`.`update_date` AS `update_date`,
		`m`.`is_delete` AS `is_delete`,
		`m`.`delete_date` AS `delete_date`,
		row_number () OVER (
			PARTITION BY `m`.`loan_contrac_id`
			ORDER BY
				`m`.`id` DESC
		) AS `rn`
	FROM
		`npa_recovery_money` `m`
	WHERE
		(`m`.`is_effect` = '1')
) SELECT
	`s`.`id` AS `id`,
	`s`.`loan_contrac_id` AS `loan_contrac_id`,
	`s`.`interest_bearing_principal` AS `interest_bearing_principal`,
	`s`.`interest_date` AS `interest_date`,
	`s`.`interest_rate` AS `interest_rate`,
	`s`.`recovery_date` AS `recovery_date`,
	`s`.`recovery_person` AS `recovery_person`,
	`s`.`recovery_principal` AS `recovery_principal`,
	`s`.`recovery_interest` AS `recovery_interest`,
	`s`.`hang_interest` AS `hang_interest`,
	`s`.`is_effect` AS `is_effect`,
	`s`.`create_by` AS `create_by`,
	`s`.`create_date` AS `create_date`,
	`s`.`update_by` AS `update_by`,
	`s`.`update_date` AS `update_date`,
	`s`.`is_delete` AS `is_delete`,
	`s`.`delete_date` AS `delete_date`,
	`s`.`rn` AS `rn`
FROM
	`ranked_recall` `s`
WHERE
	(`s`.`rn` = 1)