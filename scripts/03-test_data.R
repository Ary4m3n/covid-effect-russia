#### Preamble ####
# Purpose: Tests for the cleaned dataset to check if the requirements match that of the simulated data.
# Author: Aryaman Sharma
# Date: 13 February 2024
# Contact: aryaman.sharma@mail.utoronto.ca
# License: MIT
# Pre-requisites: Kindly run 00-simulate_data.R and 02-data_cleaning.R before running this file.


#### Workspace setup ####
library(tidyverse)

#### Test data ####
# Let us first work on the GHS Index data for each country
test_ghs_index_data_2021 <- read_csv("data/analysis_data/cleaned_GHS_index.csv", show_col_types = FALSE)
# First Test is to check if there are 195 countries in total here
test_ghs_index_data_2021$country |>
  length() == 195
# Second Test is the check if all the GHS index values are non-negative
test_ghs_index_data_2021$overall_score |>
  min() >= 0
# Third Test is to check if the country column is of class "character"
test_ghs_index_data_2021$country |>
  class() == "character"
# Fourth Test is to check if the ghs index column is of class "numeric"
test_ghs_index_data_2021$overall_score |>
  class() == "numeric"

# Let us now work on the all cause death data for 4 countries for 2010-2021
test_deaths_data <- read_csv("data/analysis_data/cleaned_all_cause_dth_rates.csv", show_col_types = FALSE)
# First Test is to check if there are 4 countries being analysed
test_deaths_data$country_name |>
  length() == 4
# Second Test is to check if the country column is of class "character"
test_deaths_data$country_name |>
  class() == "character"
# Third Test is a set of tests to check if the all cause death rate for 2010-2021 is non-negative
test_deaths_data$`2010` |>
  min() >= 0
test_deaths_data$`2011` |>
  min() >= 0
test_deaths_data$`2012` |>
  min() >= 0
test_deaths_data$`2013` |>
  min() >= 0
test_deaths_data$`2014` |>
  min() >= 0
test_deaths_data$`2015` |>
  min() >= 0
test_deaths_data$`2016` |>
  min() >= 0
test_deaths_data$`2017` |>
  min() >= 0
test_deaths_data$`2018` |>
  min() >= 0
test_deaths_data$`2019` |>
  min() >= 0
test_deaths_data$`2020` |>
  min() >= 0
test_deaths_data$`2021` |>
  min() >= 0
# Fourth Test is a set of tests to check if all the columns 2010-2021 are of class "numeric"
test_deaths_data$`2010` |>
  class() == "numeric"
test_deaths_data$`2011` |>
  class() == "numeric"
test_deaths_data$`2012` |>
  class() == "numeric"
test_deaths_data$`2013` |>
  class() == "numeric"
test_deaths_data$`2014` |>
  class() == "numeric"
test_deaths_data$`2015` |>
  class() == "numeric"
test_deaths_data$`2016` |>
  class() == "numeric"
test_deaths_data$`2017` |>
  class() == "numeric"
test_deaths_data$`2018` |>
  class() == "numeric"
test_deaths_data$`2019` |>
  class() == "numeric"
test_deaths_data$`2020` |>
  class() == "numeric"
test_deaths_data$`2021` |>
  class() == "numeric"

# Let us now work on the data containing the excess death rate and GHS index for a subset of 16 countries
test_combined_data <- read_csv("data/analysis_data/cleaned_excess_death_ghs.csv", show_col_types = FALSE)
# First test to check if there are 16 countries in total here
test_combined_data$country |>
  length() == 16
# Second test is to check if the country column is of class character
test_combined_data$country |>
  class() == "character"
# Third test is to check if the excess death rate column is of class numeric
test_combined_data$excess_death_rate |>
  class() == "numeric"
# Fourth test is to check if the ghs index column is non-negative
test_combined_data$ghs_index |>
  min() >= 0
# Final test is to check if the ghs index column is of class numeric
test_combined_data$ghs_index |>
  class() == "numeric"

