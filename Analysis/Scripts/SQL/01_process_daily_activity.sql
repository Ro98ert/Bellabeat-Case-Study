# Creating a clean table with correct values and correct column titles

CREATE OR REPLACE TABLE `bellabeat-481518.bellabeat_clean.daily_activity` AS
SELECT
  Id AS id,
  ActivityDate AS activity_date,
  TotalSteps AS total_steps,
  TotalDistance AS total_distance,
  VeryActiveDistance AS very_active_distance,
  ModeratelyActiveDistance AS moderately_active_distance,
  LightActiveDistance AS light_active_distance,
  SedentaryActiveDistance AS sedentary_active_distance,
  VeryActiveMinutes AS very_active_minutes,
  FairlyActiveMinutes AS fairly_active_minutes,
  LightlyActiveMinutes AS lightly_active_minutes,
  SedentaryMinutes AS sedentary_minutes,
  Calories AS calories
FROM `bellabeat-481518.bellabeat_raw.daily_activity`
WHERE Calories > 0
  AND NOT (TotalSteps = 0 AND VeryActiveMinutes > 0);


# Comparing raw data with clean data, observing users are the same

SELECT
  'Clean Table' AS table_type,
  COUNT(*) AS total_rows,
  COUNT(DISTINCT id) AS users
FROM `bellabeat-481518.bellabeat_clean.daily_activity`
UNION ALL
SELECT
  'Raw Table' AS table_type,
  COUNT(*) AS total_rows,
  COUNT(DISTINCT id) AS users
FROM `bellabeat-481518.bellabeat_raw.daily_activity`


# Checking data type

SELECT
  column_name,
  data_type
FROM `bellabeat-481518.bellabeat_clean.INFORMATION_SCHEMA.COLUMNS`
WHERE table_name = 'daily_activity'
ORDER BY ordinal_position;


# Checking for NULLs in key columns

SELECT
  COUNTIF(id IS NULL) AS null_id,
  COUNTIF(activity_date IS NULL) AS null_date,
  COUNTIF(total_steps IS NULL) AS null_steps,
  COUNTIF(calories IS NULL) AS null_cal
FROM `bellabeat-481518.bellabeat_clean.daily_activity`


# Checking for duplicates

SELECT
  id,
  activity_date,
  COUNT(*) AS records_per_day
FROM `bellabeat-481518.bellabeat_clean.daily_activity`
GROUP BY id, activity_date
HAVING COUNT(*) > 1;


# Checking for wrong values

SELECT
  MIN(total_steps) AS min_steps,
  MAX(total_steps) AS max_steps,
  MIN(calories) AS min_cal,
  MAX(calories) AS max_cal,
  MAX(sedentary_minutes) AS max_sedentary_minutes
FROM `bellabeat-481518.bellabeat_clean.daily_activity`
