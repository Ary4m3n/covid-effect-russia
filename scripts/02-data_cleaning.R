#### Preamble ####
# Purpose: Cleans the raw data obtained from Nuzzo and Ledesma's paper and saves it to the directory "data/analysis_data"
# Author: Aryaman Sharma, Aviral Bhardwaj, Janel Gilani
# Date: 10 February 2024
# Contact: aryaman.sharma@mail.utoronto.ca
# License: MIT
# Pre-requisites: None
# Any other information needed?

#### Workspace setup ####
library(ggplot2)
library(tidyverse)
library(janitor)
library(readxl)
library(dplyr)
library(rnaturalearth)
library(sf)

#### Clean data ####

# File 1: GHS_index.xlsx
ghs_index_data <- read_excel("data/raw_data/GHS_index.xlsx")

cleaned_ghs_index_data <- ghs_index_data |>
  clean_names()|>
  select(
    `country`,
    `year`,
    `overall_score`
  )

cleaned_ghs_index_data$country[cleaned_ghs_index_data$country == "Russian Federation"] <- "Russia"
cleaned_ghs_index_data$country[cleaned_ghs_index_data$country == "Bosnia and Herzegovina"] <- "Bosnia"
cleaned_ghs_index_data$country[cleaned_ghs_index_data$country == "Bolivia (Plurinational State of)"] <- "Bolivia"
cleaned_ghs_index_data$country[cleaned_ghs_index_data$country == "Venezuela (Bolivarian Republic of)"] <- "Venezuela"
cleaned_ghs_index_data$country[cleaned_ghs_index_data$country == "Iran (Islamic Republic of)"] <- "Iran"
cleaned_ghs_index_data$country[cleaned_ghs_index_data$country == "CÃ´te d'Ivoire"] <- "Côte d'Ivoire"
cleaned_ghs_index_data$country[cleaned_ghs_index_data$country == "Democratic Republic of the Congo"] <- "Dem. Rep. Congo"
cleaned_ghs_index_data$country[cleaned_ghs_index_data$country == "South Sudan"] <- "S. Sudan"
cleaned_ghs_index_data$country[cleaned_ghs_index_data$country == "United Republic of Tanzania"] <- "Tanzania"
cleaned_ghs_index_data$country[cleaned_ghs_index_data$country == "Central African Republic"] <- "Central African Rep."

cleaned_ghs_index_data_2021 <- cleaned_ghs_index_data |>
  filter(year == 2021) |>
  select(
    `country`,
    `overall_score`
  )
write_csv(cleaned_ghs_index_data_2021, "data/analysis_data/cleaned_GHS_index.csv")

# File 2: life_table.csv

life_expectancy_data <- read_csv("data/raw_data/life_table.csv")

cleaned_life_expectancy_data <- life_expectancy_data |>
  clean_names() |>
  select(
    year_id,
    all,
    hispanic,
    non_hispanic_black,
    non_hispanic_white,
  ) |>
  rename(
    Year = year_id,
    `All Races` = all,
    Hispanic = hispanic,
    Black = non_hispanic_black,
    White = non_hispanic_white
  )
write_csv(cleaned_life_expectancy_data, "data/analysis_data/cleaned_life_table.csv")

cleaned_life_expectancy_data_all_races <- life_expectancy_data |>
  clean_names() |>
  select(
    year_id,
    all,
    hispanic,
    non_hispanic_aian,
    non_hispanic_asian,
    non_hispanic_black,
    non_hispanic_white,
  ) |>
  rename(
    Year = year_id,
    `All Races` = all,
    Hispanic = hispanic,
    AIAN = non_hispanic_aian,
    Asian = non_hispanic_asian,
    Black = non_hispanic_black,
    White = non_hispanic_white
  )
write_csv(cleaned_life_expectancy_data_all_races, "data/analysis_data/cleaned_life_table_all_races.csv")

# File 3: all_cause_dth_rates.csv

deaths_data <- read_csv("data/raw_data/all_cause_dth_rates.csv")

cleaned_deaths_data_rep <- deaths_data |>
  clean_names() |>
  select(
    country_name,
    `x2013`,
    `x2014`,
    `x2015`,
    `x2016`,
    `x2017`,
    `x2018`,
    `x2019`,
    `x2020`,
    `x2021`
  ) |>
  filter(country_name %in% c("Germany", "United Kingdom", "United States", "New Zealand", "Australia", "Korea, Rep.")) |>
  rename(
    `2013` = `x2013`,
    `2014` = `x2014`,
    `2015` = `x2015`,
    `2016` = `x2016`,
    `2017` = `x2017`,
    `2018` = `x2018`,
    `2019` = `x2019`,
    `2020` = `x2020`,
    `2021` = `x2021`
  )
write_csv(cleaned_deaths_data_rep, "data/analysis_data/cleaned_all_cause_dth_rates_rep.csv")

cleaned_deaths_data <- deaths_data |>
  clean_names() |>
  select(
    country_name,
    `x2010`,
    `x2011`,
    `x2012`,
    `x2013`,
    `x2014`,
    `x2015`,
    `x2016`,
    `x2017`,
    `x2018`,
    `x2019`,
    `x2020`,
    `x2021`
  ) |>
  filter(country_name %in% c("India", "United States", "Russian Federation", "Korea, Rep.")) |>
  rename(
    `2010` = `x2010`,
    `2011` = `x2011`,
    `2012` = `x2012`,
    `2013` = `x2013`,
    `2014` = `x2014`,
    `2015` = `x2015`,
    `2016` = `x2016`,
    `2017` = `x2017`,
    `2018` = `x2018`,
    `2019` = `x2019`,
    `2020` = `x2020`,
    `2021` = `x2021`
  )

write_csv(cleaned_deaths_data, "data/analysis_data/cleaned_all_cause_dth_rates.csv")

# File 4: IHME_excess_deaths.csv and GHS_index.xlsx combined

ihme_excess_deaths_data <- read_csv("data/raw_data/IHME_excess_deaths.csv")

cleaned_ihme_excess_deaths_data <- ihme_excess_deaths_data |>
  clean_names() |>
  select(
    location_name,
    measure_name,
    mean_value
  ) |>
  filter(measure_name == "excess_death_rate") |>
  select(
    location_name,
    mean_value
  ) |>
  rename(
    country = location_name,
    excess_death_rate = mean_value
  ) |>
  filter(country %in% c("India", "USA", "Russia", "UK", "Australia", "Canada", "Netherlands", "Spain", "France", "Japan", "Denmark", "Germany", "Austria", "Brazil", "Hungary", "Indonesia"))

cleaned_ghs <- ghs_index_data |>
  clean_names() |>
  select(
    `country`,
    `year`,
    `overall_score`
  ) |>
  filter(year == 2021) |>
  rename(
    ghs_index = overall_score
  ) |>
  filter(country %in% c("India", "United States of America", "Russian Federation", "United Kingdom", "South Korea", "Australia", "Canada", "Netherlands", "Spain", "France", "Japan", "Denmark", "Germany", "Austria", "Brazil", "Hungary", "Indonesia")) |>
  select(
    `country`,
    `ghs_index`
  )

cleaned_ghs$country[cleaned_ghs$country == "Russian Federation"] <- "Russia"
cleaned_ghs$country[cleaned_ghs$country == "United States of America"] <- "USA"
cleaned_ghs$country[cleaned_ghs$country == "United Kingdom"] <- "UK"

combined_data <- merge(cleaned_ihme_excess_deaths_data, cleaned_ghs, by = "country", all = TRUE)

write_csv(combined_data, "data/analysis_data/cleaned_excess_death_ghs.csv")

