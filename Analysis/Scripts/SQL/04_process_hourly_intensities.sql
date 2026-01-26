# I create a clean table with correct values and correct column names

CREATE OR REPLACE TABLE `bellabeat-481518.bellabeat_clean.hourly_intensities` AS
SELECT DISTINCT
  Id AS id,
  PARSE_TIMESTAMP('%m/%d/%Y %I:%M:%S %p', ActivityHour) AS activity_hour,
  SAFE_CAST(TotalIntensity AS FLOAT64) AS total_intensity,
  SAFE_CAST(AverageIntensity AS FLOAT64) AS average_intensity
FROM `bellabeat-481518.bellabeat_raw.hourly_intensities`


# I compare raw table with clean table, observing users number is the same

SELECT
  'Clean Table' AS table_type,
  COUNT(*) AS total_rows,
  COUNT(DISTINCT id) AS users
FROM `bellabeat-481518.bellabeat_clean.hourly_intensities`
UNION ALL
SELECT
  'Raw Table' AS table_type,
  COUNT(*) AS total_rows,
  COUNT(DISTINCT id) AS users
FROM `bellabeat-481518.bellabeat_raw.hourly_intensities`


# I verify for duplicates if exists, no duplicates present

SELECT
  id,
  activity_hour,
  COUNT(*) AS records_at_this_time
FROM `bellabeat-481518.bellabeat_clean.hourly_intensities`
GROUP BY id, activity_hour
HAVING COUNT(*) > 1;


# Checking for NULLs in key columns, no NULLs present

SELECT
  COUNTIF(id IS NULL) AS null_id,
  COUNTIF(activity_hour IS NULL) AS null_activity,
  COUNTIF(total_intensity IS NULL) AS null_total_intensity,
  COUNTIF(average_intensity IS NULL) AS null_average_intensity
FROM `bellabeat-481518.bellabeat_clean.hourly_intensities`


# Checking for unrealistic values, all values are normal

SELECT
  MIN(total_intensity) AS min_total_intensity,
  AVG(total_intensity) AS avg_total_intensity,
  MAX(total_intensity) AS max_total_intensity,

  MIN(average_intensity) AS min_average_intensity,
  AVG(average_intensity) AS avg_average_intensity,
  MAX(average_intensity) AS max_average_intensity
FROM `bellabeat-481518.bellabeat_clean.hourly_intensities`


# Verifying that the relationship between total and average intensity columns is mathematically consistent, having positive results.

SELECT
  id,
  activity_hour,
  total_intensity,
  average_intensity,
  (average_intensity * 60) AS calculated_total,
  ABS(total_intensity - (average_intensity * 60)) AS difference
FROM `bellabeat-481518.bellabeat_clean.hourly_intensities`
WHERE ABS(total_intensity - (average_intensity * 60)) > 0.1;
