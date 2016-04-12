set echo off
set feedback off
set flush off
set heading off
set pagesize 0
set tab off
set trimout on

SELECT
	circ_transaction_id || chr(9)
||	charge_date || chr(9)
||	charge_location || chr(9)
||	discharge_date || chr(9)
||	discharge_type || chr(9)
||	patron_group_id || chr(9)
||	item_id || chr(9)
||	item_type_id || chr(9)
||	on_reserve || chr(9)
||	perm_location || chr(9)
||	temp_location
FROM
(	SELECT 
		CT.circ_transaction_id
	,	CT.item_id
	,	CT.patron_group_id
	,	To_Char(CT.charge_date, 'YYYY-MM-DD') AS charge_date
	,	CT.charge_location
	,	To_Char(CT.discharge_date, 'YYYY-MM-DD') AS discharge_date
	,	CT.discharge_type
	,	I.on_reserve
	,	I.perm_location
	,	I.temp_location
	,	I.item_type_id
	FROM circ_transactions CT
	INNER JOIN item I 
		ON CT.item_id = I.item_id
	WHERE charge_date >= To_Date('STARTDATE', 'YYYYMMDD')
	AND charge_date < To_Date('ENDDATE', 'YYYYMMDD')
	UNION ALL
	SELECT 
		CTA.circ_transaction_id
	,	CTA.item_id
	,	CTA.patron_group_id
	,	To_Char(CTA.charge_date, 'YYYY-MM-DD') AS charge_date
	,	CTA.charge_location
	,	To_Char(CTA.discharge_date, 'YYYY-MM-DD') AS discharge_date
	,	CTA.discharge_type
	,	I.on_reserve
	,	I.perm_location
	,	I.temp_location
	,	I.item_type_id
	FROM circ_trans_archive CTA
	INNER JOIN item I 
		ON CTA.item_id = I.item_id
	WHERE charge_date >= To_Date('STARTDATE', 'YYYYMMDD')
	AND charge_date < To_Date('ENDDATE', 'YYYYMMDD')
) union_query
/

quit
/
