# Part 1

library(dplyr)

# let's read in our CSV file and create a table
MechaCar_mpg = read.csv(file='MechaCar_mpg.csv',check.names=F,stringsAsFactors = F)

# Design a linear model that predicts the mpg of MechaCar prototypes using every other variable
lm(mpg ~ vehicle_length + vehicle_weight + spoiler_angle + ground_clearance + AWD,data=MechaCar_mpg)
summary(lm(mpg ~ vehicle_length + vehicle_weight + spoiler_angle + ground_clearance + AWD,data=MechaCar_mpg))
# p-value = 5.35e-11
# r^2 = 0.7149


# Part 2

# let's read in our CSV file and create a table
Suspension_Coil = read.csv(file="Suspension_Coil.csv", check.names=F, stringsAsFactors=F)

# Get the mean, median, variance, and standard deviation of the suspension coil’s PSI column
total_summary = Suspension_Coil %>% summarize(Mean=mean(PSI), Medium=median(PSI), Variance=var(PSI), SD=sd(PSI), .groups = 'keep')

# Group each manufacturing lot by the mean, median, variance, and standard deviation of the suspension coil’s PSI column
lot_summary = Suspension_Coil %>% group_by(Manufacturing_Lot) %>% summarize(Mean=mean(PSI), Medium=median(PSI), Variance=var(PSI), SD=sd(PSI), .groups = 'keep')


# Part 3

# Comparing all Manufacturing Lots
t.test(Suspension_Coil$PSI, mu=1500)
# p-value = 0.06028

# Comparing Manufacturing Lot 1
subset1 = subset(Suspension_Coil, Manufacturing_Lot == "Lot1")
t.test(subset1$PSI, mu=1500)
# p-value = 1

# Comparing Manufacturing Lot 2
subset2 = subset(Suspension_Coil, Manufacturing_Lot == "Lot2")
t.test(subset2$PSI, mu=1500)
# p-value = 0.6072

# Comparing Manufacturing Lot 3
subset3 = subset(Suspension_Coil, Manufacturing_Lot == "Lot3")
t.test(subset3$PSI, mu=1500)
# p-value = 0.04168


