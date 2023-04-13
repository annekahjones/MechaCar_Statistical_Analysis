library(tidyverse)
?mutate()

# to add columns to our data frame
demo_table <- demo_table %>% mutate(Mileage_per_Year=Total_Miles/(2020-Year),IsActive=TRUE) #add columns to original data frame

# if we want to group by condition of the car and determine average mileage per condition
summarize_demo <- demo_table2 %>% group_by(condition) %>% summarize(Mean_Mileage=mean(odometer), .groups = 'keep') #create summary table

# if we wanted to add more to our summarize_demo table
summarize_demo <- demo_table2 %>% group_by(condition) %>% summarize(Mean_Mileage=mean(odometer),Maximum_Price=max(price),Num_Vehicles=n(), .groups = 'keep') #create summary table with multiple columns

# learn about this function
?gather()

# read in a new data set
demo_table3 <- read.csv('demo2.csv',check.names = F,stringsAsFactors = F)

# this data would be considered wide because different metrics were collected from 
# a single vehicle and each metric was stored as a separate column

# to change it to long format:
long_table <- gather(demo_table3,key="Metric",value="Score",buying_price:popularity)

# we can also do this
long_table <- demo_table3 %>% gather(key="Metric",value="Score",buying_price:popularity)

# we have collapsed the survey metrics into one Metric column and all the values into a score column

# if the data was collected or obtained in long format, we could use this function to spread 
# out a variable column of multiple measurements into columns for each variable
?spread()

# to revert our previous-long-format data frame back to its original format, we could use the following
wide_table <- long_table %>% spread(key="Metric",value="Score")

# to check if our new table is the exact same as the original "demo_table3"
all.equal(demo_table3, wide_table)

# this says they are not equal but they should be, so try sorting the columns of both dataframes
table <- demo_table3[,order(colnames(wide_table))]
# or by using
table <- demo_table3[,(colnames(wide_table))]


