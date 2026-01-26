# Bellabeat Case Study: Smart Device Usage Analysis 🏃‍♀️
**Author:** Amartisoaei Robert
**Date:** 2026-01-26

## 1. Introduction

This case study analyzes smart-device usage data to support **Bellabeat**, a wellness technology company that designs health-focused products for women. The goal of this project is to explore how users engage with their activity trackers and identify behavioral patterns that can inform Bellabeat’s product development and marketing strategy.

By examining activity, sleep, and heart-rate data from Fitbit users, I aim to uncover meaningful insights about daily habits, wellness routines, and opportunities for Bellabeat to help users improve their overall health.

This analysis follows the standard analytics process: **Ask, Prepare, Process, Analyze, Share, and Act**.

---

## 2. Ask

### Business Task
**Bellabeat's goal** is to grow as efficiently as possible in the global smart device market by offering products and services tailored to customer needs.

To support this goal, I analyzed smart device usage data to understand how consumers use their devices in their daily lives. The insights from this analysis help the marketing team design targeted strategies for Bellabeat’s products and services based on users’ behavior patterns.

### Key Stakeholders
* **Urška Sršen** – Cofounder and Chief Creative Officer
* **Sando Mur** – Cofounder and key member of the executive team
* **Bellabeat Marketing Analytics Team** – Responsible for data-driven strategic recommendations

---

## 3. Prepare

### Data Source
The dataset used for this analysis is the **Fitbit Fitness Tracker Data**, a public dataset published on Kaggle. It contains personal fitness tracker information from **30 consenting Fitbit users**, including daily and minute-level data regarding physical activity, sleep, and heart rate.

> **Note:** This dataset serves as a **proxy** to understand general smart device usage patterns among users similar to Bellabeat’s target audience.

### Data Structure
The analysis focuses on the following tables, linked by the unique `Id` column:
* **Daily Data:** `daily_activity` (Steps, intensity, calories)
* **Sleep Data:** `minute_sleep` (Sleep logs)
* **Weight Data:** `weight_log` (Weight and BMI)
* **Hourly Data:** `hourly_steps`, `hourly_calories`, `hourly_intensities`
* **Minute/Second Data:** `heartrate_seconds`, `minute_steps`, etc.

### ROCCC Assessment
| Criterion | Status | Assessment |
| :--- | :--- | :--- |
| **Reliable** | Medium | Data is machine-generated (Fitbit), so it is accurate, but the sample size (30 users) is small. |
| **Original** | Low | Third-party dataset (Kaggle), not collected directly by Bellabeat. |
| **Comprehensive** | Medium | Includes deep activity/sleep/heart metrics, but lacks demographic data (age, gender). |
| **Current** | Low | Data is several years old; usage habits may have evolved. |
| **Cited** | High | Properly cited as “Fitbit Fitness Tracker Data” on Kaggle. |

---

## 4. Process

**Tool Selection:**
* **SQL (BigQuery):** Used for data extraction, cleaning, and strict schema validation due to the dataset's size.
* **R (Tidyverse):** Used for the subsequent Exploratory Data Analysis (EDA) and visualization phases.

### Data Cleaning Log
The following processing steps were executed to resolve data quality issues identified during the "Prepare" phase.

#### A. Daily Level Data & Feature Selection
* **Logic:** Filtered out records where `Calories = 0` (indicating the device was not worn) and excluded the `Fat` column due to excessive null values.
* **Standardization:** Converted CamelCase headers to snake_case.

```sql
/* CLEANING SAMPLE: DAILY ACTIVITY */
CREATE OR REPLACE TABLE `bellabeat_clean.daily_activity` AS
SELECT
  Id AS id,
  ActivityDate AS activity_date,
  TotalSteps AS total_steps,
  Calories AS calories
FROM `bellabeat_raw.daily_activity`
WHERE Calories > 0;
