# I create a clean table with correct values and correct column names

CREATE OR REPLACE TABLE `bellabeat-481518.bellabeat_clean.minute_steps` AS
SELECT DISTINCT
  Id AS id,
  PARSE_TIMESTAMP('%m/%d/%Y %I:%M:%S %p', TRIM(ActivityMinute)) AS activity_minute,
  Steps AS steps
FROM `bellabeat-481518.bellabeat_raw.minute_steps`


# I compare raw table with clean table, observing users number is the same

SELECT
  'Clean Table' AS table_type,
  COUNT(*) AS total_rows,
  COUNT(DISTINCT id) AS users
FROM `bellabeat-481518.bellabeat_clean.minute_steps`
UNION ALL
SELECT
  'Raw Table' AS table_type,
  COUNT(*) AS total_rows,
  COUNT(DISTINCT id) AS users
FROM `bellabeat-481518.bellabeat_raw.minute_steps`


# I verify for duplicates if exists, no duplicates present

SELECT
  id,
  activity_minute,
  steps,
  COUNT(*) AS duplicates
FROM `bellabeat-481518.bellabeat_clean.minute_steps`
GROUP BY id, activity_minute, steps
HAVING COUNT(*) > 1;


# Checking for NULLs in key columns, no NULLs present

SELECT
  COUNTIF(id IS NULL) AS null_id,
  COUNTIF(activity_minute IS NULL) AS null_activity_minute,
  COUNTIF(steps IS NULL) AS null_steps
FROM `bellabeat-481518.bellabeat_clean.minute_steps`


# Checking for unrealistic values, observing that there are normal values.

SELECT
  MIN(steps) AS min_steps,
  AVG(steps) AS avg_steps,
  MAX(steps) AS max_steps,
  COUNT(steps) AS total_steps
FROM `bellabeat-481518.bellabeat_clean.minute_steps`
