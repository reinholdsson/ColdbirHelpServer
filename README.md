# Coldbir Help Server

Use it with the Coldbir cdb class.

E.g:

    # Database connection
    a <- cdb()
    
    # Add data
    a["Age"] <- MASS::survey$Age
    
    # Add documentation
    a["Age"] <- doc(title = "Age of the student in years", description = "...")
    
    # Show help
    ?a

And then it starts up a shiny server and shows an interactive page showing documentation and other information available in the database. For an example, see: [http://glimmer.rstudio.com/reinholdsson/help-app-demo/](http://glimmer.rstudio.com/reinholdsson/help-app-demo/).