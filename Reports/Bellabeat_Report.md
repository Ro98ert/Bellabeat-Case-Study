# Bellabeat Smart Device Usage Analysis

## Project Overview
This case study analyzes smart device usage data to explore how consumers interact with fitness trackers in their daily lives. The goal is to identify behavioral patterns related to activity, sleep, and heart rate that could help inform Bellabeat’s product and marketing strategy.

## 1. Business Task
Bellabeat wants to better understand how people use smart wellness devices in everyday life. This analysis aims to identify usage patterns that could support data-informed marketing recommendations.

## 2. Data Source
The dataset used for this analysis is the **Fitbit Fitness Tracker Data**, a public dataset published on Kaggle by Mobius. It contains activity, sleep, and heart-rate data from **30 consenting Fitbit users**.

This dataset is used as a proxy for general smart device behavior. It is not Bellabeat’s own customer data.

Main tables used in this project include:
- daily activity data
- sleep logs
- weight logs
- hourly activity tables
- minute-level activity tables
- second-level heart-rate data

## 3. Data Preparation
The project used **SQL (BigQuery)** for cleaning and transformation, and **R (Tidyverse)** for analysis and visualization.

Main preparation steps:
- standardized column names into a consistent format
- filtered out invalid or non-wear records such as zero-calorie days
- removed duplicates from granular activity tables
- parsed inconsistent date and time fields into standard timestamp formats
- converted minute-level MET values to usable units
- aggregated second-level heart-rate data to the minute level for easier analysis

These steps produced cleaned and consistent datasets ready for exploratory analysis.

## 4. Analysis Approach
The analysis focused on several key questions:
1. How active are users on a typical day?
2. How much time do users spend in sedentary versus active states?
3. What is the relationship between steps and calories burned?
4. Are there visible trends across days of the week?
5. How does sleep relate to next-day activity?

To answer these questions, I used:
- distribution analysis
- correlation analysis
- weekday trend analysis
- sleep and activity comparisons

## 5. Key Findings

### Daily Activity
A large share of users did not consistently reach the 10,000-step benchmark. The distribution of daily steps suggests that activity levels vary widely, but lower-activity days are common.

### Sedentary Time
Users spent a substantial portion of their day in sedentary minutes, with relatively little time in higher activity categories. This suggests that inactivity is an important behavioral pattern in the dataset.

### Steps and Calories
Daily steps and calories burned showed a strong positive relationship. This supports the use of steps as a practical and easy-to-understand activity metric.

### Weekly Patterns
Activity levels were generally similar across the week, although some day-level fluctuations may reflect logging inconsistencies rather than meaningful behavioral differences.

### Sleep Patterns
Many recorded sleep sessions fell within a typical 7 to 8.5 hour range. However, there was no strong relationship between sleep duration and next-day step count in this analysis.

## 6. Recommendations
Based on the patterns observed in this dataset, the following recommendations could be explored for Bellabeat:

1. **Promote movement through small, achievable goals**  
   Since many users appear to be lightly active or sedentary, Bellabeat could emphasize simple daily movement goals rather than high-performance fitness messaging.

2. **Use inactivity alerts or movement reminders**  
   Long sedentary periods suggest an opportunity for app notifications or device features that encourage short breaks and light movement.

3. **Keep sleep and activity as separate wellness pillars**  
   Because sleep duration did not show a strong link with next-day activity, Bellabeat may benefit from treating sleep support and movement support as separate behavior areas.

4. **Highlight steps as a simple health metric**  
   The positive relationship between steps and calories supports clear step-based messaging for users who want a practical and accessible measure of activity.

## 7. Limitations
This case study has several limitations:
- the dataset includes only 30 users
- the data is not collected directly from Bellabeat users
- the dataset lacks demographic detail needed to match Bellabeat’s target audience more closely
- the data is older and may not fully reflect current wearable usage behavior

These limitations mean the results should be treated as exploratory rather than broadly representative.

## 8. Future Work
Possible next steps include:
- validating the findings with Bellabeat-specific or more recent data
- analyzing longer time periods to identify seasonal patterns
- combining usage data with survey feedback to better understand user motivation
- testing whether certain reminder types are more effective for low-activity users