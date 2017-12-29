-- meant to be run as IQPRODR (possibly as a DBA or a special "editions user" in prod)

-- these are just for pretty SQL*Plus output

col edition_name format a30
col parent_edition_name format a30
col usable format a6

col property_name format a30
col property_value format a30
col description format a40

col comments format a70

set LINESIZE 120 ECHO ON TRIMSPOOL ON

-- see what editions are available in our database
SELECT * FROM dba_editions;

-- Create two new editions, one for "current" production, and another for "upgrade".
-- I think we might end up using the kubernetes VERSION variable for these names.  I'll 
-- picknames to reflect that.  But dots and dashes are not allowed.  I'll use underscores
-- to separate the version numbers.
CREATE EDITION cust_reporting_0_1_1;
CREATE EDITION cust_reporting_0_1_2;

-- see them in the metadata view
SELECT * FROM dba_editions;

-- add some comments for fun (not required)
COMMENT ON EDITION cust_reporting_0_1_1 IS 'Went to prod on Nov 1st, 2017';
COMMENT ON EDITION cust_reporting_0_1_2 IS 'Going to prod on Jan 1st, 2018 - contains changes for IQN-99999';

SELECT * FROM dba_edition_comments;

-- we need these grants if we want iqpror_user to be able to connect to these editions!
-- without these, we'd get a version not exist error.
GRANT use ON EDITION cust_reporting_0_1_1 TO iqprodr_user;
GRANT use ON EDITION cust_reporting_0_1_2 TO iqprodr_user;

exit

