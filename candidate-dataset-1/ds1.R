library(baseballr)
library(dplyr)
library(readr)

bat_2020_2025 <- fg_batter_leaders(
  startseason = "2020",
  endseason   = "2025",
  pos         = "all",
  stats       = "bat",
  lg          = "all",
  qual        = "0",     # no PA minimum, get everyone
  ind         = "1",     # return season-level rows, not aggregate
  pageitems   = "10000", # avoid pagination
  pagenum     = "1",
)

# Write to CSV
write_csv(bat_2020_2025, "fangraphs_batters_2020_2025.csv")