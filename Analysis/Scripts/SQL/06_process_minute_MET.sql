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
COUNTIF(METs IS NULL) AS null_METs
FROM `bellabeat-481518.bellabeat_clean.minute_MET`

# Checking for unrealistic values by hour and day of week. Activity ramps up between 06:00 and 09:00, with a secondary peak around 19:00. Values stay within a normal range (max ~13.8-14.0 METs).

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
