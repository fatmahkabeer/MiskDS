# 2.1.2 - Data handling
# Misk Academy Data Science Immersive, 2020

# Part 1: Functions (i.e. "verbs") ----
# Everything that happens, is because of a function

# Arithmetic operators ----
# e.g. type a math equation
34 + 6

# BEDMAS - order of operations
# brackets, expon, div, mult, add, sub
# How are these different?
2 - 3/4 # 1.25
(2 - 3)/4 # -0.25

# Use objects in place of numbers
n <- 34
p <- 6
# so...
n + p

# 1 - Generic functions have a form:
# fun_name(fun_arg = ...)

# 2 - Call args by name or position

# i.e. Can you tell the difference in these function calls?
# Which ones work and which one will produce an error?
log(x = 8, base = 2) # naming, long form 
log(base = 2, x = 8) # naming, position doesn't matter
log(8, 2) # positional matching, long form
log(8, base = 2) # mix of positional matching and naming (very common)
log2(8) # short form, positional matching
log(base = 2, 8) # mixed order (confusing)

# 3 - Funs can have 0 to many un-named args
# Can you think of an example of a function with 0 args? 
library(tidyverse) # displays all installed packages
# geom_point() #just uses default
ls() # list all objects
list.files()
getwd()
# 4 - Args can be named or un-named

# c() for combine ----
# With numbers:
xx <- c(2, 3, 8, 23)
xx

# With characters:
myNames <- c("healthy","tissue","quantity")
myNames

# As an aside: recall, everything is a function...
# How is + a function?
p + n
# this is actually...
`+`(p, n)

# random number generators:
# reproducible
set.seed(136) # any integer
runif(3)

set.seed(136)
runif(3)

# according to a distribution:
runif(3)
rnorm(3)


# by selecting
sample(xx, 1)

# seq() for a regular sequence of numbers ----
seq(from = 1, to = 100, by = 7)
# Can you write this in a shorter form?
# Assign the output to foo1
foo1 <- seq(1, 100, 7)
foo1

# We can use objects in functions:
foo2 <- seq(1, n, p)
foo2

# The colon operator ----
# regular sequence of 1 interval
seq(1, 10, 1)
# Use the colon operator instead:
1:10

# Applying math functions ----
# Two major types of math functions:
# Aggregation functions
# 1 output value (typically)
# mean, sd, n, var, median, max, min, sum, prod

# Transformation functions
# same number of output as input
# log, [0,1], z-scores, sqrt, exponents
# subtract background
# +, -, /, ...

# Exercise: Are these transformation or aggregation?
# DON't execute the commands, try to guess what the output will be!
foo2 + 100 # Transformation
foo2 + foo2 # Transformation
sum(foo2) + foo2 # Agg, followed by trans
1:3 + foo2 # Transformation

# FUNDAMENTAL CONCEPT: VECTOR RECYCLING ----
1:4 + foo2

# Now we're starting to see different kinds of feedback from R
# There are 3 types of messages:
# Message: Neutral
# Warning: Possible problem
# Error: Full stop

# Exercise:
# Calculate y = 1.12x - 0.4 for xx
y <- 1.12*xx - 0.4
y
# Part 2: Objects (nouns) ----
# Anything that exists is an object

# Vectors - 1-dimensional, homogeneous ----
# Everything in the values section
foo1 # 15 elements
myNames # 3 elements

# "user-defined atomic vector types" ----
# What do you the 4 most common ones are used to represent? 
# Logical - TRUE/FALSE, T/F, 1/0 (Boolean, binary)
# Integer - whole numbers (no decimals)
# Double - real numbers (float) (includes decimals)
# Character - All values (string)
# The other two: raw & complex

# Numeric - Generic class refer to int or dbl

# check
typeof(foo1)
typeof(myNames)

# L forces to be an integer
n <- 34L
typeof(n)

# Let's make some more vectors for later on:
foo3 <- c("Liver", "Brain", "Testes", "Muscle",
          "Intestine", "Heart")
typeof(foo3)

foo4 <- c(TRUE, FALSE, FALSE, TRUE, TRUE, FALSE)
typeof(foo4)

# Homogeneous types:
test <- c(1:10, "bob")
test
typeof(test)

# We can't do math:
mean(test)

# R has a type hierarchy

# Solution: Coercion to another type
# use an as.*() function
test <- as.numeric(test)
test

# Now we can do math: 
mean(test)
# but we need to deal with the NA
mean(test, na.rm = TRUE)

# Lists - 1-dimensional, heterogeneous ----
typeof(plant_lm)

# how many elements:
length(plant_lm)
length(foo1) # also works for vectors

# attributes (meta data)
attributes(plant_lm)
# 13 named elements

# use common "accessor" functions for attributes
names(plant_lm)

# Anything that's named can be called with $
plant_lm$coefficients # a 3-element named dbl (numeric) vector
plant_lm$residuals # a 30-element dbl vector
plant_lm$model # data.frame

# As an aside: You can even add comments:
comment(plant_lm) <- "I love R!"
attributes(plant_lm)

# Add comment as an actual list item:
plant_lm$myComment <- "But python also :)"
plant_lm$myComment

# What is class?
# An attribute to an object
attributes(plant_lm)
# can also access with "accessor" function:
class(plant_lm)
class(Plant_anova)
# class tells R functions what to do with this object
# e.g.
summary(plant_lm) # get t-test and ANOVA summary from an "lm"
summary(PlantGrowth) # summarise each column in a "dataframe"

# Dataframes - 2-dimensional, heterogenous ----
class(PlantGrowth)
# A special class of type list...
typeof(PlantGrowth)
# ...where each element is a vector of the SAME length!
# Rows = observations
# Columns = variables

# Make a data frame from scratch using data.frame(), or...
# You can use the modern variant  
# Note, I put _df on the end of the name to remind us that this is a
# data frame (well, a tibble), but it's not necessary.
foo_df <- tibble(foo4, foo3, foo2)
foo_df

# To modify the column names, what you're actually doing is
# Change an attribute (think metadata). The most common attributes
# can be accessed with accessor functions, in this case names()
names(foo_df) <- myNames
foo_df


# How can you call each variable (i.e. column) by name:
# Note it will return a vector
foo_df$healthy
PlantGrowth$weight

# Basic functions:
# Display the structure of foo_df using a base R function:
str(foo_df)

# Now using a tidyverse function:
glimpse(foo_df)

# Can you get a short summary of every variable with one command?
summary(foo_df)

# Can you print out the number of rows & columns?
length(foo_df) # The number of columns, i.e. the number of elements in the list
dim(foo_df)

# How about just the number of rows?
nrow(foo_df)

# How about just the number of columns? 
ncol(foo_df)
