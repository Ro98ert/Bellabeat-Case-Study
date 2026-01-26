# Bellabeat Smart Device Usage Analysis 🏃‍♀️

## Project Overview
**Goal:** Analyze smart device usage data to identify trends and guide marketing strategies for Bellabeat, a high-tech wellness company for women.
**Role:** Data Analyst
**Status:** Complete

## ⚙️ Methodology: Hybrid Pipeline

This project leverages a **multi-tool workflow** to maximize efficiency and data integrity:

1.  **SQL (BigQuery):** Used for heavy lifting—data cleaning, strict schema validation, and timestamp normalization.
2.  **R (Tidyverse):** Used for exploratory data analysis (EDA), statistical summary, and visualization.

## 📂 Repository Structure

The code is organized to follow the data processing flow:

### 1. Data Processing (SQL)
Located in: `[path]`
* **Sequenced Scripts:** The SQL scripts are numbered (e.g., `01_process_daily_activity.sql`) to indicate the execution order.
* **Key Actions:**
    * Standardizing date/time formats across tables.
    * Removing nulls and non-wear days (zero calories).
    * Aggregating second-level heart rate data to minute-level.

### 2. Analysis & Visualization (R)
Located in: `[path]`
* **`bellabeat_workflow.R`**: A unified script that imports the cleaned SQL outputs to perform:
    * **Behavioral Segmentation:** Categorizing users by activity levels.
    * **Correlation Analysis:** Steps vs. Calories, Sleep vs. Activity.
    * **Temporal Trends:** Activity patterns by day of the week.

## 📊 Final Reports

The full narrative, including charts and strategic recommendations, can be found here:

* 📄 **Executive Report (PDF):** [path]
* 📝 **Analysis Log (Markdown):** [path]

---

### Data Source
* **Dataset:** [Fitbit Fitness Tracker Data (Kaggle)](https://www.kaggle.com/arashnic/fitbit)
* *Note: Original raw data files are not included in this repository due to size constraints. The analysis assumes raw data was loaded into a SQL environment.*
