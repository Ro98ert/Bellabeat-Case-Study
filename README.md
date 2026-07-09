# Bellabeat Smart Device Usage Analysis

## Project Summary

This project analyzes smart device usage data to identify behavioral patterns that could help inform Bellabeat's marketing strategy. The analysis focuses on activity, sleep, and heart rate trends using Fitbit data as a proxy for consumer wellness tracking behavior.

## Business Question

How do users engage with smart devices in their daily routines, and which patterns could help guide Bellabeat's product positioning and marketing decisions?

## Tools Used

- SQL (BigQuery): data cleaning, validation, transformation, and preprocessing
- R (Tidyverse): exploratory analysis, summary statistics, and visualization

## Workflow

This project uses a hybrid workflow. SQL was used to clean and standardize the raw datasets, and R was used to analyze trends and create visual outputs.

The workflow includes processing daily, hourly, minute-level, and heart rate data, standardizing timestamps and column names, filtering invalid or non-wear records, and exploring activity, sleep, and calorie patterns.

## Repository Contents

### 1. SQL Processing Scripts

**Location:** [`Analysis/Scripts/SQL/`](./Analysis/Scripts/SQL/)

These scripts prepare the raw Fitbit tables for analysis, including date and timestamp normalization, duplicate removal, non-wear filtering, and aggregation of second-level heart rate data.

Key files:
- [`01_process_daily_activity.sql`](./Analysis/Scripts/SQL/01_process_daily_activity.sql)
- [`02_process_heartrate_seconds.sql`](./Analysis/Scripts/SQL/02_process_heartrate_seconds.sql)
- [`03_process_hourly_calories.sql`](./Analysis/Scripts/SQL/03_process_hourly_calories.sql)
- [`04_process_hourly_intensities.sql`](./Analysis/Scripts/SQL/04_process_hourly_intensities.sql)
- [`05_process_hourly_steps.sql`](./Analysis/Scripts/SQL/05_process_hourly_steps.sql)
- [`06_process_minute_MET.sql`](./Analysis/Scripts/SQL/06_process_minute_MET.sql)
- [`07_process_minute_calories.sql`](./Analysis/Scripts/SQL/07_process_minute_calories.sql)
- [`08_process_minute_intensities.sql`](./Analysis/Scripts/SQL/08_process_minute_intensities.sql)
- [`09_process_minute_sleep.sql`](./Analysis/Scripts/SQL/09_process_minute_sleep.sql)
- [`10_process_minute_steps.sql`](./Analysis/Scripts/SQL/10_process_minute_steps.sql)
- [`11_process_weight_logs.sql`](./Analysis/Scripts/SQL/11_process_weight_logs.sql)

### 2. R Analysis Workflow

**Location:** [`Analysis/Scripts/R/`](./Analysis/Scripts/R/)

Main file: [`bellabeat_analysis_workflow.R`](./Analysis/Scripts/R/bellabeat_analysis_workflow.R)

This script includes exploratory data analysis, behavioral pattern analysis, activity and sleep comparisons, and chart creation for reporting.

### 3. Reports

**Location:** [`Reports/`](./Reports/)

Available reports:
- [`Bellabeat_Case_Study.pdf`](./Reports/Bellabeat_Case_Study.pdf)
- [`Bellabeat_Report.md`](./Reports/Bellabeat_Report.md)

## Key Findings

- Many users fall below the 10,000-step benchmark on a regular basis.
- Sedentary time represents a large share of daily tracked activity.
- Daily steps and calories burned show a strong positive relationship.
- Sleep duration appears relatively stable for many users.
- Sleep duration alone does not show a strong relationship with next-day activity.

## Data Source

Dataset: Fitbit Fitness Tracker Data (Kaggle)

The raw data files are not included in this repository. The analysis assumes the source files were loaded into a SQL environment before processing.

## Limitations

This project uses Fitbit data from a small public sample, not Bellabeat's own user base. The findings should be treated as directional insights rather than conclusions about Bellabeat customers specifically.

## Notes

AI tools were used selectively for brainstorming, editing, and improving documentation clarity. All analysis logic, SQL/R workflows, interpretation, and final conclusions were reviewed and validated by me.
