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
-- CLEANING SAMPLE: DAILY ACTIVITY
CREATE OR REPLACE TABLE `bellabeat_clean.daily_activity` AS
SELECT
  Id AS id,
  ActivityDate AS activity_date,
  TotalSteps AS total_steps,
  Calories AS calories
FROM `bellabeat_raw.daily_activity`
WHERE Calories > 0;
```

#### B. Timestamp Parsing
* **Logic:** Applied parsing functions to correct formatting inconsistencies in raw string dates across hourly and minute-level tables.

```sql
-- CLEANING SAMPLE: TIMESTAMP PARSING
CREATE OR REPLACE TABLE `bellabeat_clean.hourly_steps` AS
SELECT DISTINCT
  Id AS id,
  PARSE_TIMESTAMP('%m/%d/%Y %I:%M:%S %p', TRIM(ActivityHour)) AS activity_hour,
  StepTotal AS total_steps
FROM `bellabeat_raw.hourly_steps`;
```

## 4. Analyze

In this phase, I explored user behavior regarding activity, calories, sleep, and heart rate.

#### 1. Overview of Daily Activity

First, I examined the distribution of daily steps to understand the baseline activity level of the user base.

[image] Figure 1: Distribution of Daily Steps vs. the 10k Goal

**Insights:**

The distribution is right-skewed. While some users achieve high activity, a significant portion falls below the 10,000-step recommendation, indicating a potential market for motivation-based features.

#### 2. Activity Intensity: Sedentary vs Active
To understand how users spend their day, I analyzed the breakdown of activity intensity categories.

[image] Figure 2: Average Minutes Spent in Each Activity Category

**Insights:**

Users are predominantly sedentary. This highlights a massive opportunity for Bellabeat to introduce "movement breaks" or inactivity alerts.

#### 3. Calorie Burn vs Step Count
I analyzed the correlation between steps taken and calories burned to confirm the efficacy of step-based goals.

[image] Figure 3: Linear Relationship between Daily Steps and Calories

**Insights:**

There is a strong positive correlation. This confirms that step-counting is a reliable proxy for calorie expenditure in marketing messaging.

#### 4. Weekly Activity Habits
Do users slack off on weekends? I visualized activity trends across the week.

[image] Figure 4: Average Steps by Day of the Week

**Insights:**

Activity is relatively consistent, though Tuesday shows a suspicious dip (likely a data syncing issue identified in the cleaning phase) rather than user behavior.

#### 5. Sleep Analysis
I examined sleep duration to see if users are meeting the recommended 7-9 hours (420-540 mins).

[image] Figure 5: Distribution of Nightly Sleep Duration

**Insights:**

The distribution of sleep duration is centered slightly above the 7-hour mark, suggesting that for the majority of recorded nights, users are achieving a healthy amount of sleep.

#### 6. Sleep vs Activity
Does sleeping more lead to more activity the next day?

[image] Figure 6: Correlation between Sleep Duration and Next Day Steps

**Insights:**

The relationship is weak (flat trend line). This suggests that simply sleeping more doesn't automatically result in more movement; users need separate nudges for both behaviors.

#### 6. Share & Act
**Key Findings**
Based on the analysis, I have identified six key trends:

Sedentary Lifestyles Prevail: Most days fall into the "Sedentary" or "Lightly Active" categories.

Steps Drive Calories: A strong correlation confirms step counts are a valid metric for weight management.

High Sedentary Time: Users spend a disproportionate amount of waking hours inactive.

Sleep is Consistent: Users generally meet the 7-8 hour sleep benchmark.

Sleep != Activity: Rest alone does not motivate movement.

Data Gaps: Technical syncing issues (e.g., Tuesday dips) affect data continuity.

Recommendations
📱 Product Features
"Sedentary Nudges": Implement smart alerts that trigger after 60 minutes of inactivity.

Daily Wellness Score: Develop a composite metric (Steps + Sleep + Active Minutes) to give a holistic view of health.

Sleep Coaching: Introduce a "Sleep Hygiene" module to maintain the existing good habits.

📣 Marketing Strategy
Campaign: "Small Steps, Big Impact": Focus messaging on hitting the 10k mark through casual walking.

Campaign: "Rest to Recharge": Position Bellabeat devices as "Rest Managers" for the wellness-focused woman.
