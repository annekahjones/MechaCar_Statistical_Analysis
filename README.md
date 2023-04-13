# MechaCar_Statistical_Analysis

## Linear Regression to Predict MPG

The variables that provided a non-random mount of variance to the mpg values are vehicle_length and ground_clearance 

The slope of the model is not considered to be 0 because the more of the variables are determined by random chance. Also the p-value of the model is extremely low, so we reject the null hypothesis, which is that the slope is 0.

Due to the lack of the significant variables, this linear model does not effectively predict mpg of MechaCar prototypes. It is considered to be overfitting. 

## Summary Statistics on Suspension Coils

The variance for the manufacturing lots in total is 62.29356, so it meets the design specification. The variance for manufacturing lot 1 is 0.9795918, which is amazing and definitely meets the specification. The variance for manufacturing lot 2 is 7.4693878, which also meets this specification. However, the variance for manufacturing lot 3 is 170.2861224, which goes over by a significant amount. 

## T-Tests on Suspension Coils

For the t-test for all the manufacturing lots, the p-value was 0.06028, which is higher than the standard alpha level of 0.05, so we would say that the lots are not statistically different from the population mean.

For the lot 1 t-test, the p-value is 1. We would definitely say that lot 1 is not statistically different from the population mean.

For the lot 2 t-test, the p-value is 0.6072, which, again, is greater than the standard alpha, so it is not statistically different from the population mean.

Lastly, for the lot 3 t-test, the p-value is 0.04168, which is less than the alpha level, so it is statistically different from the population mean. 

## Study Design: MechaCar vs Competition

If I were to design my own study, I would want to analyze the whether the mean mpg was different between the MechaCar vs the competition. 
My hypothesis would be:
H0: The mean mpg is the same between the samples
HA: The mean mpg is not the same between the samples

I would be running a two-sample t-test to comapre the two brands. I would need data on the mpg of a sample of a large amount of vehicles from each of the brands.

From this test, I would be able to see if the two brands perform the same or not. 
