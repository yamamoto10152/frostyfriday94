CREATE DATABASE frostyfriday;
CREATE SCHEMA week94;
CREATE STAGE setup_stage;

EXECUTE IMMEDIATE FROM @setup_stage/setup_env_made_by_intern.sql
USING (DEPLOYMENT_TYPE => 'prod');

-- then for non-prod
EXECUTE IMMEDIATE FROM @setup_stage/setup_env_made_by_intern.sql
USING (DEPLOYMENT_TYPE => 'non-prod');
