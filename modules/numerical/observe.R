    observe({
        updateSelectizeInput(session, "grouping", choices = c("None" = "none", names(intro.data())))
    })
    
    observe({
        updateSelectizeInput(session, "tblvars", choices = (if (input$grouping == "none") names(intro.data()) else intro.numericnames()))
    })
    
    observeEvent(input$store_numerical, {
        cat(paste0("\n\n", paste(readLines(file.path(userdir, "code_numerical.R")), collapse = "\n")), file = file.path(userdir, "code_All.R"), append = TRUE)
    })
