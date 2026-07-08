# I create a clean table with correct values and correct column names

CREATE OR REPLACE TABLE `bellabeat-481518.bellabeat_clean.hourly_calories` AS
SELECT DISTINCT
Id AS id,
PARSE_TIMESTAMP('%m/%d/%Y %I:%M:%S %p', TRIM(ActivityHour)) AS activity_hour,
Calories AS calories
FROM `bellabeat-481518.bellabeat_raw.hourly_calories`

# I compare raw table with clean table, observing users number is the same

SELECT
'Clean Table' AS table_type,
COUNT(*) AS total_rows,
COUNT(DISTINCT id) AS users
FROM `bellabeat-481518.bellabeat_clean.hourly_calories`
UNION ALL
SELECT
'Raw Table' AS table_type,
COUNT(*) AS total_rows,
COUNT(DISTINCT id) AS users
FROM `bellabeat-481518.bellabeat_raw.hourly_calories`

# I verify for duplicates if exists, no duplicates present

SELECT
id,
activity_hour,
COUNT(*) AS duplicates
FROM `bellabeat-481518.bellabeat_clean.hourly_calories`
GROUP BY id, activity_hour
HAVING COUNT(*) > 1;

# Checking for NULLs in key columns, no NULLs present

SELECT
COUNTIF(id IS NULL) AS null_id,
COUNTIF(activity_hour IS NULL) AS null_activity,
COUNTIF(calories IS NULL) AS null_calories
FROM `bellabeat-481518.bellabeat_clean.hourly_calories`

# Checking for unrealistic values, all values are normal

SELECT
MIN(calories) AS min_calories,
AVG(calories) AS avg_calories,
MAX(calories) AS max_calories
FROM `bellabeat-481518.bellabeat_clean.hourly_calories`
