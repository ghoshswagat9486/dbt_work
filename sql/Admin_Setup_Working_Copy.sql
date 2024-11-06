-- ORGADMIN
-- Role that manages operations at the organization level.

USE ROLE ACCOUNTADMIN; -- ACCOUNTADMIN=SYSADMIN + SECURITYADMIN
-- top-level role in the system and should be granted only to a limited/controlled number of users in your account.


USE ROLE SYSADMIN;
-- ========================
-- Create Data Base objects using SYSADMIN
CREATE OR REPLACE WAREHOUSE WH_DATA_LOAD;
CREATE OR REPLACE WAREHOUSE WH_DATA_ANALYTICS;

CREATE OR REPLACE DATABASE ANALYTICS_DEV_DB;
CREATE OR REPLACE DATABASE ANALYTICS_QA_DB;
CREATE OR REPLACE DATABASE ANALYTICS_PROD_DB;
/*create or replace database role ANALYTICS_DEV_DB.DB_READER;
create or replace database role ANALYTICS_DEV_DB.DB_WRITER;
create or replace database role ANALYTICS_QA_DB.DB_READER;
create or replace database role ANALYTICS_QA_DB.DB_WRITER;
create or replace database role ANALYTICS_PROD_DB.DB_READER;
create or replace database role ANALYTICS_PROD_DB.DB_WRITER;*/


USE ROLE USERADMIN;
-- ========================
-- Create Data base roles using USERADMIN
CREATE OR REPLACE ROLE DATA_ENGINEER;
CREATE OR REPLACE ROLE DATA_ANALYST;
CREATE OR REPLACE ROLE DATA_LOADER;
-- Database Grants


USE ROLE SYSADMIN;
grant usage on database ANALYTICS_DEV_DB to  role DATA_ENGINEER WITH GRANT OPTION;
grant select on all tables in database ANALYTICS_DEV_DB to  role DATA_ENGINEER WITH GRANT OPTION; 
grant all privileges on database ANALYTICS_DEV_DB to  role DATA_ENGINEER WITH GRANT OPTION; 
grant all on all schemas in database ANALYTICS_DEV_DB to  role DATA_ENGINEER WITH GRANT OPTION; 
USE ROLE SECURITYADMIN;
grant all on future schemas in database ANALYTICS_DEV_DB to role DATA_ENGINEER WITH GRANT OPTION;
grant all on future tables in database ANALYTICS_DEV_DB to role DATA_ENGINEER WITH GRANT OPTION;


grant usage on database ANALYTICS_DEV_DB to  role DATA_ANALYST WITH GRANT OPTION;
grant select on all tables in database ANALYTICS_DEV_DB to  role DATA_ANALYST WITH GRANT OPTION; 

USE ROLE SECURITYADMIN;
grant select on future tables in database ANALYTICS_DEV_DB to role DATA_ANALYST WITH GRANT OPTION;

USE ROLE SYSADMIN;
GRANT USAGE
  ON WAREHOUSE WH_DATA_LOAD
  TO ROLE DATA_ENGINEER WITH GRANT OPTION;

USE ROLE SYSADMIN;
GRANT USAGE
  ON WAREHOUSE WH_DATA_ANALYTICS
  TO ROLE DATA_ENGINEER WITH GRANT OPTION;  

USE ROLE SYSADMIN;
GRANT USAGE
  ON WAREHOUSE WH_DATA_ANALYTICS
  TO ROLE DATA_ANALYST WITH GRANT OPTION;  

USE ROLE USERADMIN;


CREATE OR REPLACE USER db_loader_dev
PASSWORD = 'db_loader'
LOGIN_NAME = 'db_loader_dev'
FIRST_NAME = 'Loading'
LAST_NAME = 'Account'
EMAIL = 'sghosh_certs@gmail.com'
MUST_CHANGE_PASSWORD = false
DEFAULT_WAREHOUSE = WH_DATA_LOAD;

GRANT role DATA_ENGINEER to user db_loader_dev;

CREATE OR REPLACE USER db_viewer_dev
PASSWORD = 'db_viewer'
LOGIN_NAME = 'db_viewer_dev'
FIRST_NAME = 'Viewing'
LAST_NAME = 'Account'
EMAIL = 'sghosh_certs@gmail.com'
MUST_CHANGE_PASSWORD = false
DEFAULT_WAREHOUSE = WH_DATA_LOAD;

GRANT role DATA_ANALYST to user db_viewer_dev;

use role accountadmin;

CREATE OR REPLACE USER sf_admin
PASSWORD = 'Account123'
LOGIN_NAME = 'SF_ADMIN'
FIRST_NAME = 'admin'
LAST_NAME = 'Account'
EMAIL = 'sghosh_certs@gmail.com'
MUST_CHANGE_PASSWORD = false
DEFAULT_WAREHOUSE = WH_DATA_LOAD; 

GRANT role ACCOUNTADMIN to user sf_admin;

use role accountadmin;

CREATE OR REPLACE USER db_admin
PASSWORD = 'Account123'
LOGIN_NAME = 'DB_ADMIN'
FIRST_NAME = 'db'
LAST_NAME = 'Account'
EMAIL = 'sghosh_certs@gmail.com'
MUST_CHANGE_PASSWORD = false
DEFAULT_WAREHOUSE = WH_DATA_LOAD; 

GRANT role USERADMIN to user acct_admin;


GRANT role SYSADMIN to user db_admin;

