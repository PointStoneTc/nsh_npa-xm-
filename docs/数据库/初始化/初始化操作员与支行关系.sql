-- 清空所有数据
TRUNCATE TABLE npa_corporate_org_user;

-- 01)河南新密农村商业银行股份有限公司
INSERT INTO npa_corporate_org_user (corporate_org_id, userid)
SELECT (
		SELECT id
		FROM npa_corporate_org o
		WHERE o.NAME = '河南新密农村商业银行股份有限公司'
	) AS orgid, u.id AS uid
FROM t_s_base_user u
WHERE u.username IN (
	'00520032', 
	'00520130', 
	'00510038', 
	'00520165', 
	'00510131', 
	'00510050', 
	'00510195', 
	'00520161', 
	'00510068', 
	'00510187'
)
UNION
SELECT (
		SELECT id
		FROM npa_corporate_org o
		WHERE o.NAME = '河南新密农村商业银行股份有限公司白寨支行'
	) AS orgid, u.id AS uid
FROM t_s_base_user u
WHERE u.username IN (
	'00520032', 
	'00520130', 
	'00510038', 
	'00520165', 
	'00510131', 
	'00510050', 
	'00510195', 
	'00520161', 
	'00510068', 
	'00510187'
)
UNION
SELECT (
		SELECT id
		FROM npa_corporate_org o
		WHERE o.NAME = '河南新密农村商业银行股份有限公司超化支行'
	) AS orgid, u.id AS uid
FROM t_s_base_user u
WHERE u.username IN (
	'00520032', 
	'00520130', 
	'00510038', 
	'00520165', 
	'00510131', 
	'00510050', 
	'00510195', 
	'00520161', 
	'00510068', 
	'00510187'
)
UNION
SELECT (
		SELECT id
		FROM npa_corporate_org o
		WHERE o.NAME = '河南新密农村商业银行股份有限公司城关支行'
	) AS orgid, u.id AS uid
FROM t_s_base_user u
WHERE u.username IN (
	'00520032', 
	'00520130', 
	'00510038', 
	'00520165', 
	'00510131', 
	'00510050', 
	'00510195', 
	'00520161', 
	'00510068', 
	'00510187'
)
UNION
SELECT (
		SELECT id
		FROM npa_corporate_org o
		WHERE o.NAME = '河南新密农村商业银行股份有限公司大隗支行'
	) AS orgid, u.id AS uid
FROM t_s_base_user u
WHERE u.username IN (
	'00520032', 
	'00520130', 
	'00510038', 
	'00520165', 
	'00510131', 
	'00510050', 
	'00510195', 
	'00520161', 
	'00510068', 
	'00510187'
)
UNION
SELECT (
		SELECT id
		FROM npa_corporate_org o
		WHERE o.NAME = '河南新密农村商业银行股份有限公司苟堂支行'
	) AS orgid, u.id AS uid
FROM t_s_base_user u
WHERE u.username IN (
	'00520032', 
	'00520130', 
	'00510038', 
	'00520165', 
	'00510131', 
	'00510050', 
	'00510195', 
	'00520161', 
	'00510068', 
	'00510187'
)
UNION
SELECT (
		SELECT id
		FROM npa_corporate_org o
		WHERE o.NAME = '河南新密农村商业银行股份有限公司矿区支行'
	) AS orgid, u.id AS uid
FROM t_s_base_user u
WHERE u.username IN (
	'00520032', 
	'00520130', 
	'00510038', 
	'00520165', 
	'00510131', 
	'00510050', 
	'00510195', 
	'00520161', 
	'00510068', 
	'00510187'
)
UNION
SELECT (
		SELECT id
		FROM npa_corporate_org o
		WHERE o.NAME = '河南新密农村商业银行股份有限公司来集支行'
	) AS orgid, u.id AS uid
FROM t_s_base_user u
WHERE u.username IN (
	'00520032', 
	'00520130', 
	'00510038', 
	'00520165', 
	'00510131', 
	'00510050', 
	'00510195', 
	'00520161', 
	'00510068', 
	'00510187'
)
UNION
SELECT (
		SELECT id
		FROM npa_corporate_org o
		WHERE o.NAME = '河南新密农村商业银行股份有限公司刘寨支行'
	) AS orgid, u.id AS uid
FROM t_s_base_user u
WHERE u.username IN (
	'00520032', 
	'00520130', 
	'00510038', 
	'00520165', 
	'00510131', 
	'00510050', 
	'00510195', 
	'00520161', 
	'00510068', 
	'00510187'
)
UNION
SELECT (
		SELECT id
		FROM npa_corporate_org o
		WHERE o.NAME = '河南新密农村商业银行股份有限公司米村支行'
	) AS orgid, u.id AS uid
FROM t_s_base_user u
WHERE u.username IN (
	'00520032', 
	'00520130', 
	'00510038', 
	'00520165', 
	'00510131', 
	'00510050', 
	'00510195', 
	'00520161', 
	'00510068', 
	'00510187'
)
UNION
SELECT (
		SELECT id
		FROM npa_corporate_org o
		WHERE o.NAME = '河南新密农村商业银行股份有限公司牛店支行'
	) AS orgid, u.id AS uid
FROM t_s_base_user u
WHERE u.username IN (
	'00520032', 
	'00520130', 
	'00510038', 
	'00520165', 
	'00510131', 
	'00510050', 
	'00510195', 
	'00520161', 
	'00510068', 
	'00510187'
)
UNION
SELECT (
		SELECT id
		FROM npa_corporate_org o
		WHERE o.NAME = '河南新密农村商业银行股份有限公司平陌支行'
	) AS orgid, u.id AS uid
FROM t_s_base_user u
WHERE u.username IN (
	'00520032', 
	'00520130', 
	'00510038', 
	'00520165', 
	'00510131', 
	'00510050', 
	'00510195', 
	'00520161', 
	'00510068', 
	'00510187'
)
UNION
SELECT (
		SELECT id
		FROM npa_corporate_org o
		WHERE o.NAME = '河南新密农村商业银行股份有限公司青屏支行'
	) AS orgid, u.id AS uid
FROM t_s_base_user u
WHERE u.username IN (
	'00520032', 
	'00520130', 
	'00510038', 
	'00520165', 
	'00510131', 
	'00510050', 
	'00510195', 
	'00520161', 
	'00510068', 
	'00510187'
)
UNION
SELECT (
		SELECT id
		FROM npa_corporate_org o
		WHERE o.NAME = '河南新密农村商业银行股份有限公司曲梁支行'
	) AS orgid, u.id AS uid
FROM t_s_base_user u
WHERE u.username IN (
	'00520032', 
	'00520130', 
	'00510038', 
	'00520165', 
	'00510131', 
	'00510050', 
	'00510195', 
	'00520161', 
	'00510068', 
	'00510187'
)
UNION
SELECT (
		SELECT id
		FROM npa_corporate_org o
		WHERE o.NAME = '河南新密农村商业银行股份有限公司营业部'
	) AS orgid, u.id AS uid
FROM t_s_base_user u
WHERE u.username IN (
	'00520032', 
	'00520130', 
	'00510038', 
	'00520165', 
	'00510131', 
	'00510050', 
	'00510195', 
	'00520161', 
	'00510068', 
	'00510187'
)
UNION
SELECT (
		SELECT id
		FROM npa_corporate_org o
		WHERE o.NAME = '河南新密农村商业银行股份有限公司袁庄支行'
	) AS orgid, u.id AS uid
FROM t_s_base_user u
WHERE u.username IN (
	'00520032', 
	'00520130', 
	'00510038', 
	'00520165', 
	'00510131', 
	'00510050', 
	'00510195', 
	'00520161', 
	'00510068', 
	'00510187'
)
UNION
SELECT (
		SELECT id
		FROM npa_corporate_org o
		WHERE o.NAME = '河南新密农村商业银行股份有限公司岳村支行'
	) AS orgid, u.id AS uid
FROM t_s_base_user u
WHERE u.username IN (
	'00520032', 
	'00520130', 
	'00510038', 
	'00520165', 
	'00510131', 
	'00510050', 
	'00510195', 
	'00520161', 
	'00510068', 
	'00510187'
);

-- 02)河南新密农村商业银行股份有限公司白寨支行
INSERT npa_corporate_org_user (corporate_org_id, userid) SELECT
	(
		SELECT
			id
		FROM
			npa_corporate_org o
		WHERE
			o. NAME = '河南新密农村商业银行股份有限公司白寨支行'
	) orgid,
	u.id uid
FROM
	t_s_base_user u
WHERE
	u.username IN (
		'00510125',
		'00510032',
		'00520112',
		'00510186',
		'00510222',
		'00520150',
		'00510242'
	);

-- 03)河南新密农村商业银行股份有限公司超化支行
INSERT npa_corporate_org_user (corporate_org_id, userid) SELECT
	(
		SELECT
			id
		FROM
			npa_corporate_org o
		WHERE
			o. NAME = '河南新密农村商业银行股份有限公司超化支行'
	) orgid,
	u.id uid
FROM
	t_s_base_user u
WHERE
	u.username IN (
		'00510016',
		'00510076',
		'00520093',
		'00520273'
	);

-- 04)河南新密农村商业银行股份有限公司城关支行
INSERT npa_corporate_org_user (corporate_org_id, userid) SELECT
	(
		SELECT
			id
		FROM
			npa_corporate_org o
		WHERE
			o. NAME = '河南新密农村商业银行股份有限公司城关支行'
	) orgid,
	u.id uid
FROM
	t_s_base_user u
WHERE
	u.username IN (
		'00510054',
		'00520194',
		'00510056',
		'00520061',
		'00510082',
		'00510012'
	);

-- 05)河南新密农村商业银行股份有限公司大隗支行
INSERT npa_corporate_org_user (corporate_org_id, userid) SELECT
	(
		SELECT
			id
		FROM
			npa_corporate_org o
		WHERE
			o. NAME = '河南新密农村商业银行股份有限公司大隗支行'
	) orgid,
	u.id uid
FROM
	t_s_base_user u
WHERE
	u.username IN (
		'00510039',
		'00510164',
		'00510173',
		'00520187',
		'00510133',
		'00510089'
	);

-- 06)河南新密农村商业银行股份有限公司苟堂支行
INSERT npa_corporate_org_user (corporate_org_id, userid) SELECT
	(
		SELECT
			id
		FROM
			npa_corporate_org o
		WHERE
			o. NAME = '河南新密农村商业银行股份有限公司苟堂支行'
	) orgid,
	u.id uid
FROM
	t_s_base_user u
WHERE
	u.username IN (
		'00510174',
		'00510030',
		'00510110',
		'00510258'
	);

-- 07)河南新密农村商业银行股份有限公司矿区支行
INSERT npa_corporate_org_user (corporate_org_id, userid) SELECT
	(
		SELECT
			id
		FROM
			npa_corporate_org o
		WHERE
			o. NAME = '河南新密农村商业银行股份有限公司矿区支行'
	) orgid,
	u.id uid
FROM
	t_s_base_user u
WHERE
	u.username IN (
		'00510151',
		'00510109',
		'00520136',
		'00520104',
		'25210053'
	);

-- 08)河南新密农村商业银行股份有限公司来集支行
INSERT npa_corporate_org_user (corporate_org_id, userid) SELECT
	(
		SELECT
			id
		FROM
			npa_corporate_org o
		WHERE
			o. NAME = '河南新密农村商业银行股份有限公司来集支行'
	) orgid,
	u.id uid
FROM
	t_s_base_user u
WHERE
	u.username IN (
		'00510175',
		'00510197',
		'00510130'
	);

-- 09)河南新密农村商业银行股份有限公司刘寨支行
INSERT npa_corporate_org_user (corporate_org_id, userid) SELECT
	(
		SELECT
			id
		FROM
			npa_corporate_org o
		WHERE
			o. NAME = '河南新密农村商业银行股份有限公司刘寨支行'
	) orgid,
	u.id uid
FROM
	t_s_base_user u
WHERE
	u.username IN (
		'00510169',
		'00510035',
		'00520179',
		'00510027',
		'00510029',
		'00520114'
	);

-- 10)河南新密农村商业银行股份有限公司米村支行
INSERT npa_corporate_org_user (corporate_org_id, userid) SELECT
	(
		SELECT
			id
		FROM
			npa_corporate_org o
		WHERE
			o. NAME = '河南新密农村商业银行股份有限公司米村支行'
	) orgid,
	u.id uid
FROM
	t_s_base_user u
WHERE
	u.username IN (
		'00510091',
		'00520076',
		'00520188',
		'00520131',
		'00510119',
		'00520075',
		'00510112'
	);

-- 11)河南新密农村商业银行股份有限公司牛店支行
INSERT npa_corporate_org_user (corporate_org_id, userid) SELECT
	(
		SELECT
			id
		FROM
			npa_corporate_org o
		WHERE
			o. NAME = '河南新密农村商业银行股份有限公司牛店支行'
	) orgid,
	u.id uid
FROM
	t_s_base_user u
WHERE
	u.username IN (
		'00510086',
		'00510085',
		'00520299',
		'00520302'
	);

-- 12)河南新密农村商业银行股份有限公司平陌支行
INSERT npa_corporate_org_user (corporate_org_id, userid) SELECT
	(
		SELECT
			id
		FROM
			npa_corporate_org o
		WHERE
			o. NAME = '河南新密农村商业银行股份有限公司平陌支行'
	) orgid,
	u.id uid
FROM
	t_s_base_user u
WHERE
	u.username IN ('00520108', '00510247');

-- 13)河南新密农村商业银行股份有限公司青屏支行
INSERT npa_corporate_org_user (corporate_org_id, userid) SELECT
	(
		SELECT
			id
		FROM
			npa_corporate_org o
		WHERE
			o. NAME = '河南新密农村商业银行股份有限公司青屏支行'
	) orgid,
	u.id uid
FROM
	t_s_base_user u
WHERE
	u.username IN (
		'00510067',
		'00510049',
		'00520255',
		'00520190',
		'00520066',
		'00510245'
	);

-- 14)河南新密农村商业银行股份有限公司曲梁支行
INSERT npa_corporate_org_user (corporate_org_id, userid) SELECT
	(
		SELECT
			id
		FROM
			npa_corporate_org o
		WHERE
			o. NAME = '河南新密农村商业银行股份有限公司曲梁支行'
	) orgid,
	u.id uid
FROM
	t_s_base_user u
WHERE
	u.username IN (
		'00510116',
		'00510205',
		'00510180',
		'00510196',
		'00510024',
		'00510155',
		'00510008',
		'00520082',
		'00520125',
		'00520257',
		'00520254',
		'00510257',
		'00520167'
	);

-- 15)河南新密农村商业银行股份有限公司营业部
INSERT npa_corporate_org_user (corporate_org_id, userid) SELECT
	(
		SELECT
			id
		FROM
			npa_corporate_org o
		WHERE
			o. NAME = '河南新密农村商业银行股份有限公司营业部'
	) orgid,
	u.id uid
FROM
	t_s_base_user u
WHERE
	u.username IN (
		'00510021',
		'00510123',
		'00520010',
		'00520025',
		'00520008',
		'00510055',
		'00520245',
		'00510193'
	);

-- 16)河南新密农村商业银行股份有限公司袁庄支行
INSERT npa_corporate_org_user (corporate_org_id, userid) SELECT
	(
		SELECT
			id
		FROM
			npa_corporate_org o
		WHERE
			o. NAME = '河南新密农村商业银行股份有限公司袁庄支行'
	) orgid,
	u.id uid
FROM
	t_s_base_user u
WHERE
	u.username IN (
		'00520202',
		'00520186',
		'00510250',
		'00510170',
		'00510161'
	);

-- 17)河南新密农村商业银行股份有限公司岳村支行
INSERT npa_corporate_org_user (corporate_org_id, userid) SELECT
	(
		SELECT
			id
		FROM
			npa_corporate_org o
		WHERE
			o. NAME = '河南新密农村商业银行股份有限公司岳村支行'
	) orgid,
	u.id uid
FROM
	t_s_base_user u
WHERE
	u.username IN (
		'00510204',
		'00520247',
		'00520162',
		'00510249'
	);