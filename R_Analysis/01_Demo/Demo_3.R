x <- c(3, 3, 2, 2, 5, 5, 8, 8, 9)

# to select a single item from a vector
x[3]

# to select a single item from a matrix/data frame
demo_table[3,"Year"]
demo_table[3,3]

# to select a column from a data frame
demo_table$"Vehicle_Class"

# once we select the vector/column from the data frame, we can select a single item
demo_table$"Vehicle_Class"[2]

# to filter data where there are only rows where the vehicle price is greater than $10,000
# the comma at the end is necessary to subset by rows
filter_table <- demo_table2[demo_table2$price > 10000,]

# in this example, we get a vector of true/false statements
demo_table2$price > 10000

# we can also filter and subset using this function
?subset()
filter_table2 <- subset(demo_table2, price > 10000 & drive == "4wd" & "clean" %in% title_status) #filter by price and drivetrain

# to create our own sample we use
?sample()

sample(c("cow", "deer", "pig", "chicken", "duck", "sheep", "dog"), 4)


# to sample from a two dimensional data structure, we
num_rows <- 1:nrow(demo_table)

sample_rows <- sample(num_rows, 3)

demo_table[sample_rows,]

# to combine the previous three lines of code into one statements:
demo_table[sample(1:nrow(demo_table), 3),]
