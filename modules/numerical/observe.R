    observe({
        updateSelectizeInput(session, "grouping", choices = c("None" = "none", names(intro.data())))
        updateSelectizeInput(session, "tblvars", choices = names(intro.data()))
    })
    
    observeEvent(input$store_Numerical, {
        cat(paste(readLines("code_Numerical.R"), collapse = "\n"), file = "code_All.R", append = TRUE)
    })
