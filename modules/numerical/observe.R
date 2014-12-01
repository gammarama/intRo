    observe({
        updateSelectizeInput(session, "grouping", choices = c("None" = "none", names(intro.data())))
        updateSelectizeInput(session, "tblvars", choices = names(intro.data()))
    })
    
    observeEvent(input$store_numerical, {
        cat(paste0("\n\n", paste(readLines(file.path(tempdir(), "code_numerical.R")), collapse = "\n")), file = file.path(tempdir(), "code_All.R"), append = TRUE)
    })
