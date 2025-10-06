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
