############################################################
# Bellabeat Case Study: How can a wellness technology company play it smart?
# Author: Robert Amartisoaei
# Date: Sys.Date()
# Purpose: Full analysis following the Google Data Analytics case study steps
############################################################

# ----------------------------
# Packages
# ----------------------------
packages <- c("tidyverse", "janitor", "skimr", "naniar", "lubridate")

installed <- rownames(installed.packages())
for (p in packages) {
  if (!p %in% installed) install.packages(p)
}

library(tidyverse)
library(janitor)
library(lubridate)
library(skimr)
library(naniar)

# ----------------------------
# Data path (Desktop)
# ----------------------------
data_path <- "E:/Docs/Coursera/Case Study 2_ How-can-a-wellness-technology-company-play-it-smart/R_Project_local/Bellabeat/data_clean/SQL"

# ----------------------------
# Import data
# ----------------------------
daily_activity      <- read_csv(file.path(data_path, "daily_activity.csv"))
minute_sleep        <- read_csv(file.path(data_path, "minute_sleep.csv"))
weight_log          <- read_csv(file.path(data_path, "weight_logs.csv"))

hourly_calories     <- read_csv(file.path(data_path, "hourly_calories.csv"))
hourly_intensities  <- read_csv(file.path(data_path, "hourly_intensities.csv"))
hourly_steps        <- read_csv(file.path(data_path, "hourly_steps.csv"))

minute_calories     <- read_csv(file.path(data_path, "minute_calories.csv"))
minute_intensities  <- read_csv(file.path(data_path, "minute_intensities.csv"))
minute_mets         <- read_csv(file.path(data_path, "minute_MET.csv"))
minute_steps        <- read_csv(file.path(data_path, "minute_steps.csv"))

heartrate_seconds   <- read_csv(file.path(data_path, "heartrate_seconds.csv"))

# ----------------------------
# Initial inspection
# ----------------------------
glimpse(daily_activity)
glimpse(minute_sleep)
glimpse(weight_log)
glimpse(hourly_steps)
glimpse(minute_steps)
glimpse(heartrate_seconds)

# ----------------------------
# User counts
# ----------------------------
n_users_daily  <- n_distinct(daily_activity$id)
n_users_sleep  <- n_distinct(minute_sleep$id)
n_users_weight <- n_distinct(weight_log$id)
n_users_hr     <- n_distinct(heartrate_seconds$id)

# ----------------------------
# SUMMARY TABLE (DO NOT overwrite dataset)
# ----------------------------
daily_summary <- daily_activity %>% 
  summarise(
    users = n_distinct(id),
    avg_steps = mean(total_steps),
    median_steps = median(total_steps),
    avg_active_minutes = mean(very_active_minutes),
    avg_sedentary = mean(sedentary_minutes),
    avg_calories = mean(calories)
  )

# ==========================================================
# ANALYSIS PHASE
# ==========================================================

# Steps summary
daily_steps_summary <- daily_activity %>% 
  summarise(
    days = n(),
    users = n_distinct(id),
    mean_steps = mean(total_steps),
    median_steps = median(total_steps),
    min_steps = min(total_steps),
    max_steps = max(total_steps)
  )

# Distribution of steps
ggplot(daily_activity, aes(total_steps)) +
  geom_histogram(binwidth = 2000) +
  labs(
    title = "Distribution of Daily Steps",
    x = "Total Steps",
    y = "Number of Days"
  )

# Steps vs calories
ggplot(daily_activity, aes(total_steps, calories)) +
  geom_point(alpha = 0.4) +
  geom_smooth(method = "lm") +
  labs(
    title = "Daily Steps vs Calories",
    x = "Total Steps",
    y = "Calories"
  )

# Activity minutes
activity_minutes_long <- daily_activity %>% 
  select(
    very_active_minutes,
    fairly_active_minutes,
    lightly_active_minutes,
    sedentary_minutes
  ) %>% 
  pivot_longer(
    everything(),
    names_to = "activity_type",
    values_to = "minutes"
  )

ggplot(activity_minutes_long, aes(activity_type, minutes)) +
  stat_summary(fun = "mean", geom = "bar") +
  labs(
    title = "Average Daily Minutes by Activity Type",
    x = "Activity Type",
    y = "Minutes"
  )

# Weekday analysis
daily_activity <- daily_activity %>% 
  mutate(weekday = wday(activity_date, label = TRUE))

steps_by_weekday <- daily_activity %>% 
  group_by(weekday) %>% 
  summarise(avg_steps = mean(total_steps), .groups = "drop")

ggplot(steps_by_weekday, aes(weekday, avg_steps, group = 1)) +
  geom_line() +
  geom_point() +
  labs(
    title = "Average Daily Steps by Weekday",
    x = "Weekday",
    y = "Average Steps"
  )

# Sleep analysis
sleep_daily <- minute_sleep %>% 
  mutate(sleep_date = as_date(sleep_time)) %>% 
  group_by(id, sleep_date) %>% 
  summarise(minutes_asleep = n(), .groups = "drop")

ggplot(sleep_daily, aes(minutes_asleep)) +
  geom_histogram(binwidth = 330) +
  labs(
    title = "Distribution of Sleep Duration",
    x = "Minutes Asleep",
    y = "Nights"
  )

# Sleep vs activity
daily_activity_sleep <- daily_activity %>% 
  rename(sleep_date = activity_date) %>% 
  inner_join(sleep_daily, by = c("id", "sleep_date"))

ggplot(daily_activity_sleep, aes(minutes_asleep, total_steps)) +
  geom_point(alpha = 0.4) +
  geom_smooth(method = "lm") +
  labs(
    title = "Sleep Duration vs Daily Steps",
    x = "Minutes Asleep",
    y = "Total Steps"
  )

# Activity levels
daily_activity <- daily_activity %>% 
  mutate(
    activity_level = case_when(
      total_steps < 4000 ~ "Low",
      total_steps < 7000 ~ "Moderate",
      TRUE ~ "High"
    )
  )

activity_level_counts <- daily_activity %>% 
  count(activity_level)

ggplot(activity_level_counts, aes(activity_level, n)) +
  geom_col() +
  labs(
    title = "Days by Activity Level",
    x = "Activity Level",
    y = "Days"
  )

# Heart rate distribution
ggplot(heartrate_seconds, aes(heart_rate)) +
  geom_histogram(binwidth = 5) +
  labs(
    title = "Heart Rate Distribution",
    x = "Heart Rate (bpm)",
    y = "Count"
  )
