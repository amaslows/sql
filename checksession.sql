SET lines 155
SET pages 9999 col sql_text FOR a40 col executions FOR 9,999 col sql_id FOR a15
SELECT sa.sql_text,
  s.sql_hash_value,
  s.sql_id,
  version_count,
  executions,
  optimizer_mode,
  users_executing,
  buffer_gets,
  disk_reads
FROM gv$session s,
  gv$sqlarea sa
WHERE s.sid =
  &sid
AND s.inst_id =
  &inst_id
AND s.sql_address    = sa.address
AND s.sql_hash_value = sa.hash_value
AND s.inst_id        = sa.inst_id;