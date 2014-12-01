    observe({
        updateSelectizeInput(session, "group1", choices = intro.numericnames(), selected = ifelse(checkVariable(intro.data(), input$group1), input$group1, intro.numericnames()[1]))
        updateSelectizeInput(session, "group2", choices = intro.numericnames(), selected = ifelse(checkVariable(intro.data(), input$group2), input$group2, intro.numericnames()[2]))
    })
    
    observeEvent(input$store_t_test, {
        cat(paste0("\n\n", paste(readLines(file.path(userdir, "code_t_test.R")), collapse = "\n")), file = file.path(userdir, "code_All.R"), append = TRUE)
    })
