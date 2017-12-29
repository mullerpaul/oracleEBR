-- more SQL*plus pretty print options
col object_name format a30
col edition_name format a20
col editionable format a14
SET linesize 120 trimspool ON echo ON

-- By default we log in as the database edition
SELECT SYS_CONTEXT('USERENV', 'SESSION_EDITION_NAME') AS edition FROM dual;

-- But the changes in the migration MUST be run as the NEW edition
ALTER SESSION SET edition = cust_reporting_0_1_2;

-- verify the change
SELECT SYS_CONTEXT('USERENV', 'SESSION_EDITION_NAME') AS edition FROM dual;

-- now make changes in the objects
-- remember - at this point the previous edition's copies of these objects 
-- are being used by current sessions!
CREATE OR REPLACE PACKAGE BODY dummy_package AS
  gc_version CONSTANT VARCHAR2(10) := '0.1.2';  --changed version

  PROCEDURE print_version
  IS
  BEGIN
    DBMS_OUTPUT.enable();
    DBMS_OUTPUT.put_line(gc_version);
  END print_version;

  FUNCTION get_version RETURN VARCHAR2
  IS
  BEGIN
    RETURN gc_version;
  END get_version;

  FUNCTION slow_function(fi_input IN NUMBER) RETURN NUMBER
  IS
  BEGIN
    dbms_lock.sleep(1);  -- 1 sec delay before input is passed through as output
    RETURN fi_input;
  END slow_function;
END dummy_package;
/

CREATE OR REPLACE VIEW dummy_view
AS
SELECT owner, object_id, object_name, object_type, created,
       dummy_package.get_version              AS package_version,
       dummy_package.slow_function(object_id) AS slow_object_id,  -- each row will add 1 sec of runtime
       1 AS new_column  --added new column in this version
  FROM dummy_table;

-- now verify these objects are valid and exist in the correct edition
SELECT object_name, object_type, status, editionable, edition_name
  FROM user_objects
 ORDER BY 1,2,5;

-- look "Across Editions" (or All Editions) with the user_objects_AE view
SELECT object_name, object_type, status, editionable, edition_name
  FROM user_objects_ae
 ORDER BY 1,2,5;

exit

