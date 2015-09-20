original_x <- reactive({input$var_trans})
new_x <- reactive({colname})

input_original_binwidth <- reactive({        
    return(input_trans_binwidthdata(input$original_binwidth))
})

input_trans_binwidth <- reactive({        
    return(input_trans_binwidthdata(input$trans_binwidth))
})

intro.transform <- reactive({
    if (is.null(intro.data())) return(NULL)
    
    colname <- ifelse(input$trans == "power", 
                      paste(input$var_trans, sub("\\.", "", input$power), sep = "_"), 
                      paste(input$var_trans, "trans", sep = "_"))
    
    intro_trans <- transform_data(intro.data(), input$trans, input$var_trans, input$power)
    
    intro_trans$intro_var <- if (input$trans == "power") intro_trans[,input$var_trans] else 0
    intro_trans$intro_trans_var <- if (input$trans == "power") intro_trans[,colname] else 0
    
    return(intro_trans)
})
