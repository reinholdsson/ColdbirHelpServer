require(shiny)
require(Coldbir)
require(ColdbirHelpServer)
require(markdown)
require(data.table)
require(ggplot2)
require(ggthemes)
require(googleVis)

# Connect to database
db <- cdb(.help_args$path, type = "f")

# Fetch all variables
v <- get_vars(db)

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

# Choices for selectInput input.variable
sel_input_v <- setNames(as.list(v), v_names)

# Dims
d <- sapply(v, function(x) {
    get_dims(db, x)
})
# d[["dim1"]][[2]]
