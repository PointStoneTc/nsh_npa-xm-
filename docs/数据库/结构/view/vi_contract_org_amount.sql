SELECT
	`o`.`id` AS `orgId`,
	`o`.`name_shorter` AS `orgName`,
	round(ifnull(`c`.`v1`, 0), 0) AS `v1`,
	round(ifnull(`c`.`v2`, 0), 0) AS `v2`
FROM
	(
		`npa_corporate_org` `o`
		LEFT JOIN (
			SELECT
				sum(`c`.`recovery_principal`) AS `v1`,
				sum(
					(
						`c`.`amount` - `c`.`recovery_principal`
					)
				) AS `v2`,
				`c`.`corporate_org_id` AS `id`
			FROM
				`npa_loan_contract` `c`
			WHERE
				(
					(`c`.`is_submit` = '1')
					AND (`c`.`is_delete` = '0')
				)
			GROUP BY
				`c`.`corporate_org_id`
		) `c` ON ((`o`.`id` = `c`.`id`))
	)
ORDER BY
	`c`.`v1`