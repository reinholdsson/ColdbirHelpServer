
# Custom CSS
custom_css <- function(title, window_title = title){
    tagList(
        tags$head(
            tags$title(window_title),
            tags$link(rel="stylesheet", type="text/css",
                      href="style.css"),
            tags$style(type="text/css", '#variable { width:500px; }')
        )
    )
}

# Interface
shinyUI(bootstrapPage(

    # Include javascript files
    includeHTML("www/js/tools.js"),
    
    # CSS styling
    custom_css("Coldbir Help Server"),

    # Input
    selectInput("variable", label = "Select variable:", choices = v, selected = NULL, multiple = FALSE),
        
    div(class="row",
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
