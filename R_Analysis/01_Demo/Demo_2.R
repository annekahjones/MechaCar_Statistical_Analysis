# to understand what a function does, use this notation
?read.csv()
# read.csv() is for comma-delimited files
# read.delim() is for tab-delimited files
# read.table() is for when we need to manually tell the function what delimiter to use

# let's read in a CSV file
demo_table <- read.csv(file='demo.csv',check.names=F,stringsAsFactors = F)

library(jsonlite)

?fromJSON()

# let's read in a JSON file
demo_table2 <- fromJSON(txt='demo.json')
