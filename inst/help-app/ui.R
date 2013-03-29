require(rHighcharts)

# Connect to database
db <- cdb(.help_args$path, type = "f")

# Fetch all variables
list_vars <- vars(db)
list_vars <- setNames(as.list(list_vars), list_vars)

# Interface
shinyUI(bootstrapPage(
    
    #headerPanel(""),
    
    #sidebarPanel(
        selectInput(inputId = "variable",
            label = "",
            choices = list_vars),
    #),
    
    #mainPanel(
        chart_js(),
        htmlOutput("docs"),
        htmlOutput("summary"),
        div(class="span6", htmlOutput("freq_chart")),
        div(class="span6", htmlOutput("na_chart"))
        #htmlOutput("freq_chart"),
        #htmlOutput("na_chart"),
        
        
    #)
))