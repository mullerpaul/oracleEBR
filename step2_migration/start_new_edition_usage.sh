# This environment variable will cause SQL*Plus to connect to the new edition
export ORA_EDITION=CUST_REPORTING_0_1_2

sqlplus iqprodr_user/iqprodr_user @sample_report.sql 60 &
sqlplus iqprodr_user/iqprodr_user @sample_report.sql 90 &

unset ORA_EDITION

