# 2.1.4 - Indexing
# Misk Academy Data Science Immersive, 2020

# Indexing refers to
# Finding information by position, using []

# Vectors (1-dimensional) ----
# Using this vector:
foo1
# Try to find the following:
# The 6th element
foo1[6]
# The pth element
p <- 4
foo1[p]
# The 3rd to the pth element
foo1[3:p]
# the pth to the last element
fool[p:length(foo1)]
# remove using - (e.g. 11 - 15th element)
foo1[-c(11:15)]
# remove using - (e.g. 11 & 15th element)
foo1 <- c(1:15)
foo1
foo1[-(15 & 11)]

# We can use integers, object and functions that
# equate to integers in any combination!

# BUT!!! The exciting part is R using LOGICAL VECTORS
# I.E. THE RESULT OF LOGICAL EXPRESSIONS! (see above)

foo1[foo1 < 45] # All values less than 45

# So what happened here:
foo1 < 45 # produces a logical vector, 
# Remember, this will ALWAYS be the case when you see a 
# relational or logical operator
# Then we use that logical vector to select only the TRUE positions:
foo1[foo1 < 45] 

# Data frames (2-dimensional) ----
# so use [ <rows> , <cols> ] 
# Using this data frame:
foo_df
# Can you find the following 
# The 3rd row, all columns
foo_df[3,]
# The 3rd column, all rows
foo_df[,3]
# The 3rd column, all rows
foo_df[3]

# Can you identify the data structure of the output?

str(foo_df)
# What if foo_df wasn't tibble, but actually a true plain old data frame?
# What happens if we have a tibble?
foo_df <- as.data.frame(foo_df)
class(foo_df)
foo_df
# repeat the solutions from above:
foo_df[,3]
foo_df[3]
# ok, but let's go back to a tibble
foo_df <- as_tibble(foo_df)

# We can also use names:
foo_df[,"healthy"]

# But don't forget logical vectors:
# e.g. which tissues have low quantity (below 10)?
foo_dfquantity <- foo_df$quantity
foo_df[foo_dfquantity < 10, "tissue"]
# This also works, as a vector:

foo_df$tissue[foo_dfquantity < 10]
# How can we do this using the tidyverse way?
foo_df %>%
  filter(quantity < 10) %>%
  select(tissue)
# = 
foo_df$tissue[foo_dfquantity < 10]
