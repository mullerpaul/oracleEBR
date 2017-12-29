-- run as DBA user
DROP USER iqprodr_user CASCADE;
DROP USER iqprodr CASCADE;
-- the cascade option allows us to drop editions with objects
DROP EDITION cust_reporting_0_1_2 cascade;
DROP EDITION cust_reporting_0_1_1 cascade;
-- it looks like we don't need to set database default back here.  Dropping the default moves it back to the parent.
-- if we can't drop an edition due to ORA-38805 edition is in use error; 
--   then change the default edition bacck to ORA$BASE and restart the instance.
