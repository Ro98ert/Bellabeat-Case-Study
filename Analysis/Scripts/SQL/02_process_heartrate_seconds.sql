# I create a clean table with correct values and correct column names

CREATE OR REPLACE TABLE `bellabeat-481518.bellabeat_clean.heartrate_seconds` AS
SELECT DISTINCT
  Id AS id,
  PARSE_TIMESTAMP('%m/%d/%Y %I:%M:%S %p', Time) AS time, # Converting the string to a timestamp format
  Value AS heart_rate,
FROM `bellabeat-481518.bellabeat_raw.heartrate_seconds`


# I compare raw table with clean table, observing users number is the same

SELECT
  'Clean Table' AS table_type,
  COUNT(*) AS total_rows,
  COUNT(DISTINCT id) AS users
FROM `bellabeat-481518.bellabeat_clean.heartrate_seconds`
UNION ALL
SELECT
  'Raw Table' AS table_type,
  COUNT(*) AS total_rows,
  COUNT(DISTINCT id) AS users
FROM `bellabeat-481518.bellabeat_raw.heartrate_seconds`


# I verify for duplicates if exists, no duplicates existing

SELECT
  id,
  time,
  COUNT(*) AS records_at_this_time
FROM `bellabeat-481518.bellabeat_clean.heartrate_seconds`
GROUP BY id, time
HAVING COUNT(*) > 1;


# Checking for NULLs in key columns, no NULLs present

SELECT
  COUNTIF(id IS NULL) AS null_id,
  COUNTIF(time IS NULL) AS null_time,
  COUNTIF(heart_rate IS NULL) AS null_heart_rate
FROM `bellabeat-481518.bellabeat_clean.heartrate_seconds`


# Checking for unrealistic values, all values are normal

SELECT
  MIN(heart_rate) AS min_heart_rate,
  AVG(heart_rate) AS avg_heart_rate,
  MAX(heart_rate) AS max_heart_rate
FROM `bellabeat-481518.bellabeat_clean.heartrate_seconds`


# Downsampling data into 1-minute avg

CREATE TABLE `bellabeat-481518.bellabeat_clean.heartrate_min_avg` AS
SELECT
  id,
  DATETIME_TRUNC(time, MINUTE) AS heart_rate_minute,
  AVG(heart_rate) AS avg_heart_rate
FROM `bellabeat-481518.bellabeat_clean.heartrate_seconds`
GROUP BY id, heart_rate_minute
