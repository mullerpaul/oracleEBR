col owner for a30
col object_name for a30
col package_version for a12
SET linesize 140 pagesize 100 trimspool ON time ON timing ON feedback ON echo ON
SELECT * 
  FROM iqprodr.dummy_view
 WHERE rownum <= &1;
exit
