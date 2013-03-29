require(rHighcharts)

# Connect to database
db <- cdb(.help_args$path, type = "f")

# Fetch all variables
list_vars <- vars(db)
list_vars <- setNames(as.list(list_vars), list_vars)

#sel_choices <- expand.grid(LETTERS,letters)
#sel_choices <- paste(sel_choices[,1],sel_choices[,2], sep="-")