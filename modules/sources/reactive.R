intro.start <- reactive({
    input$clearsubset
    
    intro.inputs <- list(input$data_own, input$data, input$own)
    get_code(data.module, intro.inputs)
    
    #intro.inputs[[grep("intro.", intro.inputs)]] <- get(intro.inputs[[grep("intro.", intro.inputs)]])()
    result <- do.call(data.module, intro.inputs)
    
    data.initial <- do.call(data.module, intro.inputs)
            
    values$mydat <<- data.initial
                
    return(data.initial)
})

intro.data <- reactive({
    if (is.null(intro.start())) return(NULL)
    
    data.subset <- process_logical(values$mydat, input$subs)
    values$mydat <<- data.subset
    values$mydat_rand <<- values$mydat
    
    if (input$randomsub & is.numeric(input$randomsubrows) & input$randomsubrows >= 1 & input$randomsubrows <= nrow(values$mydat)) {
        values$mydat_rand <<- dplyr::sample_n(values$mydat, input$randomsubrows)
    }
    
    if (input$savesubset > oldsavesub) {
        values$mydat <<- values$mydat_rand
        oldsavesub <<- input$savesubset
    }
    
    return(values$mydat)
})

intro.numericnames <- reactive({
    if (is.null(intro.data())) return(NULL)
    
    return(numericNames(intro.data()))
})

intro.categoricnames <- reactive({
    if (is.null(intro.data())) return(NULL)
    
    return(categoricNames(intro.data()))
}) 

dt.options <- reactive({list(pageLength = 10,
                             searching=0,
                             destroy=1,
                             headerCallback =  I(paste0("function(thead, data, start, end, display) {
                                                        //color code the header items
                                                        var col_types = [", 
                                                        paste(paste0("'", ifelse(grepl("factor", whatis(intro.data())$type), "categorical", ifelse(grepl("character", whatis(intro.data())$type), "categorical", "numeric")),"'"),
                                                              collapse=", "),
                                                        "]
                                                        var headers = $(thead).find('th');
                                                        
                                                        for(i = 0; i < col_types.length; i++) {
                                                        if(col_types[i] == 'categorical') headers[i].style.color = '#95a5a6';
                                                        else headers[i].style.color = '#3498db';
                                                        }
                                                        
                                                        if($('.dataTables_length').parent().next().find('span').length == 0) $('.dataTables_length').parent().next().append('<div, style=\"float:right\"><span style=\"color:#95a5a6\">Categorical Variable</span><span style=\"color:#3498db\">     Numeric Variable</span></div>')
}")))})