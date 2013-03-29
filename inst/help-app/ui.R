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
        
    #),
    
    #mainPanel(
        chart_js(),
        div(class="row",
            div(class="span1",
                radioButtons(inputId = "variable",
                            label = "",
                            choices = list_vars)
            ),
            div(class="span6", 
                htmlOutput("docs")
                #htmlOutput("freq_chart")
                ),
            div(class="span4",
                htmlOutput("stat_chart"),
                htmlOutput("n_chart")
            )
        )
        #htmlOutput("freq_chart"),
        #htmlOutput("na_chart"),
        
        
    #)
))