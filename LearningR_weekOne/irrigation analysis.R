#Irrigation analysis
#Fatmah Kabeer
#01.10.2020
#A small case study using irrigation_wide.csv in the data directory

library(tidyverse)

#Begin with wide "messy" format:
irrigation <- read_csv("data/irrigation_wide.csv")

# Examine the data:
str(irrigation)
summary(irrigation)
glimpse(irrigation)

# In 2007, what is the total area under irrigation for only the Americas
#Rick solution
irrigation %>%
  filter (year == 2007) %>%
  select(ends_with("erica"))

irrigation %>%
  filter
(year == 2007) %>%
  select(`N. America`, `S. America`)

# use number for columns and add up the values 
#Rick solution
irrigation %>%
  filter (year == 2007) %>%
  select(4, 5) %>%
  sum()


# To answer the following questions we should use tidy data
#Rick solution
irrigation_t <- irrigation %>%
  pivot_longer(-c(year),
               names_to = "region")

# What is the total area under irrigation in each year across all region?

irrigation_t %>%
  group_by(year) %>%
  summarise(total = sum(value))

# Standarize against 1980 (relative change over 1980)
#mine

irrigation_t %>%
  group_by(region) %>%
  #summarise(relative = value[year == 2007] - value[year == 1980])
  summarise(relative = value[year == 2007 & 2000 & 1990] - value[year == 1980])

# Wher is the lowest and highest?
#mine
irrigation_t %>%
  group_by(region) %>%
  summarise(low_high = range(value))

# Plot area over time for each region?
ggplot(irrigation_t, aes(x = year, y = region)) +
  geom_point()

# which regin increased the most from 1980 to 2007?
irrigation_t %>%
  group_by(region) %>%
  summarise( diff = value[year == 2007] - value[year == 1980])

# which 2 regins increased the most from 1980 to 2007?
#arrange() reorders from lowest to highest
#and with - it's the opposite ("descending")
#slice() takes specific row numbers
#Rick solution
irrigation_t %>%
  group_by(region) %>%
  summarise( diff = value[year == 2007] - value[year == 1980]) %>%
  arrange(-diff) %>%
  slice(1:2)

#our use slice_max
#Rick solution
irrigation_t %>%
  group_by(region) %>%
  summarise( diff = value[year == 2007] - value[year == 1980]) %>%
  slice_max(diff, n = 2)


# What is the rate-of-change in each region?
#xx <-  c(1, 1.2, 1.6, 1.1)
#xx

#There are the absolute differences:
diff(0, value)
#How about the proportional?
irrigation_t <- irrigation_t %>% 
  arrange(region) %>%
  group_by(region) %>%
  mutate(rate = c(0, diff(value)/value[-length(value)]))

# Where is it the highest and lowest?
#Rick solution..
irrigation_t[which.max(irrigation_t$rate),]
irrigation_t[which.min(irrigation_t$rate),]

# This will give the max rate for EACH reegion
irrigation_t %>% 
  slice_max(rate, n = 1)
#Because ... the tibble is STILL a group_df
#so to get the global answer: ungroup()
irrigation_t %>%
  ungroup() %>%
  slice_max(rate, n =1)

# How about the lowest?
irrigation_t %>%
  ungroup() %>% 
  slice_min(rate, n = 1)

#add more code 