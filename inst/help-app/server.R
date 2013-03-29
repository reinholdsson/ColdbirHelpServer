require(markdown)
require(hwriter)
require(data.table)
require(rHighcharts)

# Connect to database
db <- cdb(.help_args$path, type = "f")

shinyServer(function(input, output) {
    
    output$freq_chart <- renderChart({
        ch <- rHighcharts:::Chart$new()
        ch$title(text = "Frequency")
        ch$subtitle(text = "NA's are removed from variable")
        ch$yAxis(title = list(text = NULL))
        ch$legend(enabled = FALSE)
        
        x <- db[input$variable]
        
        x <- x[!is.na(x)]  # remove na
        
        if(is.factor(x)) {
            freq <- table(x)
            ch$xAxis(categories = names(freq))  # keep names
            freq <- freq
            ch$data(as.integer(freq), type = "bar", name = "N")
            ch$plotOptions(bar = list(groupPadding = 0))
        } else {
            if (length(unique(x)) > 25) {
                breaks <- round(seq(min(x), max(x), length.out = 11), digits = 0)  # breaks
                
                # Prepare freq names
                freq_names <- NULL
                for(i in 1:(length(breaks)-1)) {
                    freq_names[i] <- paste(breaks[i], breaks[i+1], sep = " - ")  #mean(c(breaks[i], breaks[i + 1]))
                }
                
                freq <- table(cut(x, breaks))
                names(freq) <- freq_names
            } else {
                freq <- table(x)
            }
            ch$xAxis(categories = names(freq))  # keep names
            
            ch$data(as.integer(freq), type = "column", name = "N")
            ch$plotOptions(column = list(groupPadding = 0))
        }

        return(ch)
    })
    
    output$stat_chart <- renderChart({
        
        ch <- rHighcharts:::Chart$new()
        x <- db[input$variable]
        
        if (is.factor(x)) {
            
            x <- x[!is.na(x)]  # remove na
            
            ch$title(text = "Top 5")
            ch$yAxis(title = list(text = NULL))
            ch$legend(enabled = FALSE)
            ch$chart(type = "column")
            ch$colors("lightgrey")
            
            freq <- table(x)
            ch$xAxis(categories = names(freq))
            freq <- head(sort(freq, decreasing = TRUE), 5)
            ch$data(as.integer(freq), name = "N")
            #ch$plotOptions( = list(groupPadding = 0))
            
        } else {
        
            ch$title(text = "Summary statistics")
            ch$yAxis(title = list(text = NULL))
            ch$legend(enabled = FALSE)
            ch$chart(type = "column")
            ch$colors("lightgreen")

            stats <- c(
                "Min" = min(x, na.rm = TRUE), 
                "Median" = median(x, na.rm = TRUE), 
                "Mean" = mean(x, na.rm = TRUE), 
                "Max" = max(x, na.rm = TRUE)
                )
            
            ch$data(as.double(stats), name = "Value")
            ch$xAxis(categories = names(stats))
        }

        return(ch)
    })
    
    output$n_chart <- renderChart({
        ch <- rHighcharts:::Chart$new()
        ch$title(text = "Number of observations")
        ch$yAxis(title = list(text = NULL))
        ch$legend(enabled = FALSE)
        ch$chart(type = "column")
        ch$colors("lightblue")

        x <- db[input$variable]

        stats <- c(
            "NA" = length(x[is.na(x)]), 
            "Non-NA" = length(x[!is.na(x)]), 
            "N" = length(x)
        )

        ch$data(as.integer(stats), name = "Value")
        ch$xAxis(categories = names(stats))  # keep names

        return(ch)
    })
    
    output$docs <- renderText({
        markdown::markdownToHTML(text = list_to_md(get_doc(db, input$variable)), fragment.only = TRUE)
    })
    
    output$summary <- renderText({
        x <- db[input$variable]
        if (is.factor(x)) {
            paste("<b>Levels:</b> ", paste(levels(x), collapse = ", "))
        } else {
            s <- summary(x)
            m <- matrix(s, nr = 1)
            colnames(m) <- names(s)
            hwrite(m, border = 0, cellpadding = 5)
        }
    })
})
