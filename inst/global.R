require(rHighcharts)

# Connect to database
db <- cdb(.help_args$path, type = "f")

# Fetch all variables
v <- vars(db)

col <- "title"  # title name in documentation
v_names <- sapply(v, function(x) {
    title <- tryCatch(get_doc(db, x)[[col]], error = function(e) NULL)
    if (is.null(title)) {
        title <- x 
    } else {
        title <- paste(title, " (", x, ")", sep = "")
    }
    return(title)
})

v <- setNames(as.list(v), v_names)

#sel_choices <- expand.grid(LETTERS,letters)
#sel_choices <- paste(sel_choices[,1],sel_choices[,2], sep="-")