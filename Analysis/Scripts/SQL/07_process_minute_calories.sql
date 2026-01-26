# I create a clean table with correct values and correct column names

CREATE OR REPLACE TABLE `bellabeat-481518.bellabeat_clean.minute_calories` AS
SELECT DISTINCT
  Id AS id,
  PARSE_TIMESTAMP('%m/%d/%Y %I:%M:%S %p', TRIM(ActivityMinute)) AS activity_minute,
  calories AS calories
FROM `bellabeat-481518.bellabeat_raw.minute_calories`


# I compare raw table with clean table, observing users number is the same

SELECT
  'Clean Table' AS table_type,
  COUNT(*) AS total_rows,
  COUNT(DISTINCT id) AS users
FROM `bellabeat-481518.bellabeat_clean.minute_calories`
UNION ALL
SELECT
  'Raw Table' AS table_type,
  COUNT(*) AS total_rows,
  COUNT(DISTINCT id) AS users
FROM `bellabeat-481518.bellabeat_raw.minute_calories`


# I verify for duplicates if exists, no duplicates present

SELECT
  id,
  activity_minute,
  COUNT(*) AS duplicates
FROM `bellabeat-481518.bellabeat_clean.minute_calories`
GROUP BY id, activity_minute
HAVING COUNT(*) > 1;


# Checking for NULLs in key columns, no NULLs present

SELECT
  COUNTIF(id IS NULL) AS null_id,
  COUNTIF(activity_minute IS NULL) AS null_activity,
  COUNTIF(calories IS NULL) AS null_calories,
FROM `bellabeat-481518.bellabeat_clean.minute_calories`


# Checking for unrealistic values, observing that min calories goes to 0, suggesting that the device wasn't being worn or was powered of during that minute.

SELECT
  MIN(calories) AS min_calories,
  AVG(calories) AS avg_calories,
  MAX(calories) AS max_calories,
  COUNT(calories) AS total_calories
FROM `bellabeat-481518.bellabeat_clean.minute_calories`

# Pursuing with the filtering phase for the 0 values.

SELECT
  EXTRACT(HOUR FROM t1.activity_minute) AS activity_hour,
  AVG(t1.METs) AS avg_METs,
  AVG(t2.calories) AS avg_calories,
FROM `bellabeat-481518.bellabeat_clean.minute_MET` AS t1
INNER JOIN `bellabeat-481518.bellabeat_clean.minute_calories` AS t2
  ON t1.activity_minute = t2.activity_minute
  AND t1.id = t2.id
WHERE t2.calories > 0
GROUP BY activity_hour
ORDER BY activity_hour
