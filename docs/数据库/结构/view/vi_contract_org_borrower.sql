SELECT
	`o`.`id` AS `id`,
	`o`.`name_shorter` AS `orgName`,
	ifnull(`c`.`ct`, 0) AS `ct`
FROM
	(
		`npa_corporate_org` `o`
		JOIN (
			SELECT
				count(DISTINCT `c`.`borrower_id`) AS `ct`,
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
	`c`.`ct`