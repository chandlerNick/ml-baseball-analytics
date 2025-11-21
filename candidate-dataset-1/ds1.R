# 1. Install and load packages
library(Lahman)
library(dplyr)
library(tidyr)
library(mboost)
library(data.table)
library(stats)

# 2. Data Preparation
new_batters <- Batting %>%
  filter(yearID >= 2020, AB > 100) %>%
  group_by(playerID) %>%
  arrange(playerID, yearID) %>%
  mutate(target = lead(H, order_by = yearID)) %>%  # Target is the number of hits in the following season.
  filter(!is.na(target))

# 3. Create Training and Test Sets - Make sure to drop ids (year, team, player, league)
train_data <- new_batters %>%
  filter(yearID < 2023)

test_data <- new_batters %>%
  filter(yearID >= 2023)

dim(new_batters)

head(new_batters)
