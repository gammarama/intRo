    observe({
        updateSelectizeInput(session, "var_trans", choices = (if (input$trans %in% c("power", "categorical")) numericNames(intro.data()) else categoricNames(intro.data())))
    })
    
    observe({
        updateSelectizeInput(session, "trans", choices = (if (numericNames(intro.data())[1] == "") c("To Numeric" = "numeric") else if (categoricNames(intro.data())[1] == "") c("Power" = "power", "To Categorical" = "categorical") else c("Power" = "power", "To Categorical" = "categorical", "To Numeric" = "numeric")))
    })
    
    observeEvent(input$savetrans, {
        values$data <- intro.transform() %>% select(-intro_var, -intro_trans_var)
        cat(paste0("\n", paste(c(readLines(file.path(userdir, "code_transform.R")), "\n"), collapse = "\n")), file = file.path(userdir, "code_All.R"), append = TRUE)
    })
