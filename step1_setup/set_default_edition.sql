-- must be run as DBA.  Unless we give alter database priv to iqprodr or an "edition user".

-- make the database default to the 0_1_1 edition.  This is how it would be after the 0_1_1 deploy.
ALTER DATABASE default edition = cust_reporting_0_1_1;

exit

