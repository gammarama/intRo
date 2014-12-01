    observe({
        updateSelectizeInput(session, "xcont", choices = intro.categoricnames(), selected = ifelse(checkVariable(intro.data(), input$xcont), input$xcont, intro.categoricnames()[1]))
        updateSelectizeInput(session, "ycont", choices = intro.categoricnames(), selected = ifelse(checkVariable(intro.data(), input$ycont), input$ycont, intro.categoricnames()[2]))
    })
    
    observeEvent(input$store_contingency, {
        cat(paste0("\n\n", paste(readLines(file.path(tempdir(), "code_contingency.R")), collapse = "\n")), file = file.path(tempdir(), "code_All.R"), append = TRUE)
    })
