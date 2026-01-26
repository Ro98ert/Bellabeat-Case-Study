# I create a clean table with correct values and correct column names

CREATE OR REPLACE TABLE `bellabeat-481518.bellabeat_clean.weight_logs` AS
SELECT DISTINCT
  Id AS id,
  PARSE_TIMESTAMP('%m/%d/%Y %I:%M:%S %p', TRIM(Date)) AS date,
  WeightKg AS weight_kg,
  WeightPounds AS weight_pounds,
  BMI AS BMI,
  IsManualReport AS manual_report,
  LogId AS log_id
FROM `bellabeat-481518.bellabeat_raw.weight_logs`


# I compare raw table with clean table, observing users number is the same

SELECT
  'Clean Table' AS table_type,
  COUNT(*) AS total_rows,
  COUNT(DISTINCT id) AS users
FROM `bellabeat-481518.bellabeat_clean.weight_logs`
UNION ALL
SELECT
  'Raw Table' AS table_type,
  COUNT(*) AS total_rows,
  COUNT(DISTINCT id) AS users
FROM `bellabeat-481518.bellabeat_raw.weight_logs`


# I verify for duplicates if exists, no duplicates present

SELECT
  id,
  date,
  weight_kg,
  weight_pounds,
  BMI,
  manual_report,
  log_id,
  COUNT(*) AS duplicates
FROM `bellabeat-481518.bellabeat_clean.weight_logs`
GROUP BY id, date, weight_kg, weight_pounds, BMI, manual_report, log_id
HAVING COUNT(*) > 1;


# Checking for NULLs in key columns, observing 31 NULL values in fat measurement, so removed the column and kept only the relevant values

SELECT
  COUNTIF(id IS NULL) AS null_id,
  COUNTIF(date IS NULL) AS null_date,
  COUNTIF(weight_kg IS NULL) AS null_weight_kg,
  COUNTIF(weight_pounds IS NULL) AS null_weight_pounds,
# COUNTIF(fat IS NULL) AS null_fat,
  COUNTIF(BMI IS NULL) AS null_BMI,
  COUNTIF(manual_report IS NULL) AS null_manual_report,
  COUNTIF(log_id IS NULL) AS null_log_id,
FROM `bellabeat-481518.bellabeat_clean.weight_logs`


# Checking for unrealistic values, observing that there are normal values.

SELECT
  MIN(weight_kg) AS min_weight_kg,
  AVG(weight_kg) AS avg_weight_kg,
  MAX(weight_kg) AS max_weight_kg,
  COUNT(weight_kg) AS total_weight_kg,

  MIN(weight_pounds) AS min_weight_pounds,
  AVG(weight_pounds) AS avg_weight_pounds,
  MAX(weight_pounds) AS max_weight_pounds,
  COUNT(weight_pounds) AS total_weight_pounds,

  MIN(BMI) AS min_BMI,
  AVG(BMI) AS avg_BMI,
  MAX(BMI) AS max_BMI,
  COUNT(BMI) AS total_BMI
FROM `bellabeat-481518.bellabeat_clean.weight_logs`
