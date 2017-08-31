### Code from Bio402 lab, Nov 15 2016

#  load libraries ---------------------------------------------------------

library(tidyverse)
library(plotrix) ## 	has functions for standard error
library(broom)


# load in data ------------------------------------------------------------

nitrate <- read_csv("nitrate.csv")

## calculate the mean

View(nitrate)

## if we have more than one data point per Lake per Depth, average them
library(plotrix) ## has the std error function (if you don't have it install.packages("plotrix"))

## get standard errors
nitrate2 <- nitrate %>% 
	group_by(Lake, Depth) %>% 
	summarise_each(funs(mean, std.error), Nitrate)

### OR get mean and standard error for each lake 
nitrate_lake <- nitrate %>% 
	group_by(Lake) %>% 
	summarise_each(funs(mean, std.error), Nitrate)

ggplot(data = nitrate_lake, aes(x = Lake, y = mean)) + geom_point() +
	geom_errorbar(aes(ymin = mean - std.error, ymax = mean + std.error))


## ask: how does nitrate concentration vary with depth?
## use a linear model (lm) to answer


ggplot(data = nitrate2, aes(x = Depth, y = mean_nitrate, group = Lake, color = Lake)) + geom_point() +
	geom_smooth(method = "lm")

### linear models
mod <- lm(mean_nitrate ~ Depth, data = nitrate2)
glance(mod)

model_results <- tidy(mod, conf.int = TRUE)

glimpse(nitrate2)


model_output <- nitrate2 %>% 
	group_by(Lake) %>% 
	do(tidy(lm(mean_nitrate ~ Depth, data = .), conf.int = TRUE)) 

View(model_output)


### make a coefficients plot

model_output %>% 
	filter(term != "(Intercept)") %>%
	ggplot(data = ., aes(x = Lake, y = estimate)) + geom_point() +
	geom_errorbar(aes(ymin = conf.low, ymax = conf.high)) +
	theme_minimal()

### boxplots

nitrate2 %>% 
	ggplot(data = ., aes(x = Lake, y = mean_nitrate)) + geom_boxplot()
	
?geom_boxplot
