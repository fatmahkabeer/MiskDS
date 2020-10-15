# 2.1.3 - Logical expressions
# Misk Academy Data Science Immersive, 2020

# Logical expressions are how we
# Ask and combine TRUE/FALSE questions

# Asking questions ----
# There a 6 Relational Operators
# Can you list them?
#<, <=, >, >=, ==, and !=.

# Plus we have a special case in R:
# !x, where x is a logical vector, give the negation of x
!c(T, F, T, T, T)


# Combining questions ----
# There are 2 typical Logical Operators
# Can you name them?
# and &, or |
# There is one more R-specific logical operator
# %in% WITHIN

## Number one thing to remember:
## You will ALWAYS get a logical vector whenever you see a relational or logical operator

# Examples with foo_df: Logical data ----
# All healthy observations

foo_df %>% 
  filter(healthy == TRUE)

# All unhealthy observations

foo_df %>% 
  filter(healthy == FALSE)

# Examples with foo_df: Numeric data
# Below quantity 10

foo_df %>% 
  filter(quantity < 10)

# Tails (beyond 10 and 20)

foo_df %>% 
  filter(quantity >= 10 | quantity <= 20)


# Impossible
foo_df %>% 
  filter(quantity < 10 & quantity > 20)

# Middle (between 10 and 20)

foo_df %>% 
  filter(quantity >= 10 & quantity <= 20)


# Meaningless
# all values:
foo_df %>% 
  filter(quantity >= 10 | quantity <= 20)

# What really happened
# We asked two questions:
#1. What exactly we want to include. 
#2. the logical method

# Examples with foo_df: Character data
# NO PATTERN MATCHING so we have to use exact matches
# All heart observations

foo_df %>% 
  filter(healthy == TRUE)

# All heart and liver observations
# Cheap and easy way:
foo_df %>% 
  filter(tissue == "Heart" | tissue == "Liver")


# What if... our query was in a vector? Never do it
query <- c("Heart", "Liver")
# How can we combine many == and |
# Heart and Liver and Intestine - nice way
foo_df %>% 
  filter(tissue %in% c("Heart", "Liver"))

# to compare, NEVER DO THIS!!!
# This doesn't work:
foo_df %>% 
  filter(tissue == query)
# But this does: i.e. reverse the query
foo_df %>% 
  filter(tissue == rev(query))

