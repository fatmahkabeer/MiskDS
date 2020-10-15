# An analysis of Plant Growth
# Rick Scavetta
# 28.09.2020
# The first case study in R

# Load packages
library(tidyverse)

# Obtain our data ----
PlantGrowth
PlantGrowth <- as_tibble(PlantGrowth) # convert this to a "tibble" (more on this later)


# Explore our data ----

# Descriptive statistics ----
# mean, standard deviation
PlantGrowth %>% 
  group_by(group) %>% 
  summarise(avg = mean(weight))

# Data Visualization ----
ggplot(PlantGrowth, aes(x = group, y = weight)) +
  geom_boxplot()



# Inferential statistics ----
# 1-way ANOVA


