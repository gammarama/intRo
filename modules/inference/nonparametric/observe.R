    observe({
        updateSelectizeInput(session, "group1_non", choices = intro.numericnames(), selected = ifelse(checkVariable(intro.data(), input$group1_non), input$group1_non, intro.numericnames()[1]))
        updateSelectizeInput(session, "group2_non", choices = intro.numericnames(), selected = ifelse(checkVariable(intro.data(), input$group2_non), input$group2_non, intro.numericnames()[2]))
    })
    
    observeEvent(input$store_nonparametric, {
        cat(paste0("\n\n", paste(readLines(file.path(userdir, "code_nonparametric.R")), collapse = "\n")), file = file.path(userdir, "code_All.R"), append = TRUE)
    })
