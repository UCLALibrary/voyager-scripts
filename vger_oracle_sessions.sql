SET NEWPAGE 0
SET PAGESIZE 0
SET LINESIZE 132
SET FEEDBACK OFF
COLUMN SchemaName FORMAT A16
COLUMN OSUser FORMAT A12
COLUMN Machine FORMAT A20
COLUMN Program FORMAT A30

SELECT
	schemaname
,	osuser
,	machine
,	program
,	Count(*) AS sessions
FROM v$session
GROUP BY schemaname, osuser, machine, program
ORDER BY schemaname, osuser, machine, program
/
quit
/
