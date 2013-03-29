
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
    selectInput("variable", label = "", choices = v, selected = NULL, multiple = FALSE),
        
    div(class="row",
        div(class="span9", 
            htmlOutput("docs")
            #htmlOutput("freq_chart")
        ),
        div(class="span5",
            plotOutput("charts", height = "300px"),
            #htmlOutput("summary")
            htmlOutput("table")
        )
    )
))
