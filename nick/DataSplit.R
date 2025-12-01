# Train test split of the data -> 2024 in test and no player appears in more than one set. The temporal effects are likely less of a concern than player-based leakage.
# Disclosure, AI assisted with some parts of this code.
set.seed(123)

data <- read.csv("merged.csv")

# Dimension of data
dim(data)

# All unique players
players <- unique(data$Name)

## PLAN: Take all 2024-appearing players and then more to get the 20% necessary for test. Then just split the val and train normally but with players not occurring in two sets.

# Players in 2024 season -> all go to test
players.2024 <- unique(data[data$Season == 2024,"Name"])
players.remaining <- setdiff(players, players.2024)  # setdiff -> set difference

# How many players to get 20% of rows
rows.2024 <- data[data$Name %in% players.2024, ]
target.test.rows <- floor(0.2 * nrow(data))
extra.needed <- target.test.rows - nrow(rows.2024)

# sample extra players from remaining players
extra.players <- c()
cum.rows <- 0
set.seed(123)
shuffled <- sample(players.remaining)  # Shuffles the players.remaining list

for (p in shuffled) {
  player.rows <- nrow(data[data$Name == p, ])  # Take out the player's rows
  cum.rows <- cum.rows + player.rows  # Add to the count of the cumulative rows
  extra.players <- c(extra.players, p)  # Add new player to the extra players
  if (cum.rows >= extra.needed) break  # Stop if we got the needed players (won't overshoot 20% by much)
}

test.players <- c(players.2024, extra.players)
test.set <- data[data$Name %in% test.players, ]

trainval.players <- setdiff(players, test.players)
trainval.data <- data[data$Name %in% trainval.players, ]

# val - 20%
val.frac <- 0.247  # MAGIC NUMBER (kind of, at least there's a var name) !
val.players <- sample(unique(trainval.data$Name),
                      size = ceiling(val.frac * length(unique(trainval.data$Name))))
val.set <- trainval.data[trainval.data$Name %in% val.players, ]

# Train is the rest
train.set <- trainval.data[!trainval.data$Name %in% val.players, ]


# Confirm percentages
dim(test.set)
dim(val.set)
dim(train.set)

dim(test.set)[1]/dim(data)[1]
dim(val.set)[1]/dim(data)[1]
dim(train.set)[1]/dim(data)[1]

stopifnot(dim(test.set)[1] + dim(val.set)[1] + dim(train.set)[1] == dim(data)[1])  # Small sanity check

# Write to files
write.csv(test.set, "test.csv", row.names=FALSE)
write.csv(val.set, "val.csv", row.names=FALSE)
write.csv(train.set, "train.csv", row.names=FALSE)



