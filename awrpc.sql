SET lines 155
SET pages 999 col execs FOR 999,999,999 col rows_proc FOR 999,999,999,999 col avg_etime FOR 999,999.999 col avg_lio FOR 999,999,999,999.9 col begin_interval_time FOR a30 col node FOR 99999 col sql_id FOR a15
BREAK ON plan_hash_value ON startup_time skip 1
SELECT ss.snap_id,
  ss.instance_number node,
  begin_interval_time,
  sql_id,
  plan_hash_value,
  NVL(executions_delta,0) execs,
  NVL(rows_processed_delta,0) rows_proc,
  (elapsed_time_delta/DECODE(NVL(executions_delta,0),0,1,executions_delta))/1000000 avg_etime,
  (buffer_gets_delta /DECODE(NVL(buffer_gets_delta,0),0,1,executions_delta)) avg_lio
FROM DBA_HIST_SQLSTAT S,
  DBA_HIST_SNAPSHOT SS
WHERE sql_id           = NVL('&sql_id','4dqs2k5tynk61')
AND ss.snap_id         = S.snap_id
AND ss.instance_number = S.instance_number
AND executions_delta   > 0
ORDER BY 1,
  2,
  3 /
