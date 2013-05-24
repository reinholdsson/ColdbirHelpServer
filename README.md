# Coldbir Help Server

![](https://dl.dropboxusercontent.com/u/2904328/ColdbirHelpServer.png)

To be used with the [Coldbir](https://github.com/SthlmR/Coldbir) package (>= v0.3).

E.g:

    library(Coldbir)
    library(ColdbirHelpServer)

    # Database connection
    a <- cdb()
    
    # Add data
    a["Age"] <- MASS::survey$Age
    
    # Add documentation
    a["Age"] <- doc(title = "Age of the student in years", description = "...")
    
    # Show help
    ?a

And then it starts up a [Shiny](http://www.rstudio.com/shiny/) server and shows an interactive page showing documentation and other information available in the database. 
For an example, see: [http://glimmer.rstudio.com/reinholdsson/help-app-demo/](http://glimmer.rstudio.com/reinholdsson/help-app-demo/).
