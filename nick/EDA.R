# Exploration of Baseballr

library(baseballr)
library(dplyr)
library(purrr)
library(glue)


all_funcs <- ls("package:baseballr")
domains <- c("mlb", "bref", "fg", "statcast", "ncaa", "retrosheet", "chadwick")

domain_map <- data.frame(
  func = all_funcs,
  domain = sapply(all_funcs, \(f) domains[stringr::str_detect(f, paste0("^", domains))][1])
)

table(domain_map$domain)  # Available datasets

#### --- read in data ---

# Define a safe wrapper around bref_team_results()
safe_bref_team_results <- safely(function(team, season) {
  Sys.sleep(runif(1, 0.5, 1.5))  # respect server limits
  bref_team_results(team = team, season = season)
})

# Pull list of MLB teams
teams <- c(
  "ARI", "ATH", "ATL", "BAL", "BOS", "CHC", "CHW", "CIN", "CLE", "COL", "DET",
  "HOU", "KCR", "LAA", "LAD", "MIA", "MIL", "MIN", "NYM", "NYY",
  "PHI", "PIT", "SDP", "SEA", "SFG", "STL", "TBR", "TEX", "TOR", "WSN"
)


# Define yer years
years <- 1980:1980

# Efficient multi-source ingest
team_game_logs <- map_dfr(years, function(y) {
  message(glue("Fetching {y}..."))
  
  map_dfr(teams, function(t) {
    res <- safe_bref_team_results(t, y)
    if (is.null(res$result)) return(NULL)
    df <- res$result
    df$season <- y
    df$team <- t
    return(df)
  })
})

res <- safe_bref_team_results("ATL", 2024)

res
team_game_logs

# Clean and prepare
clean_team_game_logs <- team_game_logs %>%
  mutate(
    date = as.Date(Date),
    home_team = ifelse(grepl("@", Opp), Opp, team),
    away_team = ifelse(grepl("@", Opp), team, Opp),
    home_win = as.integer(R > RA)
  ) %>%
  select(season, date, home_team, away_team, R, RA, home_win)


# Save by season
walk(unique(clean_team_game_logs$season), function(y) {
  df <- filter(clean_team_game_logs, season == y)
  write.csv(df, glue("data/raw/bref_team_results_{y}.csv"), row.names = FALSE)
})



