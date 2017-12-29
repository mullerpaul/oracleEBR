-- run as IQPRODR

-- more SQL*plus pretty print options
col object_name format a30
col edition_name format a20
col editionable format a14
SET linesize 120 trimspool on
----

CREATE TABLE dummy_table
AS
SELECT owner, object_id, object_name, object_type, created
  FROM all_objects;

CREATE PACKAGE dummy_package AS
  PROCEDURE print_version;
  FUNCTION  get_version RETURN VARCHAR2;
  FUNCTION  slow_function(fi_input IN NUMBER) RETURN NUMBER;
END dummy_package;
/

CREATE PACKAGE BODY dummy_package AS
  gc_version CONSTANT VARCHAR2(10) := '0.1.1';

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

CREATE VIEW dummy_view
AS
SELECT owner, object_id, object_name, object_type, created,
       dummy_package.get_version              AS package_version,
       dummy_package.slow_function(object_id) AS slow_object_id  -- each row will add 1 sec of runtime
  FROM dummy_table;

-- make grants
GRANT SELECT ON dummy_view TO iqprodr_user;
GRANT EXECUTE ON dummy_package TO iqprodr_user;

-- now verify these objects are valid and exist in the correct edition
SELECT object_name, object_type, status, editionable, edition_name
  FROM user_objects;

exit

