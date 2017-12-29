-- must be run as SYS (could be any DBA level user except for the grant on DBMS_LOCK which requires SYS)

-- IQPRODR user is like ours in prod.  
-- IQPRODR_USER is a new concept we might want to implement - a user the app connects as which is NOT the owner of the objects
CREATE USER iqprodr
IDENTIFIED BY iqprodr
DEFAULT TABLESPACE users
QUOTA UNLIMITED ON users;

CREATE USER iqprodr_user
IDENTIFIED BY iqprodr_user
DEFAULT TABLESPACE users
QUOTA UNLIMITED ON users;

-- grant system privs to our users.  
-- I'm unsure if we'd actually grant these first two "ANY EDITION" privs in prod.
-- the other privs are pretty standard.
GRANT create any edition, drop any edition TO iqprodr;
GRANT create session, create synonym, create table, create view, create procedure, create type TO iqprodr;
GRANT create session, create synonym TO iqprodr_user;

-- this role grant is here mostly for demo purposes
GRANT select_catalog_role TO iqprodr, iqprodr_user;

-- this is here so we can make a slow function for demo purposes
GRANT EXECUTE ON dbms_lock TO iqprodr;

-- need these so that our users can see the editions
ALTER USER iqprodr ENABLE EDITIONS;
ALTER USER iqprodr_user ENABLE EDITIONS;

