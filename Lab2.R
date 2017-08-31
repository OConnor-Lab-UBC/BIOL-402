## Lab 2 -- Depth profile plotting with field trip data
## September 27 2016
## Joey Bernhardt


## Goals for today: 
## 1. revisit how to load data and explore it using str()
## 2. create depth profiles using ggplot()
## 3. Identify outliers or data entry errors
## 4. summarize our data for each lake, using the summarise() function
## 5. create a new csv with summary data, using the write_csv() function
## 6. introduce the pipe operator %>% 
## 7. learn about how to use na.rm

# Load packages -----------------------------------------------------------


library(tidyverse)


# load in data ------------------------------------------------------------


mydata <- read_csv("YSI_data.csv")

# explore data ------------------------------------------------------------

str(mydata)


# plot the depth profile for temperature ----------------------------------

## plot the temperature profiles, grouped by lake
## control the y axis limits with the 'limits =' argument in 'scale_y_reverse'

ggplot(data = mydata, aes(x = Temp, y = Depth, group = Lake, color = Lake)) + 
	scale_y_reverse(limits = c(10,0)) + theme_minimal() + geom_path() + xlab("temperature, C")


# let’s calculate the mean ------------------------------------------------

## our mission: We have 4 sites worth of YSI data for each lake. We want to summarize those 4 sites into one mean value at each depth, for each lake

summary_data <- mydata %>%
	group_by(Lake, Depth) %>% ## we are going to want to calculate our mean at each depth, in each lake, so group_by Lake and Depth 
	summarise(mean_temperature = mean(Temp, na.rm = TRUE), ## use the summarise function to create a new variable, mean_temperature
						mean_light = mean(Light, na.rm = TRUE), ## create another variable, mean_light
						mean_DO = mean(DO, na.rm = TRUE)) ## etc.
	


# plot the summary data ---------------------------------------------------

ggplot(data = summary_data, aes(x = mean_temperature, y = Depth, group = Lake, color = Lake)) + 
	scale_y_reverse(limits = c(10,0)) + theme_minimal() + geom_path() + xlab("temperature, C")


# write out the summary data to csv ---------------------------------------

## here we use the 'write_csv' function to create a csv of our summarized data

write_csv(summary_data, "Joey_summary_data.csv")
	
