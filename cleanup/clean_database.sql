-- run as DBA user
DROP USER iqprodr_user CASCADE;
DROP USER iqprodr CASCADE;
DROP EDITION cust_reporting_0_1_2;
DROP EDITION cust_reporting_0_1_1;
-- it looks like we don't need to set daatabase default back here.  Dropping the default moves it back to the parent.
