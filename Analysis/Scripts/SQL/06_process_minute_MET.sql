# I create a clean table with correct values and correct column names

CREATE OR REPLACE TABLE `bellabeat-481518.bellabeat_clean.minute_MET` AS
SELECT DISTINCT
  Id AS id,
  PARSE_TIMESTAMP('%m/%d/%Y %I:%M:%S %p', TRIM(ActivityMinute)) AS activity_minute,
  SAFE_CAST(METs AS FLOAT64)/10 AS METs
FROM `bellabeat-481518.bellabeat_raw.minute_MET`


# I compare raw table with clean table, observing users number is the same

SELECT
  'Clean Table' AS table_type,
  COUNT(*) AS total_rows,
  COUNT(DISTINCT id) AS users
FROM `bellabeat-481518.bellabeat_clean.minute_MET`
UNION ALL
SELECT
  'Raw Table' AS table_type,
  COUNT(*) AS total_rows,
  COUNT(DISTINCT id) AS users
FROM `bellabeat-481518.bellabeat_raw.minute_MET`


# I verify for duplicates if exists, no duplicates present

SELECT
  id,
  activity_minute,
  COUNT(*) AS duplicates
FROM `bellabeat-481518.bellabeat_clean.minute_MET`
GROUP BY id, activity_minute
HAVING COUNT(*) > 1;


# Checking for NULLs in key columns, no NULLs present

SELECT
  COUNTIF(id IS NULL) AS null_id,
  COUNTIF(activity_minute IS NULL) AS null_activity,
  COUNTIF(METs IS NULL) AS null_METs,
FROM `bellabeat-481518.bellabeat_clean.minute_MET`


# Checking for unrealistic values, all values are normal, based on hour/day. Also, analyzing if the 19:00 peak is consistent or if it shifts on specific days, i observed that the dataset is balanced and consistent across time slots. Between 06:00 and 09:00 there is a clear upward trend in metabolic effort, meaning users start their day around that time. At around 06:00 and 07:00, there are people close to the max_MET's of 13.8-14.00, suggesting a vigorous morning run or fast cycling.
# Besides the 19:00 peak, there is also a morning peak of 14.0 METs at around 7 o'clock, as a recommendation, send a gentle nudge like "Start your day with a 5-minute stretch to boost your energy!"

SELECT
  EXTRACT(HOUR FROM activity_minute) AS activity_hour,
  EXTRACT(DAYOFWEEK FROM activity_minute) AS day,
  MIN(METs) AS min_METs,
  AVG(METs) AS avg_METs,
  # APPROX_QUANTILES(METs, 2)[OFFSET(1)] AS median_METs,
  MAX(METs) AS max_METs,
  COUNT(METs) AS total_min_METs
FROM `bellabeat-481518.bellabeat_clean.minute_MET`
GROUP BY day, activity_hour
ORDER BY day, activity_hour ASC
