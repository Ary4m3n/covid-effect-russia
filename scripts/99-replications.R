#### Preamble ####
# Purpose: Replicated graphs from Nuzzo and Ledesma's paper provided in "other/literature"
# Author: Aryaman Sharma
# Date: 10 February 2024
# Contact: aryaman.sharma@mail.utoronto.ca
# License: MIT
# Pre-requisites: Run 02-data_cleaning.R before running this script.
# Any other information needed?: This script will produce 5 graphs in total, which is Figure 1, Figure 2a, Figure 2b, Figure 3a and Figure 3b of Nuzzo and Ledesma's paper


#### Workspace setup ####
library(ggplot2)
library(tidyverse)
library(janitor)
library(dplyr)
library(rnaturalearth)
library(sf)

#### Load data ####

# Figure 1
cleaned_ghs_index_data_2021 <- read_csv("data/analysis_data/cleaned_GHS_index.csv")

world <- ne_countries(scale = "medium", returnclass = "sf")

world_scores <- merge(world, cleaned_ghs_index_data_2021, by.x = "name", by.y = "country", all.x = TRUE)

world_scores$score_factor <- cut(
  world_scores$overall_score, 
  breaks = c(16, 25, 30, 35, 40, 45, 50, 60, 70, 76), 
  labels = c("16 to 25", "25 to 30", "30 to 35", "35 to 40", "40 to 45", "45 to 50", "50 to 60", "60 to 70", "70 to 76"), 
  include.lowest = TRUE)
world_scores

ggplot(data = world_scores) +
  geom_sf(aes(fill = score_factor), color = "white") +
  scale_fill_manual(values = c("#990000", "#CC3333", "#FF6666", "#FF9966", "#FFCC99", "#99CCFF", "#6699CC", "#336699", "#003399")) +
  labs(fill = "Global health security score", title = "Global Health Security Score (2021)") +
  theme_minimal()

# Figure 2 (Part A)
cleaned_life_expectancy_data <- read_csv("data/analysis_data/cleaned_life_table.csv")

cleaned_life_expectancy_data_long <- pivot_longer(cleaned_life_expectancy_data, cols = -Year, names_to = "Race", values_to = "Value")

ggplot(cleaned_life_expectancy_data_long, aes(x = Year, y = Value, color = Race)) +
  geom_line() +
  geom_point() +
  theme_classic() +
  scale_y_continuous(breaks = 65:85) +
  scale_x_continuous(breaks = 2006:2021) +
  labs(title = "Life Expectancy by Race", x = "Year", y = "Life Expectancy") +
  scale_color_brewer(palette = "Set1")

# Figure 2 (Part B)
cleaned_life_expectancy_data_all_races <- read_csv("data/analysis_data/cleaned_life_table_all_races.csv")

cleaned_life_expectancy_data_all_races_short <- cleaned_life_expectancy_data_all_races |>
  filter(Year >= 2019)

change_in_life_expectancy <- cleaned_life_expectancy_data_all_races_short |>
  summarise(
    Period = c("2019-2020", "2020-2021"),
    `All Races` = c(`All Races`[2] - `All Races`[1], `All Races`[3] - `All Races`[2]),
    Hispanic = c(Hispanic[2] - Hispanic[1], Hispanic[3] - Hispanic[2]),
    `American Indians and Alaska Native` = c(AIAN[2] - AIAN[1], AIAN[3] - AIAN[2]),
    Asian = c(Asian[2] - Asian[1], Asian[3] - Asian[2]),
    Black = c(Black[2] - Black[1], Black[3] - Black[2]),
    White = c(White[2] - White[1], White[3] - White[2])
  )

cleaned_life_expectancy_data_all_races_long <- pivot_longer(change_in_life_expectancy, cols = -Period, names_to = "Category", values_to = "Difference")

ggplot(cleaned_life_expectancy_data_all_races_long, aes(x = Category, y = Difference, fill = Period)) +
  geom_bar(stat = "identity", position = position_dodge(width = 0.9)) +
  theme_minimal() +
  labs(title = "Yearly Differences in Life Expectancy by Category",
       x = "Period",
       y = "Difference in Life Expectancy") +
  scale_fill_brewer(palette = "Set2") +
  theme(axis.text.x = element_text(angle = 45, hjust = 1)) +
  geom_text(aes(label = round(Difference, 1)), position = position_dodge(width = 0.9), vjust = 1.2, color = "black")

# Figure 3 (Part A)
cleaned_deaths_data_rep <- read_csv("data/analysis_data/cleaned_all_cause_dth_rates_rep.csv")

cleaned_deaths_data_long <- pivot_longer(cleaned_deaths_data_rep, cols = -country_name, names_to = "Year", values_to = "Value")

cleaned_deaths_data_long[,-1] <- lapply(cleaned_deaths_data_long[,-1], as.numeric)

cleaned_deaths_data_fit <- cleaned_deaths_data_long |>
  filter(Year >= 2013 & Year <= 2019)

ggplot(cleaned_deaths_data_long, aes(x = Year, y = Value, group = country_name, color = country_name)) +
  geom_line(aes(color = country_name)) +
  geom_point(aes(color = country_name)) +
  geom_smooth(data = cleaned_deaths_data_fit, method = "lm", se = FALSE, aes(color = country_name), linetype = "dashed", size = 0.5, alpha = 0.1) +
  theme_minimal() +
  scale_x_continuous(breaks = 2013:2021) +
  labs(title = "Values Over Years by Country", x = "Year", y = "Value") +
  theme(legend.title = element_blank())

# Figure 3 (Part B)

# Model: Australia
model_australia <- lm(Value ~ Year, data = cleaned_deaths_data_fit |> filter(country_name == "Australia"))
# Predicting 2020 and 2021
coefficients_aus <- coef(model_australia)
aus_2020 <- (coefficients_aus["Year"] * 2020) + coefficients_aus["(Intercept)"]
aus_2021 <- (coefficients_aus["Year"] * 2021) + coefficients_aus["(Intercept)"]
# Ratio
aus <- cleaned_deaths_data_long |>
  filter(country_name == "Australia")
excess_aus_2020 <- aus$Value[8] - aus_2020
excess_aus_2021 <- aus$Value[9] - aus_2021

# Model: Germany
model_germany <- lm(Value ~ Year, data = cleaned_deaths_data_fit |> filter(country_name == "Germany"))
# Predicting 2020 and 2021
coefficients_ger <- coef(model_germany)
ger_2020 <- (coefficients_ger["Year"] * 2020) + coefficients_ger["(Intercept)"]
ger_2021 <- (coefficients_ger["Year"] * 2021) + coefficients_ger["(Intercept)"]
# Ratio
ger <- cleaned_deaths_data_long |>
  filter(country_name == "Germany")
excess_ger_2020 <- ger$Value[8] - ger_2020
excess_ger_2021 <- ger$Value[9] - ger_2021

# Model: United Kingdom
model_uk <- lm(Value ~ Year, data = cleaned_deaths_data_fit |> filter(country_name == "United Kingdom"))
# Predicting 2020 and 2021
coefficients_uk <- coef(model_uk)
uk_2020 <- (coefficients_uk["Year"] * 2020) + coefficients_uk["(Intercept)"]
uk_2021 <- (coefficients_uk["Year"] * 2021) + coefficients_uk["(Intercept)"]
# Ratio
uk <- cleaned_deaths_data_long |>
  filter(country_name == "United Kingdom")
excess_uk_2020 <- uk$Value[8] - uk_2020
excess_uk_2021 <- uk$Value[9] - uk_2021

# Model: United States
model_us <- lm(Value ~ Year, data = cleaned_deaths_data_fit |> filter(country_name == "United States"))
# Predicting 2020 and 2021
coefficients_us <- coef(model_us)
us_2020 <- (coefficients_us["Year"] * 2020) + coefficients_us["(Intercept)"]
us_2021 <- (coefficients_us["Year"] * 2021) + coefficients_us["(Intercept)"]
# Ratio
us <- cleaned_deaths_data_long |>
  filter(country_name == "United States")
excess_us_2020 <- us$Value[8] - us_2020
excess_us_2021 <- us$Value[9] - us_2021

# Model: New Zealand
model_nz <- lm(Value ~ Year, data = cleaned_deaths_data_fit |> filter(country_name == "New Zealand"))
# Predicting 2020 and 2021
coefficients_nz <- coef(model_nz)
nz_2020 <- (coefficients_nz["Year"] * 2020) + coefficients_nz["(Intercept)"]
nz_2021 <- (coefficients_nz["Year"] * 2021) + coefficients_nz["(Intercept)"]
# Ratio
nz <- cleaned_deaths_data_long |>
  filter(country_name == "New Zealand")
excess_nz_2020 <- nz$Value[8] - nz_2020
excess_nz_2021 <- nz$Value[9] - nz_2021

# Model: South Korea
model_sk <- lm(Value ~ Year, data = cleaned_deaths_data_fit |> filter(country_name == "Korea, Rep."))
# Predicting 2020 and 2021
coefficients_sk <- coef(model_sk)
sk_2020 <- (coefficients_sk["Year"] * 2020) + coefficients_sk["(Intercept)"]
sk_2021 <- (coefficients_sk["Year"] * 2021) + coefficients_sk["(Intercept)"]
# Ratio
sk <- cleaned_deaths_data_long |>
  filter(country_name == "Korea, Rep.")
excess_sk_2020 <- sk$Value[8] - sk_2020
excess_sk_2021 <- sk$Value[9] - sk_2021

excess_deaths <- tibble(
  Year = c(2020, 2020, 2020, 2020, 2020, 2020, 2021, 2021, 2021, 2021, 2021, 2021),
  country_name = rep(c("Australia", "Germany", "United Kingdom", "United States", "New Zealand", "Korea, Rep."), times = 2),
  Value = c(excess_aus_2020, excess_ger_2020, excess_uk_2020, excess_us_2020, excess_nz_2020, excess_sk_2020, excess_aus_2021, excess_ger_2021, excess_uk_2021, excess_us_2021, excess_nz_2021, excess_sk_2021) |> round(2)
)

ggplot(excess_deaths, aes(x = country_name, y = Value, fill = as.factor(Year))) +
  geom_bar(stat = "identity", position = position_dodge(), width = 0.7) +
  coord_flip() +  # Flip coordinates to make the bar plot horizontal
  theme_minimal() +
  labs(title = "Value by Country and Year", x = "Country", y = "Value") +
  scale_fill_manual(values = c("2021" = "blue", "2020" = "lightblue"), name = "Year") +
  geom_text(aes(label = Value), position = position_dodge(width = 0.9), color = "black")






