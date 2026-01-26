# I create a clean table with correct values and correct column names

CREATE OR REPLACE TABLE `bellabeat-481518.bellabeat_clean.minute_sleep` AS
SELECT DISTINCT
  Id AS id,
  PARSE_TIMESTAMP('%m/%d/%Y %I:%M:%S %p', TRIM(date)) AS sleep_time,
  value AS sleep_status,
  logId AS log_id
FROM `bellabeat-481518.bellabeat_raw.minute_sleep`


# I compare raw table with clean table, observing users number is the same

SELECT
  'Clean Table' AS table_type,
  COUNT(*) AS total_rows,
  COUNT(DISTINCT id) AS users
FROM `bellabeat-481518.bellabeat_clean.minute_sleep`
UNION ALL
SELECT
  'Raw Table' AS table_type,
  COUNT(*) AS total_rows,
  COUNT(DISTINCT id) AS users
FROM `bellabeat-481518.bellabeat_raw.minute_sleep`


# I verify for duplicates if exists, no duplicates present

SELECT
  id,
  sleep_time,
  sleep_status,
  log_id,
  COUNT(*) AS duplicates
FROM `bellabeat-481518.bellabeat_clean.minute_sleep`
GROUP BY id, sleep_time, sleep_status, log_id
HAVING COUNT(*) > 1;


# Checking for NULLs in key columns, no NULLs present

SELECT
  COUNTIF(id IS NULL) AS null_id,
  COUNTIF(sleep_time IS NULL) AS null_sleep_time,
  COUNTIF(sleep_status IS NULL) AS null_sleep_status,
  COUNTIF(log_id IS NULL) AS null_log_id,
FROM `bellabeat-481518.bellabeat_clean.minute_sleep`


# Checking for unrealistic values, observing that there are normal values of "1,2,3"

SELECT
  MIN(sleep_status) AS min_sleep_status,
  AVG(sleep_status) AS avg_sleep_status,
  MAX(sleep_status) AS max_sleep_status,
  COUNT(sleep_status) AS total_sleep_status
FROM `bellabeat-481518.bellabeat_clean.minute_sleep`
