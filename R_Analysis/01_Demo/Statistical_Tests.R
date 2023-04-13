# Qualitative test for normality
# The qualitative test for normality is a visual assessment of the distribution 
# of data, which looks for the characteristic bell curve shape across the distribution.
library(ggplot2)
# To test the distribution of vehicle weights from the built-in mtcars dataset
ggplot(mtcars,aes(x=wt)) + geom_density() #visualize distribution using density plot
# ^^^ we can see that it is approximately normal

# Quantitative test for normality 
# The quantitative test for normality uses a statistical test to quantify the 
# probability of whether or not the test data came from a normally distributed dataset.

# We can use the Shapiro-Wilk test
shapiro.test()
# it requires only the numeric vector of the values you wish to test
shapiro.test(mtcars$wt)
# if the p-value is greater than 0.05, the data is considered normally distributed

# Hypothesis Testing
# The null hypothesis is also known as H0 and is generally the hypothesis that can be explained by random chance.
# The alternate hypothesis is also known as Ha and is generally the hypothesis that is influenced by non-random events.

# Errors in Hypothesis Testing
# Type I error (also known as a false positive error)—an error in which we reject the null hypothesis when it is actually true.
# Type II error (also known as a false negative error)—an error in which we fail to reject the null hypothesis when it is actually false.

# Sampling
library(dplyr)
library(ggplot2)
?sample_n()

# Practice generating random samples
### we want to transform our data with log10 to make it more norml since it is skewed right
population_table <- read.csv('used_car_data.csv',check.names = F,stringsAsFactors = F) #import used car dataset
plt <- ggplot(population_table,aes(x=log10(Miles_Driven))) #import dataset into ggplot2
plt + geom_density() #visualize distribution using density plot

sample_table <- population_table %>% sample_n(50) #randomly sample 50 data points
plt <- ggplot(sample_table,aes(x=log10(Miles_Driven))) #import dataset into ggplot2
plt + geom_density() #visualize distribution using density plot

# T-Test
# Assumptions
# 1) The input data is numerical and continuous. This is because we are testing the distribution of two datasets.
# 2) The sample data was selected randomly from its population data.
# 3) The input data is considered to be normally distributed.
# 4) The sample size is reasonably large. Generally speaking, this means that the sample data distribution should be similar to its population data distribution.
# 5) The variance of the input data should be very similar.

?t.test()

# If we want to test if the miles driven from our previous sample dataset is 
# statistically different from the miles driven in our population data
t.test(log10(sample_table$Miles_Driven),mu=mean(log10(population_table$Miles_Driven))) #compare sample versus population means

# Two Sample T-Test
# Assumptions
# 1) The input data is numerical and continuous.
# 2) Each sample data was selected randomly from the population data.
# 3) The input data is considered to be normally distributed.
# 4) Each sample size is reasonably large. Generally speaking, this means that the sample data distribution should be similar to its population data distribution.
# 5) The variance of the input data should be very similar.

# Let's test whether the mean miles driven of two samples from our used car 
# dataset are statistically different.
sample_table <- population_table %>% sample_n(50) #generate 50 randomly sampled data points
sample_table2 <- population_table %>% sample_n(50) #generate another 50 randomly sampled data points

# Since our samples should not contain bias, we expect to fail to reject the null hypothesis
t.test(log10(sample_table$Miles_Driven),log10(sample_table2$Miles_Driven)) #compare means of two samples

# We can also compare samples from different populations, which is known as a pair t-test
# we use it when:
# Comparing measurements on the same subjects across a single span of time (e.g., fuel efficiency before and after an oil change)
# Comparing different methods of measurement (e.g., testing tire pressure using two different tire pressure gauges)

# Generate two samples
mpg_data <- read.csv('mpg_modified.csv') #import dataset
mpg_1999 <- mpg_data %>% filter(year==1999) #select only data points where the year is 1999
mpg_2008 <- mpg_data %>% filter(year==2008) #select only data points where the year is 2008

t.test(mpg_1999$hwy,mpg_2008$hwy,paired = T) #compare the mean difference between two samples

# ANOVA Testing
# Used to compare the means of a continuous numerical variable across a number of groups (or factors in R)
# A one-way ANOVA is used to test the means of a single dependent variable across 
# a single independent variable with multiple groups. (e.g., fuel efficiency of different cars based on vehicle class).
# A two-way ANOVA does the same thing, but for two different independent variables 
# (e.g., vehicle braking distance based on weather conditions and transmission type).

# Assumptions
# 1) The dependent variable is numerical and continuous, and the independent variables are categorical.
# 2) The dependent variable is considered to be normally distributed.
# 3) The variance among each group should be very similar.

?aov()

# "Is there any statistical difference in the horsepower of a vehicle based on its engine type?"
# clean the data
mtcars_filt <- mtcars[,c("hp","cyl")] #filter columns from mtcars dataset
mtcars_filt$cyl <- factor(mtcars_filt$cyl) #convert numeric column to factor
# run test
aov(hp ~ cyl,data=mtcars_filt) #compare means across multiple levels
# to find p-value
summary(aov(hp ~ cyl,data=mtcars_filt))

# Correlation

?cor()

head(mtcars)

# we'll test whether or not horsepower (hp) is correlated with quarter-mile race time (qsec).
plt <- ggplot(mtcars,aes(x=hp,y=qsec)) #import dataset into ggplot2
plt + geom_point() #create scatter plot
cor(mtcars$hp,mtcars$qsec) #calculate correlation coefficient

# Use our usedcars dataset
used_cars <- read.csv('used_car_data.csv',stringsAsFactors = F) #read in dataset
head(used_cars)

# we'll test whether or not vehicle miles driven and selling price are correlated
plt <- ggplot(used_cars,aes(x=Miles_Driven,y=Selling_Price)) #import dataset into ggplot2
plt + geom_point() #create a scatter plot
cor(used_cars$Miles_Driven,used_cars$Selling_Price) #calculate correlation coefficient

# Making a correlation matrix
used_matrix <- as.matrix(used_cars[,c("Selling_Price","Present_Price","Miles_Driven")]) #convert data frame into numeric matrix
cor(used_matrix)

# Linear Regression

?lm()

# Assumptions
# 1) The input data is numerical and continuous.
# 2) The input data should follow a linear pattern.
# 3) There is variability in the independent x variable. This means that there must be more than one observation in the x-axis and they must be different values.
# 4) The residual error (the distance from each data point to the line) should be normally distributed.

# Using our simple linear regression model, we'll test whether or not 
# quarter-mile race time (qsec) can be predicted using a linear model and horsepower (hp).
lm(qsec ~ hp,mtcars) #create linear model

# Therefore, the linear regression model for our dataset would be qsec = -0.02hp + 20.56.

summary(lm(qsec~hp,mtcars)) #summarize linear model

# From our linear regression model, the r-squared value is 0.50, which means 
# that roughly 50% of all quarter mile time predictions will be correct when using this linear model.

# we can visualize the fitted line against our dataset using ggplot2.
model <- lm(qsec ~ hp,mtcars) #create linear model
yvals <- model$coefficients['hp']*mtcars$hp + model$coefficients['(Intercept)'] #determine y-axis values from linear model
plt <- ggplot(mtcars,aes(x=hp,y=qsec)) #import dataset into ggplot2
plt + geom_point() + geom_line(aes(y=yvals), color = "red") #plot scatter and linear model

# Multiple Linear Regression

# To better predict the quarter-mile time (qsec) dependent variable, we can add 
# other variables of interest such as fuel efficiency (mpg), engine size (disp), 
# rear axle ratio (drat), vehicle weight (wt), and horsepower (hp) as independent 
# variables to our multiple linear regression model.
lm(qsec ~ mpg + disp + drat + wt + hp,data=mtcars) #generate multiple linear regression model
summary(lm(qsec ~ mpg + disp + drat + wt + hp,data=mtcars)) #generate summary statistics

# Chi-Square Test
# Assumptions
# 1) Each subject within a group contributes to only one frequency. In other words, the sum of all frequencies equals the total number of subjects in a dataset.
# 2) Each unique value has an equal probability of being observed.
# 3) There is a minimum of five observed instances for every unique value for a 2x2 chi-squared table.
# 4) For a larger chi-squared table, there is at least one observation for every unique value and at least 80% of all unique values have five or more observations.

?chisq.test()

# If we want to test whether there is a statistical difference in the distributions 
# of vehicle class across 1999 and 2008 from our mpg dataset, we would first need 
# to build our contingency table as follows and then test it
tbl <- table(mpg$class,mpg$year) #generate contingency table
chisq.test(tbl) #compare categorical distributions

# A/B Testing

# A/B testing is a randomized controlled experiment that uses a control 
# (unchanged) and experimental (changed) group to test potential changes using a success metric.

# If the success metric is numerical and the sample size is small, a z-score summary statistic can be sufficient to compare the mean and variability of both groups.
# If the success metric is numerical and the sample size is large, a two-sample t-test should be used to compare the distribution of both groups.
# If the success metric is categorical, you may use a chi-squared test to compare the distribution of categorical values between both groups.



