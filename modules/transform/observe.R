    observe({
        updateSelectizeInput(session, "var_trans", choices = (if (input$trans %in% c("power", "categorical")) numericNames(intro.data()) else categoricNames(intro.data())))
    })
    
    observe({
        updateSelectizeInput(session, "trans", choices = (if (numericNames(intro.data())[1] == "") c("Numeric" = "numeric") else if (categoricNames(intro.data())[1] == "") c("Power" = "power", "Categorical" = "categorical") else c("Power" = "power", "Categorical" = "categorical", "Numeric" = "numeric")))
    })
    
    observeEvent(input$savetrans, {
        values$data <- intro.transform() %>% select(-intro_var, -intro_trans_var)
        cat(paste0("\n\n", paste(readLines(file.path(userdir, "code_transform.R")), collapse = "\n")), file = file.path(userdir, "code_All.R"), append = TRUE)
    })
