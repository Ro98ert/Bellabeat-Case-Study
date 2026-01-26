# I create a clean table with correct values and correct column names

CREATE OR REPLACE TABLE `bellabeat-481518.bellabeat_clean.hourly_steps` AS
SELECT DISTINCT
  Id AS id,
  PARSE_TIMESTAMP('%m/%d/%Y %I:%M:%S %p', TRIM(ActivityHour)) AS activity_hour,
  StepTotal AS total_steps
FROM `bellabeat-481518.bellabeat_raw.hourly_steps`


# I compare raw table with clean table, observing users number is the same

SELECT
  'Clean Table' AS table_type,
  COUNT(*) AS total_rows,
  COUNT(DISTINCT id) AS users
FROM `bellabeat-481518.bellabeat_clean.hourly_steps`
UNION ALL
SELECT
  'Raw Table' AS table_type,
  COUNT(*) AS total_rows,
  COUNT(DISTINCT id) AS users
FROM `bellabeat-481518.bellabeat_raw.hourly_steps`


# I verify for duplicates if exists, no duplicates present

SELECT
  id,
  activity_hour,
  COUNT(*) AS duplicates
FROM `bellabeat-481518.bellabeat_clean.hourly_steps`
GROUP BY id, activity_hour
HAVING COUNT(*) > 1;


# Checking for NULLs in key columns, no NULLs present

SELECT
  COUNTIF(id IS NULL) AS null_id,
  COUNTIF(activity_hour IS NULL) AS null_activity,
  COUNTIF(total_steps IS NULL) AS null_total_steps,
FROM `bellabeat-481518.bellabeat_clean.hourly_steps`


# Checking for unrealistic values, all values are normal

SELECT
  MIN(total_steps) AS min_total_steps,
  AVG(total_steps) AS avg_total_steps,
  MAX(total_steps) AS max_total_steps,
FROM `bellabeat-481518.bellabeat_clean.hourly_steps`

