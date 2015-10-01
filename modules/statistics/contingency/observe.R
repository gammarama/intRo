    observe({
        xselect <- ifelse(checkVariable(intro.data(), input$xcont), input$xcont, intro.categoricnames()[1])
        yselect <- ifelse(checkVariable(intro.data(), input$ycont), input$ycont, intro.categoricnames()[2])
        
        updateSelectizeInput(session, "xcont", choices = setdiff(intro.categoricnames(), yselect), selected = xselect)
        updateSelectizeInput(session, "ycont", choices = setdiff(intro.categoricnames(), xselect), selected = yselect)
    })
    
    observeEvent(input$store_contingency, {
        cat(paste0("\n\n", paste(readLines(file.path(userdir, "code_contingency.R")), collapse = "\n")), file = file.path(userdir, "code_All.R"), append = TRUE)
    })
