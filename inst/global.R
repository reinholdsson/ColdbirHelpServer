library(reshape2)
library(ggplot2)
library(data.table)
library(Coldbir)
library(googleVis)
require(ggthemes)
require(markdown)

.CDB <- cdb(.help_args$path, type = "f")
#.CDB <- cdb("~/Desktop/testdb/", type = "f")

.VARIABLES <- get_vars(.CDB, dims = T)
.VARIABLES[ , dims_label := as.character(dims)]
.VARIABLES$id <- rownames(.VARIABLES)

.UNIQUE_VARIABLES <- unique(.VARIABLES$variable)

# Add variable names from documentation
col <- "title" # title name in documentation
v_names <- sapply(.UNIQUE_VARIABLES, function(x) {
  title <- tryCatch(get_doc(.CDB, x)[[col]], error = function(e) NULL)
  if (is.null(title)) {
    title <- x
  } else {
    title <- paste(title, " (", x, ")", sep = "")
  }
  return(title)
})

# Choices for selectInput input.variable
.UNIQUE_VARIABLES <- setNames(as.list(.UNIQUE_VARIABLES), v_names)
v_names <- NULL
