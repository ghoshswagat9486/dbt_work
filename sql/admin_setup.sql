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
create or replace database role ANALYTICS_DEV_DB.DB_READER;
create or replace database role ANALYTICS_DEV_DB.DB_WRITER;
create or replace database role ANALYTICS_QA_DB.DB_READER;
create or replace database role ANALYTICS_QA_DB.DB_WRITER;
create or replace database role ANALYTICS_PROD_DB.DB_READER;
create or replace database role ANALYTICS_PROD_DB.DB_WRITER;


USE ROLE USERADMIN;
-- ========================
-- Create Data base roles using USERADMIN
CREATE OR REPLACE ROLE DATA_ENGINEER;
CREATE OR REPLACE ROLE DATA_ANALYST;
CREATE OR REPLACE ROLE DATA_LOADER;
-- Database Grants




USE ROLE SYSADMIN;
-- ========================
-- Grant database Privileges using SYSADMIN
grant usage on database ANALYTICS_DEV_DB to database role ANALYTICS_DEV_DB.DB_READER WITH GRANT OPTION;
grant usage on database ANALYTICS_DEV_DB to database role ANALYTICS_DEV_DB.DB_READER WITH GRANT OPTION;
grant select on all tables in database ANALYTICS_DEV_DB to database role ANALYTICS_DEV_DB.DB_READER WITH GRANT OPTION; 
grant usage on all schemas in database ANALYTICS_DEV_DB to database role ANALYTICS_DEV_DB.DB_READER WITH GRANT OPTION;
grant usage on database ANALYTICS_QA_DB to database role ANALYTICS_QA_DB.DB_READER WITH GRANT OPTION;
grant usage on database ANALYTICS_QA_DB to database role ANALYTICS_QA_DB.DB_READER WITH GRANT OPTION;
grant select on all tables in database ANALYTICS_QA_DB to database role ANALYTICS_QA_DB.DB_READER WITH GRANT OPTION; 
grant usage on all schemas in database ANALYTICS_QA_DB to database role ANALYTICS_QA_DB.DB_READER WITH GRANT OPTION;
grant usage on database ANALYTICS_PROD_DB to database role ANALYTICS_PROD_DB.DB_READER WITH GRANT OPTION;
grant usage on database ANALYTICS_PROD_DB to database role ANALYTICS_PROD_DB.DB_READER WITH GRANT OPTION;
grant select on all tables in database ANALYTICS_PROD_DB to database role ANALYTICS_PROD_DB.DB_READER WITH GRANT OPTION; 
grant usage on all schemas in database ANALYTICS_PROD_DB to database role ANALYTICS_PROD_DB.DB_READER WITH GRANT OPTION;
grant create schema on database ANALYTICS_DEV_DB to database role ANALYTICS_DEV_DB.DB_WRITER WITH GRANT OPTION;
grant all on all schemas in database ANALYTICS_DEV_DB to database role ANALYTICS_DEV_DB.DB_WRITER WITH GRANT OPTION; 
grant all on all tables in database ANALYTICS_DEV_DB to database role ANALYTICS_DEV_DB.DB_WRITER WITH GRANT OPTION; 
grant create schema on database ANALYTICS_QA_DB to database role ANALYTICS_QA_DB.DB_WRITER WITH GRANT OPTION;
grant all on all schemas in database ANALYTICS_QA_DB to database role ANALYTICS_QA_DB.DB_WRITER WITH GRANT OPTION; 
grant all on all tables in database ANALYTICS_QA_DB to database role ANALYTICS_QA_DB.DB_WRITER WITH GRANT OPTION; 
grant create schema on database ANALYTICS_PROD_DB to database role ANALYTICS_PROD_DB.DB_WRITER WITH GRANT OPTION;
grant all on all schemas in database ANALYTICS_PROD_DB to database role ANALYTICS_PROD_DB.DB_WRITER WITH GRANT OPTION; 
grant all on all tables in database ANALYTICS_PROD_DB to database role ANALYTICS_PROD_DB.DB_WRITER WITH GRANT OPTION; 


USE ROLE SECURITYADMIN;
-- ======================
-- future grants (can be applied only using accountadmin or securityadmin)
grant select on future tables in database ANALYTICS_DEV_DB to database role ANALYTICS_DEV_DB.DB_READER WITH GRANT OPTION;
grant select on future tables in database ANALYTICS_QA_DB to database role ANALYTICS_QA_DB.DB_READER WITH GRANT OPTION;
grant select on future tables in database ANALYTICS_PROD_DB to database role ANALYTICS_PROD_DB.DB_READER WITH GRANT OPTION;

grant all on future schemas in database ANALYTICS_DEV_DB to database role ANALYTICS_DEV_DB.DB_WRITER WITH GRANT OPTION;
grant all on future schemas in database ANALYTICS_QA_DB to database role ANALYTICS_QA_DB.DB_WRITER WITH GRANT OPTION;
grant all on future schemas in database ANALYTICS_PROD_DB to database role ANALYTICS_PROD_DB.DB_WRITER WITH GRANT OPTION;
grant all on future tables in database ANALYTICS_DEV_DB to database role ANALYTICS_DEV_DB.DB_WRITER WITH GRANT OPTION;
grant all on future tables in database ANALYTICS_QA_DB to database role ANALYTICS_QA_DB.DB_WRITER WITH GRANT OPTION;
grant all on future tables in database ANALYTICS_PROD_DB to database role ANALYTICS_PROD_DB.DB_WRITER WITH GRANT OPTION;

-- assign database roles to main roles
grant database role ANALYTICS_DEV_DB.DB_READER to role DATA_ANALYST;
grant database role ANALYTICS_QA_DB.DB_READER to role DATA_ANALYST;
grant database role ANALYTICS_PROD_DB.DB_READER to role DATA_ANALYST;
grant database role ANALYTICS_DEV_DB.DB_WRITER to role DATA_ENGINEER;
grant database role ANALYTICS_QA_DB.DB_WRITER to role DATA_ENGINEER;
grant database role ANALYTICS_PROD_DB.DB_READER to role DATA_ENGINEER;
grant database role ANALYTICS_DEV_DB.DB_WRITER to role DATA_LOADER;
grant database role ANALYTICS_QA_DB.DB_WRITER to role DATA_LOADER;
grant database role ANALYTICS_PROD_DB.DB_WRITER to role DATA_LOADER;

 
-- Warehouse Grants
GRANT USAGE,MONITOR,MODIFY
  ON WAREHOUSE WH_DATA_LOAD
  TO ROLE DATA_ENGINEER WITH GRANT OPTION;

GRANT USAGE,MONITOR,MODIFY
  ON WAREHOUSE WH_DATA_LOAD
  TO ROLE DATA_LOADER WITH GRANT OPTION;

GRANT USAGE,MONITOR,MODIFY
  ON WAREHOUSE WH_DATA_ANALYTICS
  TO ROLE DATA_ANALYST WITH GRANT OPTION;



GRANT OWNERSHIP ON WAREHOUSE WH_DATA_LOAD TO SYSADMIN WITH GRANT OPTION;
GRANT OWNERSHIP ON WAREHOUSE WH_DATA_ANALYTICS TO SYSADMIN WITH GRANT OPTION;



  
USE ROLE USERADMIN;

CREATE OR REPLACE USER db_loader_dev
PASSWORD = 'db_loader'
LOGIN_NAME = 'db_loader_dev'
FIRST_NAME = 'Loading'
LAST_NAME = 'Account'
EMAIL = 'sghosh_certs@gmail.com'
MUST_CHANGE_PASSWORD = true
DEFAULT_WAREHOUSE = WH_DATA_LOAD;


CREATE OR REPLACE USER db_loader_qa
PASSWORD = 'db_loader'
LOGIN_NAME = 'db_loader_qa'
FIRST_NAME = 'Loading'
LAST_NAME = 'Account'
EMAIL = 'sghosh_certs@gmail.com'
MUST_CHANGE_PASSWORD = true
DEFAULT_WAREHOUSE = WH_DATA_LOAD;


CREATE OR REPLACE USER db_loader_prod
PASSWORD = 'db_loader'
LOGIN_NAME = 'db_loader_prod'
FIRST_NAME = 'Loading'
LAST_NAME = 'Account'
EMAIL = 'sghosh_certs@gmail.com'
MUST_CHANGE_PASSWORD = true
DEFAULT_WAREHOUSE = WH_DATA_LOAD;


grant role DATA_LOADER to user db_loader_prod;
grant role DATA_ENGINEER to user db_loader_qa;
grant role DATA_ENGINEER to user db_loader_dev;




USE ROLE ACCOUNTADMIN;

SHOW grants to role data_engineer;
SHOW grants to database role ANALYTICS_DEV_DB.DB_WRITER;
