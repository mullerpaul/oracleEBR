These scripts set up the database users, the editions, and the database for this proof of concept.
Please run them in this order:

1. create_and_setup_users.sql   - run as SYS.
      This creates the database users.

2. setup_editions.sql           - run as iqprodr.
      This creates the editions used and shows some queries a DBA might use in maintaining and administering editions in the database.

3. set_default_edition.sql      - run as SYS (or other DBA user).
      Sets the database default edition to be the first of our created editions.  

4. create_reporting_objects.sql - run as iqprodr.
      This creates objects to simulate our custom reporting objects in prod.  We create the following:
        - a large table (like FO tables)
        - a view on the table (like datasource views)
        - a package containing functions used in the view.  One of the functions is a "slowdown" function so our queries against the view will be sure to run for a long time.
      We also make grants on these objects to the "user schema" the app will use to connect.


