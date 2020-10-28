library(tidyverse)



happiness_2015 <- read.csv("archive/2015.csv")
happiness_2016 <- read.csv("archive/2016.csv")
happiness_2017 <- read.csv("archive/2017.csv")
happiness_2018 <- read.csv("archive/2018.csv")
happiness_2019 <- read.csv("archive/2019.csv")

#column names in each dataset
names(happiness_2015)
names(happiness_2016)
names(happiness_2017)
setdiff(names(happiness_2018), names(happiness_2019))

# Can we combine all together in one data set:



#Plot to explain the relationship between freedom to make life choices with the level of happiness.
#How freedom affect countries' happiness in 2019?
happiness_2019 <- happiness_2019 %>% 
  as_tibble() %>% 
  arrange(-Overall.rank) %>% 
  mutate(Country.or.region = as_factor(Country.or.region))

happiness_2019$Country.or.region

# The distrbution of the happiness scores
ggplot(happiness_2019, aes(x = Score,
                           y = Country.or.region)) +
  #facet_grid(Country.or.region ~ Social.support) +
  geom_point()

# Can we add information about the geo region?

names(happiness_2019)[2] <- "country"

library(gapminder)
happiness_2019 <- gapminder[c("continent", "country")] %>% 
  right_join(happiness_2019) %>% 
  arrange(-Overall.rank) %>% 
  mutate(country = as_factor(country))


ggplot(happiness_2019, aes(x = Score,
                           y = country)) +
  geom_point() +
  facet_grid(continent ~ ., scales = "free_y", space = "free_y") 

# If you want to compareFreedom.to.make.life.choices and score: use a scatter plot




#The comparisons in 2019 based on the following criteria:
dropN <- c("Country.or.region", "Overall.rank", "Score")
criteria <- names(happiness_2019[!(names(happiness_2019)) %in% dropN])
criteria


# How many Country in the dataset?
nrow(happiness_2019)


#Top 10 of the happiest country in 2019
happiest <- arrange(happiness_2019, Overall.rank)
head(happiest$Country.or.region, 10)

# Top 10 of the saddest country in 2019
saddest <- arrange(happiness_2019, desc(Overall.rank))
head(saddest$Country.or.region, 10)


# The average of the Healthy life expectancy for the saddest country in 2019
happiness_2019 %>% 
  summarise(avg = mean(Healthy.life.expectancy
                       [Overall.rank > (nrow(happiness_2019) - 10)]))

# The average of the Healthy life expectancy for the happiest country in 2019
happiness_2019 %>% 
  summarise(avg = mean(Healthy.life.expectancy
                       [Overall.rank > 10]))



# Saudis Happiness details in 2019 in comparisons with the happiest country
SvsF <- filter(happiness_2019, Country.or.region == "Saudi Arabia" | Overall.rank == 1)
SvsF


# In plot
# Columes to get rid of
drop <- c("Country.or.region", "Overall.rank", "Score")
lab <- names(SvsF[!(names(SvsF)) %in% drop]) 
lab

# Saudi Arabia plot
Sa <- as.double(unname(filter(SvsF, Country.or.region == "Saudi Arabia")), na.rm = TRUE) 
Sa <- na.omit(Sa)
pie(labels = lab, Sa, main = "Saudi Arabia")


Sa <- filter(SvsF, Country.or.region == "Saudi Arabia") %>% 
  as.double() %>% 
  unname()

Sa <- na.omit(Sa)
pie(labels = lab, Sa, main = "Saudi Arabia")
# Finland plot
Fi <- as.double(unname(filter(SvsF, Overall.rank == 1)), na.rm = TRUE)
Fi <- na.omit(Fi)
pie(labels = lab, Fi, main = "Finland")


#How happiness' rank in Saudi Arabia changed over the last five years
sa2015 <- filter(happiness_2015, Country == "Saudi Arabia")
sa2016 <- filter(happiness_2016, Country == "Saudi Arabia")
sa2017 <- filter(happiness_2017, Country == "Saudi Arabia")
sa2018 <- filter(happiness_2018, Country.or.region == "Saudi Arabia")
sa2019 <- filter(happiness_2019, Country.or.region == "Saudi Arabia")


SaHappinessDf <- data.frame(sa2015, sa2016, sa2017, sa2018, sa2019)
SaHappinessDf 

#aa <- merge(sa2015, sa2016, by = "Country", all = TRUE)
#aa


years <- c("2015", "2016", "2017", "2018", "2019")
happinessRate <- c(sa2015$Happiness.Rank, sa2016$Happiness.Rank, sa2017$Happiness.Rank, sa2018$Overall.rank, sa2019$Overall.rank)

# Saudis' happiness details over the last five years:
#SA15 <- select(sa2015, -c(Country, Region))
#SA16 <- select(sa2016, -c(Country, Region))
#SA17 <- select(sa2017, -Country)
#SA18 <- select(sa2018, -Country.or.region)
#SA19 <- select(sa2019, -Country.or.region)

#SA.df <- data.frame(SA15, SA16, SA17, SA18, SA19)

#Plot
SaHappinessRate <- data.frame(years,happinessRate)
ggplot(SaHappinessRate, aes(x = years,
                            y = happinessRate,
                            fill = years)) +
   geom_bar(stat="identity")




