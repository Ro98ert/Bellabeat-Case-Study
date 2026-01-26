# I create a clean table with correct values and correct column names

CREATE OR REPLACE TABLE `bellabeat-481518.bellabeat_clean.minute_intensities` AS
SELECT DISTINCT
  Id AS id,
  PARSE_TIMESTAMP('%m/%d/%Y %I:%M:%S %p', TRIM(ActivityMinute)) AS activity_minute,
  Intensity AS intensity
FROM `bellabeat-481518.bellabeat_raw.minute_intensities`


# I compare raw table with clean table, observing users number is the same

SELECT
  'Clean Table' AS table_type,
  COUNT(*) AS total_rows,
  COUNT(DISTINCT id) AS users
FROM `bellabeat-481518.bellabeat_clean.minute_intensities`
UNION ALL
SELECT
  'Raw Table' AS table_type,
  COUNT(*) AS total_rows,
  COUNT(DISTINCT id) AS users
FROM `bellabeat-481518.bellabeat_raw.minute_intensities`


# I verify for duplicates if exists, no duplicates present

SELECT
  id,
  activity_minute,
  COUNT(*) AS duplicates
FROM `bellabeat-481518.bellabeat_clean.minute_intensities`
GROUP BY id, activity_minute
HAVING COUNT(*) > 1;


# Checking for NULLs in key columns, no NULLs present

SELECT
  COUNTIF(id IS NULL) AS null_id,
  COUNTIF(activity_minute IS NULL) AS null_activity,
  COUNTIF(intensity IS NULL) AS null_intensity,
FROM `bellabeat-481518.bellabeat_clean.minute_intensities`


# Checking for unrealistic values, observing that there are normal values

SELECT
  MIN(intensity) AS min_intensity,
  AVG(intensity) AS avg_intensity,
  MAX(intensity) AS max_intensity,
  COUNT(intensity) AS total_intensities
FROM `bellabeat-481518.bellabeat_clean.minute_intensities`
