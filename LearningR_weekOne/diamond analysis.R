# Diamond Analysis
# Rick Scavetta
# 29.09.2020
# A small case study for EDA and stats

# load packages
library(tidyverse)

# Read in the data (csv format):
# Newer methods from tidyr package
jems <- read_csv("data/diamonds.csv")

# super convenient way
# library(rio) # R i/o
# jems2 <- import("data/diamonds.csv")

# Get familiar with our data:
summary(jems)
names(jems)
glimpse(jems)

# more detail:
attributes(jems)
typeof(jems)



