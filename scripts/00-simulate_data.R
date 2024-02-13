#### Preamble ####
# Purpose: Simulates the data tables shown in the other/sketches/datasets.pdf. There are 3 tables simulated here as mentioned below.
# Author: Aryaman Sharma
# Date: 13 February 2024
# Contact: aryaman.sharma@mail.utoronto.ca
# License: MIT
# Pre-requisites: None
# Any other information needed?: Run this script to get an idea of how the data tables will look like.


#### Workspace setup ####
library(tidyverse)
library(janitor)
library(countries) # read documentation: https://cran.r-project.org/web/packages/countries/readme/README.html#:~:text=countries%20is%20an%20R%20package,and%20easily%20make%20world%20maps.

#### Simulate data ####
# We set the seed here to help make this script reproducible
set.seed(43)

# This piece of code generates a table that contains GHS indicies for each of the 195 countries in the world
simulated_country_ghs_data <- 
  tibble(
    "Country Name" = random_countries(195),
    "GHS Index" = runif(n = 195, min = 16, max = 76)
  )

# This piece of code generates a table that contains all cause death rates for 4 countries between 2010 and 2021
simulated_all_cause_death_rate_data <-
  tibble(
    "Country Name" = random_countries(4),
    "2010" = runif(n = 4, min = 4, max = 20),
    "2011" = runif(n = 4, min = 4, max = 20),
    "2012" = runif(n = 4, min = 4, max = 20),
    "2013" = runif(n = 4, min = 4, max = 20),
    "2014" = runif(n = 4, min = 4, max = 20),
    "2015" = runif(n = 4, min = 4, max = 20),
    "2016" = runif(n = 4, min = 4, max = 20),
    "2017" = runif(n = 4, min = 4, max = 20),
    "2018" = runif(n = 4, min = 4, max = 20),
    "2019" = runif(n = 4, min = 4, max = 20),
    "2020" = runif(n = 4, min = 4, max = 20),
    "2021" = runif(n = 4, min = 4, max = 20),
  )

# This piece of code generates a table that contains the excess death rate and GHS index for a subset of 16 countries
simulated_excess_death_rate_ghs_data <-
  tibble(
    "Country Name" = random_countries(16),
    "Excess Death Rate" = runif(n = 16, min = -100, max = 300),
    "GHS Index" = runif(n = 16, min = 16, max = 76)
  )

