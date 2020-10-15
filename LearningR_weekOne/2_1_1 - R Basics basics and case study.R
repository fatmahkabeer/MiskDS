# 2.1.1 - R Basics basics and case study
# Misk Academy Data Science Immersive, 2020

# Always begin your R scripts with a descriptive header

# Load packages ----
# Install once, but initialize each time you start a new session
# We'll come back to this packages soon later on. I put this 
# command here since it's good practice to list all your used 
# packages at the beginning of a script
library(tidyverse)

# Basic R syntax ----
# What does this command do?
n <- log2(8) # the log2 of 8
# 2 to the power of what gives 8?
# Exercise 1 ----
# Can you identify all the parts of the above commands?
n # shortcut for print(n)
log2() # function computes the natural logarithms

# Exercise 2 ----
# Incomplete commands :/
# What happens if you execute this command?
n <- log2(8)

# Plant Growth Case Study ----
# A built-in data set ----
PlantGrowth # already available in base R
data(PlantGrowth) # This will make it appear in your environment

# We're going to do something quite modern in R, which is to use a 
# tibble instead of a data.frame. That doesn't mean anything to you 
# now, but we'll get to it soon.
# First, make sure you have the tidyverse package installed and
# that you have executed the library(tidyverse) command
# above, after installing, so that you have initialized the package.
PlantGrowth <- as_tibble(PlantGrowth) # convert this to a "tibble" (more on this later)
PlantGrowth

# 1. Descriptive Statistics ----
# The "global mean" of all the weight values
mean(PlantGrowth$weight)

# Would this work on the group column? NO
mean(PlantGrowth$group)

# Group-wise descriptive statistics
# Here, using functions from dplyr, a part of the Tidyverse
# Using Tidyverse notation:
# %>% is the "the pipe operator"
# Pronounce it as "... and then ..."
# Type it using shift + ctrl + m

# Use summarise() for aggregation functions (e.g. mean)
PlantGrowth %>% 
  group_by(group) %>% 
  summarise(avg = mean(weight))


# Or... an atypical example, but it can still be useful:

PlantGrowth1 <-  mean(PlantGrowth$weight[PlantGrowth$group=="ctr1"])
PlantGrowth1

# For transformation functions: e.g. z-score within each group
# (x_i - x_bar)/x_sd
# function: scale()
# typical use mutate()

PlantGrowth %>% 
  group_by(group) %>% 
  mutate(zscore = scale(weight))

# or...

PlantGrowth2 <-  scale(PlantGrowth$weight[PlantGrowth$group=="ctr1"])



# Let's review the two most common syntax paradigms in R
# (This is kind of like different dialects of the same language,
# some things are the same or very similar but there are key
# differences that make them distinct systems.)
# Typical base pkg syntax
mean(PlantGrowth$weight)

# Tidyverse syntax
PlantGrowth$weight %>% 
  mean()
# %>% says take the object on the left (i.e. a dataframe) and insert it
# into the first position of the function on the right


# 2. Data Visualization ----
# Here, using functions from ggplot2, a part of the Tidyverse
# 3 essential components
# 1 - The data
# 2 - Aesthetics - "mapping" variables (data) onto scales (visuals)
# scales: x, y, color, size, shape, linetype
# 3 - Geometry - how the plot will look

# box plot
ggplot(PlantGrowth, aes(x = group, y = weight)) +
  geom_boxplot()

# "dot plot" (mean +/- 1 Standard Deviation)
# We can add a "statistics" layer
ggplot(PlantGrowth, aes(group, weight)) +
  geom_jitter(width = 0.15) +
  stat_summary(fun.data = mean_sdl, 
               fun.args = list(mult = 1), 
               col = "red")

# By default, you'll get the mean +/- the SEM
ggplot(PlantGrowth, aes(x = group, y = weight)) +
  geom_jitter(width = 0.15) +
  stat_summary(col = "red")

# 3. Inferential Statistics ----
# first step: define a linear model
# y ~ x means "described by" (say tilda)
plant_lm <- lm(weight ~ group, data = PlantGrowth)
plant_lm

# 1-way ANOVA
anova(plant_lm)


# For all pair-wise comparisons use:
ANOVA


