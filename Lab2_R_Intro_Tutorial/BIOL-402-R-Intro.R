#BIOL 402 Intro to R Tutorial
# Joey Bernhardt
# Sept 19 2016


# # Learning objectives:
# 1. Learn how to install and load packages
# 2. Learn how to import csv data
# 3. Learn how to 'smell test' the data and explore it
# 4. Learn how to use ggplot2 to plot it
# # 


## Step 1. Create a project in R Studio
## Step 2. Download the lake data into the folder you created for your project.

#  Step 3. install and load packages -----------------------------------------------

install.packages("tidyverse") # install the 'tidyverse' package, which contains the tools we will use in this class
library(tidyverse) # load the package using the library function


# Step 4. import data -------------------------------------------------------------

## use the read_csv function to read in our datasheet. 
mydata <- read_csv("lake_data.csv") # if your lake data sheet is saved in you R Project folder, you can import it simply by name


# Step 5. get to know the data ----------------------------------------------------


#lets check that our data is there
#look in the 'Environment' panel in RStudio, and you will see a file called mydata
#if you click on this file, you can view it
#alternatively write:
View(mydata)

#if our dataframe is really long, perhaps we just want to look at first 6 rows
head(mydata)
#or last 6 rows
tail(mydata)

#how many rows and columns does your dataframe have?
dim(mydata)

#lets see what type of data we have
str(mydata)
#you will see two types of data in our particular dataframe: 
#"num" = numeric, meaning a continuous number
#"int" = integer
#"chr" = character, or text

#to quickly see just the names of the variables, you can also write:
names(mydata)


# Step 6. plots -------------------------------------------------------------------

## Let's make a temperature depth profile
ggplot(data = mydata, aes(x = Temperature_C, y = Depth_m, group = Lake, color = Lake)) + geom_point() +
	geom_path() +
	scale_y_reverse() + theme_minimal()

## challenge: adapt the code above to make a DO depth profile

## Let's see how DO varies as function of temperature

ggplot(data = mydata, aes(x = Temperature_C, y = DO_mg_l)) + geom_point()

# more plots, with NASA atmospheric data ----------------------------------------

library(nasaweather)
View(atmos)

ggplot(data = atmos, aes(x = pressure, y = surftemp, color = lat)) + geom_point()
ggsave("myplot.png")
