?ggplot()

# familiarize yourself with the dataset
head(mpg)
mpg
# create a bar plot that represents the distribution of vehicle classes from the 
# mpg dataset
plt <- ggplot(mpg,aes(x=class)) #import dataset into ggplot2
plt + geom_bar() #plot a bar plot

# learn more about the documentation
?geom_bar()

# we can compare and contrast categorical results, like here where we compare the 
# number fo vehicles from each manufacturer in the dataset
mpg_summary <- mpg %>% group_by(manufacturer) %>% summarize(Vehicle_Count=n(), .groups = 'keep') #create summary table
plt <- ggplot(mpg_summary,aes(x=manufacturer,y=Vehicle_Count)) #import dataset into ggplot2
plt + geom_col() #plot a bar plot

# the difference is geom_bar() expects one variable and generates frequency data
# geom_col() expects two variables where we provide the size of each bar's category


# to change the axis titles
plt + geom_col() + xlab("Manufacturing Company") + ylab("Number of Vehicles in Dataset") #plot bar plot with labels

# to rotate the x-axis labels to 45 degrees
plt + geom_col() + xlab("Manufacturing Company") + ylab("Number of Vehicles in Dataset") + theme(axis.text.x=element_text(angle=45,hjust=1)) #rotate the x-axis label 45 degrees
  
# line plots

# if we want to compare the difference in average highway fuel economy of Toyota 
# vehicles as a function of the different cylinder sizes
mpg_summary <- subset(mpg,manufacturer=="toyota") %>% group_by(cyl) %>% summarize(Mean_Hwy=mean(hwy), .groups = 'keep') #create summary table
plt <- ggplot(mpg_summary,aes(x=cyl,y=Mean_Hwy)) #import dataset into ggplot2
plt + geom_line()

# we want to adjust the axes
plt + geom_line() + scale_x_discrete(limits=c(4,6,8)) + scale_y_continuous(breaks = c(16:30)) #add line plot with labels

# to create a scatter plot to visualize the the relationship between the size of each car
# engine versus their city fuel efficiency 
plt <- ggplot(mpg,aes(x=displ,y=cty)) #import dataset into ggplot2

# now that we created our object, create our scatter plot
plt + geom_point() + xlab("Engine Size (L)") + ylab("City Fuel-Efficiency (MPG)") #add scatter plot with labels

# we can group by additional variables of interest
plt <- ggplot(mpg,aes(x=displ,y=cty,color=class)) #import dataset into ggplot2
plt + geom_point() + labs(x="Engine Size (L)", y="City Fuel-Efficiency (MPG)", color="Vehicle Class") #add scatter plot with labels

# we are not limited to grouping by one aesthetic either
plt <- ggplot(mpg,aes(x=displ,y=cty,color=class,shape=drv)) #import dataset into ggplot2
plt + geom_point() + labs(x="Engine Size (L)", y="City Fuel-Efficiency (MPG)", color="Vehicle Class",shape="Type of Drive") #add scatter plot with multiple aesthetics

# use city-fuel efficiency to determine the size of the data point
plt <- ggplot(mpg,aes(x=displ,y=cty,color=class,shape=drv,size=cty)) #import dataset into ggplot2
plt + geom_point() + labs(x="Engine Size (L)", y="City Fuel-Efficiency (MPG)", color="Vehicle Class",shape="Type of Drive", size="City Fuel Efficiency") #add scatter plot with multiple aesthetics

# a good rule of thumb is to limit the number of variables displayed in a single figure to 3 or 4

# generate a boxplot to visualize the highway fuel efficiency of our mpg dataset
plt <- ggplot(mpg,aes(y=hwy)) #import dataset into ggplot2
plt + geom_boxplot() #add boxplot

# if we want to create a set of boxplots that compares the highway fuel efficiency 
# for each car manufacturer
plt <- ggplot(mpg,aes(x=manufacturer,y=hwy, color=manufacturer)) #import dataset into ggplot2
plt + geom_boxplot(linetype = "dotted") + theme(axis.text.x=element_text(angle=45,hjust=1)) #add boxplot and rotate x-axis labels 45 degrees

# create a heatmap plot to visualize the average highway fuel efficiency across 
# the type of vehicle class from 1999 to 2008
mpg_summary <- mpg %>% group_by(class,year) %>% summarize(Mean_Hwy=mean(hwy), .groups = 'keep') #create summary table
plt <- ggplot(mpg_summary, aes(x=class,y=factor(year),fill=Mean_Hwy))
plt + geom_tile() + labs(x="Vehicle Class",y="Vehicle Year",fill="Mean Highway (MPG)") #create heatmap with labels

# we use heatmaps to view large trends in a dataset

# we can use a heatmap to view the difference in average highway fuel efficiency 
# across each vehicle model from 1999 to 2008
mpg_summary <- mpg %>% group_by(model,year) %>% summarize(Mean_Hwy=mean(hwy), .groups = 'keep') #create summary table
plt <- ggplot(mpg_summary, aes(x=model,y=factor(year),fill=Mean_Hwy)) #import dataset into ggplot2
plt + geom_tile() + labs(x="Model",y="Vehicle Year",fill="Mean Highway (MPG)") + theme(axis.text.x = element_text(angle=90,hjust=1,vjust=.5)) #rotate x-axis labels 90 degrees#add heatmap with labels > 

# Plot layering

# there are two types of plot layers
# 1) Layering additional plots that use the same variables and input data as the original plot
# 2) Layering of additional plots that use different but complementary data to the original plot

# Recreate our boxplot example while layering our data points over it
plt <- ggplot(mpg,aes(x=manufacturer,y=hwy)) #import dataset into ggplot2
plt + geom_boxplot() + theme(axis.text.x=element_text(angle=45,hjust=1)) + geom_point() #overlay scatter plot on top

# a new map for mapping and to compare average engine size for each vehicle class (?)
mpg_summary <- mpg %>% group_by(class) %>% summarize(Mean_Engine=mean(displ), .groups = 'keep') #create summary table
plt <- ggplot(mpg_summary,aes(x=class,y=Mean_Engine)) #import dataset into ggplot2
plt + geom_point(size=4) + labs(x="Vehicle Class",y="Mean Engine Size") #add scatter plot

# it's important to include standard deviation though
mpg_summary <- mpg %>% group_by(class) %>% summarize(Mean_Engine=mean(displ),SD_Engine=sd(displ), .groups = 'keep')
plt <- ggplot(mpg_summary,aes(x=class,y=Mean_Engine)) #import dataset into ggplot2
plt + geom_point(size=4) + labs(x="Vehicle Class",y="Mean Engine Size") + geom_errorbar(aes(ymin=Mean_Engine-SD_Engine,ymax=Mean_Engine+SD_Engine)) #overlay with error bars

# layering is good for wide-format data when there are multiple variables and metrics to describe one subject

# Consider, if instead of the wide format, our mpg dataset was obtained where 
# city and highway fuel efficiency data was provided in a long format
mpg_long <- mpg %>% gather(key="MPG_Type",value="Rating",c(cty,hwy)) #convert to long format
head(mpg_long)

# If we want to visualize the different vehicle fuel efficiency ratings by manufacturer
plt <- ggplot(mpg_long,aes(x=manufacturer,y=Rating,color=MPG_Type)) #import dataset into ggplot2
plt + geom_boxplot() + theme(axis.text.x=element_text(angle=45,hjust=1)) #add boxplot with labels rotated 45 degrees


# Learn about facet_wrap()
?facet_wrap()

# To facet our previous example by the fuel-efficiency type
plt <- ggplot(mpg_long,aes(x=manufacturer,y=Rating,color=MPG_Type)) #import dataset into ggplot2
plt + geom_boxplot() + facet_wrap(vars(MPG_Type)) + theme(axis.text.x=element_text(angle=45,hjust=1),legend.position = "none") + xlab("Manufacturer") #rotate x-axis labels

# Use transmission in facet_wrap()
plt <- ggplot(mpg_long,aes(x=manufacturer,y=Rating,color=trans)) #import dataset into ggplot2
plt + geom_boxplot() + facet_wrap(vars(trans)) + theme(axis.text.x=element_text(angle=45,hjust=1),legend.position = "none") + xlab("Manufacturer") #rotate x-axis labels

# Use class in facet_wrap()
plt <- ggplot(mpg_long,aes(x=manufacturer,y=Rating,color=class)) #import dataset into ggplot2
plt + geom_boxplot() + facet_wrap(vars(class)) + theme(axis.text.x=element_text(angle=45,hjust=1),legend.position = "none") + xlab("Manufacturer") #rotate x-axis labels

# Use transmission and class in facet_wrap()
plt <- ggplot(mpg_long,aes(x=manufacturer,y=Rating,color=MPG_Type)) #import dataset into ggplot2
plt + geom_boxplot() + facet_wrap(vars(trans, class)) + theme(axis.text.x=element_text(angle=45,hjust=1),legend.position = "none") + xlab("Manufacturer") #rotate x-axis labels
# ^^^^^^ this makes the graph unintelligible





