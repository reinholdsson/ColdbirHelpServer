
# Custom CSS
custom_css <- function(title, window_title = title){
  tagList(
    tags$head(
      tags$title(window_title),
      tags$link(rel="stylesheet", type="text/css",
                href="style.css")
    )
  )
}

shinyUI(bootstrapPage(

    includeHTML("www/js/tools.js"),
    custom_css("Coldbir"),    
    div(class = "path", (get_path(.CDB))),
        tabsetPanel(
            tabPanel("Variables",
                     
                div(class="row",
                    div(class="span7", 
                        selectInput(
                            inputId = "variable",
                            label = "",
                            choices = .UNIQUE_VARIABLES
                        ),
                        htmlOutput("docs")
                    ),

                    div(class="span4",
                        
                         plotOutput("charts", height = "250px", width = "300px"),
                         uiOutput("dimension"),
                         tableOutput("table"),
                        HTML("<i>Table only shows up to ten rows.</i>"),
                        downloadButton('downloadData', "Download Summary Statistics")
                        
                    )
                )
            ),
            tabPanel("Database",
                     HTML("Database information:"),
                     tableOutput("db_stats")
            )
    )
))