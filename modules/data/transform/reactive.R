input_original_binwidth <- reactive({        
    return(input_trans_binwidthdata(input$original_binwidth))
})

input_trans_binwidth <- reactive({        
    return(input_trans_binwidthdata(input$trans_binwidth))
})

intro.transform <- reactive({
    if (is.null(intro.data())) return(NULL)
    
    colname <- ifelse(input$trans == "power", 
                      paste(input$var_trans, sub("\\.", "", ifelse(input$power == 0, "log", input$power)), sep = "_"), 
                      paste(input$var_trans, "trans", sep = "_"))
    
    intro_trans <- as.data.frame(transform_data(intro.data(), input$trans, input$var_trans, colname = colname, method = input$categorical_method, intervals = input$categorical_intervals, power = input$power, logbase = input$log_base))
    intro_trans$intro_var <- if (input$trans == "power" && input$var_trans %in% numericNames(intro.data())) intro_trans[,input$var_trans] else 0
    intro_trans$intro_trans_var <- if (input$trans == "power" && input$var_trans %in% numericNames(intro.data())) intro_trans[,colname] else 0
    
    return(intro_trans)
})
