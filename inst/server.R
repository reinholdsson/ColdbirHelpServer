shinyServer(function(input, output) {

  data <- reactive({
    dims <- .VARIABLES[id == as.integer(input$dimension)]$dims[[1]]
    data <- .CDB[input$variable, dims]
    return(data)
  })
  
  summaryData <- reactive({
    x <- data()
    if (is.factor(x)) {
      x <- summary(x)
      x <- data.frame("Variable" = names(x), "N" = x)
    } else {
      stats <- c(
        "N" = length(x),
        "Min" = min(x, na.rm = TRUE),
        "Median" = median(x, na.rm = TRUE),
        "Mean" = mean(x, na.rm = TRUE),
        "Max" = max(x, na.rm = TRUE),
        "Sd" = sd(x, na.rm = TRUE),
        "NA's" = length(x[is.na(x)])
      )
      x <- data.frame("Measure" = names(stats), "Value" = stats)
    }
    return(x)
  })
  
  output$dimension <- renderUI({
    x <- .VARIABLES[variable == input$variable]
    dims <- x$id
    names(dims) <- x$dims_label
    
    selectInput("dimension", "", sort(dims, decreasing = T), selected = max(names(dims)))
  })
  
  output$charts <- renderPlot({
    
    x <- data()
    
    if (is.factor(x)) {
      x <- table(x)
      x <- as.data.frame(x)
      p <- ggplot(x) + geom_point(aes(x = x, y = Freq)) + coord_flip() + labs(title = "Frequency")
    } else {
      
      # Sample for large vectors
      if (length(x) > 100000) {
        x <- sample(x, 100000)
      }
      
      x <- data.table(x = x)
      p <- ggplot(x) + geom_density(aes(x = x), fill = "lightblue") + labs(title = "Density")
    }
    
    p <- p + xlab(NULL) + ylab(NULL) + theme_tufte() + theme(legend.position="none")
    print(p)
  })
  
  output$docs <- renderText({
    tryCatch(
      markdown::markdownToHTML(text = list_to_md(get_doc(.CDB, input$variable)), fragment.only = TRUE),
      error = function(e) "Documentation is missing!")
  })
  
  output$downloadData <- downloadHandler(
    filename = function() {
      paste('data-', Sys.Date(), '.csv', sep='')
    },
    content = function(file) {
      write.csv2(summaryData(), file, row.names = F)
    }
  )
  
  output$table <- renderGvis({
    gvisTable(summaryData(), options = list(width = "300px", page = "enable", height = "300px"))
  })

})