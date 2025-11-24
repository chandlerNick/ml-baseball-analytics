# read in the data
import pandas as pd

standard = pd.read_csv("standard.csv")

advanced = pd.read_csv("advanced.csv")

# Determine overlapping columns (excluding keys)
keys = ["Season", "Name", "Team"]
overlap = [col for col in standard.columns if col in advanced.columns and col not in keys]

# Drop overlapping columns from standard
standard_clean = standard.drop(columns=overlap)

# Merge
merged = pd.merge(standard_clean, advanced, on=keys, how="inner")

# ----- DROP 2025 SEASON ----- We want the data to have a target....
merged = merged[merged["Season"] < 2025]

# drop id
data2 = (
    merged
    .drop(columns=["id"])
    .sort_values(["Name", "Season"])
)

# group, shift, assign
data2["next_AVG"] = (
    data2.groupby("Name")["AVG"].shift(-1)   # lead() in R is shift(-1) in pandas
)

# drop rows with no next-year value
data2 = data2.dropna(subset=["next_AVG"])

# convert to decimals
data2["BB%"] = pd.to_numeric(data2["BB%"].str.rstrip("%")) / 100
data2["K%"]  = pd.to_numeric(data2["K%"].str.rstrip("%")) / 100

# rename columns
data2 = data2.rename(columns={"BB%": "BB.Percent", "K%": "K.Percent"})

# Write to CSV
data2.to_csv("merged.csv", index=False)
