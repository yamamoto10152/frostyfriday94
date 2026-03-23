CREATE DATABASE frostyfriday;
CREATE SCHEMA week94;


-- ステージ上のファイルからやる場合
CREATE STAGE setup_stage;

COPY FILES INTO @setup_stage
FROM 'snow://workspace/USER$.PUBLIC."frostyfriday94"/versions/live'
FILES=('setup_env_made_by_intern.sql');

EXECUTE IMMEDIATE FROM @setup_stage/setup_env_made_by_intern.sql
USING (DEPLOYMENT_TYPE => 'prod');

EXECUTE IMMEDIATE FROM @setup_stage/setup_env_made_by_intern.sql
USING (DEPLOYMENT_TYPE => 'non-prod');


-- Gitリポジトリ上のファイルからやる場合
CREATE GIT REPOSITORY frostyfriday.week94.ff94
  API_INTEGRATION = GIT_OAUTH_INTEGRATION
  ORIGIN = 'https://github.com/yamamoto10152/frostyfriday94.git';

EXECUTE IMMEDIATE FROM @frostyfriday.week94.ff94/branches/main/setup_env_made_by_intern.sql
USING (DEPLOYMENT_TYPE => 'prod');

EXECUTE IMMEDIATE FROM @frostyfriday.week94.ff94/branches/main/setup_env_made_by_intern.sql
USING (DEPLOYMENT_TYPE => 'non-prod');