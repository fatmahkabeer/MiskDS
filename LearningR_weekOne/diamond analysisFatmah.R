
library(tidyverse)

getwd()
jems <- read.csv("/Users/apple/Desktop/DataScience/RickFiles/data/diamonds.csv")

#get familiar with our data:
summary(jems)
names(jems)
str(jems)


# more detail:
attributes(jems)
typeof(jems)

jems <- as_tibble(jems)
jems

#
# Exercise 8.3 (Counting individual groups) -----
# - How many diamonds with a clarity of category "IF" are present in the data-set?

library(rio)
export(clarity, "clarity.csv")



#my not working solution
diam_clar <- jems$clarity[jems$clarity == "IF"] %>%
 count()


#using indexing
nrow(jems[jems$clarity == "IF",])
sum(jems$carat == "IF")
# team solution
count_if <-  jems %>%
  filter(clarity == "IF") %>%
  count()
# count_if
IF_count <- count_if$n
IF_count

#another solution
clarity <- jems %>%
  filter(clarity == "IF")
nrow(clarity)

#another clever solution
sum(jems$clarity == "IF")

# - What fraction of the total do they represent?
count_total <- jems %>%
  count()
Total_count <- count_total$n
Total_count

fractionofIF <- IF_count / Total_count
fractionofIF

# another solution
nrow(clarity) / nrow(jems) * 100 # *100 is optional
 
#what are the prices of IF clarity diamond
jems$price[jems$clarity == "IF"]


#Exercise 8.4 (Summarizing proportions) ----
# What proportion of the whole is made up of each category of clarity?

jems %>%
  group_by(clarity) %>%
  count() %>% #will count the length of how many observation we have in each category
  mutate(prop = n / nrow(jems))

# Excercise 8.5 (Find specific diamonds prices) ----
# - What is the cheapest diamond price overall?
min(jems$price)

# what are the cheapest diamonds (2-way tie)
jems %>%
  filter(price == min(price))

# - What is the rang of diamond prices?
range(jems$price) # highest value and lowest value

#what is the average diamond price in each category of cut and color?
jems %>%
  group_by(cut, color) %>%
  summarise(avg = mean(price))

# Excercise 8.6 (Basic plotting) -----
# the price describe be the carite
# y is depending in x
#(describe the price according to the carat)
ggplot(jems, aes(x = carat , y = price )) + #aes means the mapping of variable
  geom_point() #geom_point() use to make a scattpolot. and scattpot is a continues X and continues Y. 


#Transformation:
# do not do that because it is not a part of your dataset.
#You dont have to have your data separated in different objects. 
carat_log10 <- log10(jems$carat)
price_log10 <- log10(jems$price)

#instend, recall the function for applying
#ransformations from the tidyverse?

jems <- jems %>%
  mutate(carat_log10 = log10(carat),
         price_log10 = log10(price))

#alternative (old school way)
price_log10 <- log10(jems$price)
jems$price_log10 <- price_log10
#which means, or can be like this wihtout oblect
jems$price_log10 <- log10(jems$price)

#jems %>%
# add_column(price_log10 = log10(jems$price))
# produce our model: y ~ x 
# plot the transformed variables:
ggplot(jems, aes(x = carat_log10, y = price_log10)) +
  geom_point()


# Excercise 8.10 (produce our model) ----

#this is just saying y descripe by x (y ~ x) = give me y predected by x.
jems_lm <- lm(price_log10 ~ carat_log10, data = jems)
jems_lm

# how to just get the coefficients. 
# if you have an object and it is a list and you want the items inside it
glimpse(jems_lm) #not a nice soultion it give a lot of details.
jems_lm$coefficients

#plot:
ggplot(jems, aes(carat_log10, price_log10)) +
  geom_point() +
  geom_smooth(method = "lm",
              se = FALSE, # to remove the error on the model 
              color = "red")



