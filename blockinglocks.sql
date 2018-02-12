SET PAUSE ON
SET PAUSE 'Press Return to Continue'
SET LINESIZE 300
SET PAGESIZE 60
COLUMN username FORMAT A15
COLUMN osuser FORMAT A8
COLUMN sid FORMAT 99999
COLUMN serial# FORMAT 99999
COLUMN process_id FORMAT A5
COLUMN wait_class FORMAT A12
COLUMN seconds_in_wait FORMAT 9999
COLUMN state FORMAT A17
COLUMN blocking_session FORMAT 9999
COLUMN blocking_session_state FORMAT A10
COLUMN module FORMAT A10
COLUMN logon_time FORMAT A20
SELECT NVL(a.username, '(oracle)') AS username,
  a.osuser,
  a.inst_id,
  a.sid,
  a.serial#,
  a.sql_id,
  d.spid AS process_id,
  a.wait_class,
  a.seconds_in_wait,
  a.state,
  a.blocking_instance,
  a.blocking_session,
  a.blocking_session_status,
  a.module,
  TO_CHAR(a.logon_Time,'DD-MON-YYYY HH24:MI:SS') AS logon_time
FROM gv$session a,
  gv$process d
WHERE a.paddr           = d.addr
AND a.inst_id           = d.inst_id
AND a.status            = 'ACTIVE'
AND a.blocking_session IS NOT NULL
ORDER BY 1,2
/