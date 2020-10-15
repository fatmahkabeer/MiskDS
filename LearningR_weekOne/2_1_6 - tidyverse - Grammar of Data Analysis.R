# 2.1.6 tidyverse - Grammar of Data Analysis
# Misk Academy Data Science Immersive, 2020

# Using the tidy PlayData dataframe, try to compute an aggregation function 
# according to the three scenarios, e.g. the mean of the value.

# Scenario 1: Aggregation (mean) across type height & width
PlayData_t %>%
  group_by(time, type) %>%
  #group_split()
  summarise(avg = mean(value))

# Scenario 2: Aggregation (mean) across time 1 & time 2

PlayData_t %>%
  group_by(key, type) %>%
  #group_split()
  summarise(avg = mean(value))

# Scenario 3: Aggregation (mean) across type A & type B
PlayData_t %>%
  group_by(key, time) %>%
  #group_split()
  summarise(avg = mean(value))

