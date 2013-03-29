
# Interface
shinyUI(bootstrapPage(
    #headerPanel('Select2shiny'),
    
    #sidebarPanel(
        includeHTML("www/js/tools.js"),
        
        div(class="row",
            div(class="span3",
                selectInput("variable", label = "Select variable:", choices = list_vars, selected = NULL, multiple = FALSE)
            ),
            div(class="span6", 
                htmlOutput("docs")
                #htmlOutput("freq_chart")
            ),
            div(class="span5",
                plotOutput("charts", height = "500px"),
                #htmlOutput("summary")
                htmlOutput("table")
            )
        )
))
