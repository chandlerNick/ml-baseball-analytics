# ml-baseball-analytics
Analysis of historical baseball data using machine learning.

## Problem

1. Predict game outcome - P(W|X,Y) (probability of a win for team X given that X and Y are playing)
2. Predict number of points scored


## Data

R-Packages:
- Game-Level: retrosheet
- Player/Team-Level: Lahman
- Pitch-by-Pitch: baseballr (Too much detail?)
- [Here](https://www.fangraphs.com/leaders/major-league?pos=all&stats=bat&lg=all&type=0&ind=1&team=0%2Cto&rost=0&players=0&postseason=&startdate=&enddate=&month=0&qual=100&pageitems=2000000000&season1=2020&season=2025)

## Features

#### General-Team Level
- Lagged team performance stats
  - Rolling average over last N games
    - Runs scored / allowed
    - Batting average / OBP / SLG
    - ERA / WHIP for pitchers
  - Season averages
- Starting pitcher effects
- Home vs. Away
- Which park (There is no standard baseball field)
- Context
  - Days of rest
  - How many games have been played against this team
  - Month / DoTW?
  - Weather data

- If we get access to odds data: implied_home_win_prob -- make use of bookmaker's models 

#### Player-Level
- Perhaps an aggregate that scores players relative to all others in the position that season.
- In "The Signal and The Noise" by Nate Silver, he recommended that one uses player-level stats to make a decent predictive model. Team level was too coarse for him.
- ...

## Models

- Bayesian Classifier

- Gradient Boosted Trees



