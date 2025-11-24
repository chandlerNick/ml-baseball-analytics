library(dplyr)
library(readr)

data <- read.csv("merged.csv")

dim(data)

summary(data)

head(data)

### EDA here - maybe in RMD?

range(data$Season)
