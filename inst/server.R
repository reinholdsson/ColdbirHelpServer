require(markdown)
require(hwriter)
require(data.table)
require(ggplot2)
require(gridExtra)
require(ggthemes)
require(googleVis)

shinyServer(function(input, output) {
    
    output$table <- renderGvis({
        x <- db[input$variable]
        
        if (is.factor(x)) {
            x <- summary(x)
            x <- data.frame("Variable" = names(x), "N" = x)
        } else {
            stats <- c(
                "Min" = min(x, na.rm = TRUE), 
                "Median" = median(x, na.rm = TRUE), 
                "Mean" = mean(x, na.rm = TRUE), 
                "Max" = max(x, na.rm = TRUE)
            )
            x <- data.frame("Measure" = names(stats), "Value" = stats)
        }
        gvisTable(x, options = list(width = "100%", page = "enable"))
    })
    
    output$charts <- renderPlot({
        
        x <- db[input$variable]

        if (is.factor(x)) {
            x <- table(x)
            x <- as.data.frame(x)
            x <- x[with(x, order(-Freq)), ]
            x <- head(x, 10)
            
            p <- ggplot(x) + geom_bar(aes(x = reorder(x, Freq), y = Freq), fill = "lightblue") + coord_flip() + labs(title = "Frequency (top 10)")
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
    
#     output$freq <- renderPlot({
#         hist(db[input$variable])
#     })    
    
    output$docs <- renderText({
        markdown::markdownToHTML(text = list_to_md(get_doc(db, input$variable)), fragment.only = TRUE)
    })
    
    output$summary <- renderText({
        x <- db[input$variable]
        if (is.factor(x)) {
            paste("<b>Levels:</b> ", paste(levels(x), collapse = ", "))
        } else {

            stats <- c(
                "Min" = min(x, na.rm = TRUE), 
                "Median" = median(x, na.rm = TRUE), 
                "Mean" = mean(x, na.rm = TRUE), 
                "Max" = max(x, na.rm = TRUE)
            )
            
            x <- data.frame("Measure" = names(stats), "Value" = stats)
            
            hwrite(m, border = 0, cellpadding = 5)
        }
    })
})
