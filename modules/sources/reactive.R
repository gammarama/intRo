intro.start <- reactive({
    input$clearsubset
    
    data.initial <- data.module(input$data_own, input$data, input$own)
    values$mydat <<- data.initial
                
    return(data.initial)
})

intro.data <- reactive({
    if (is.null(intro.start())) return(NULL)
        
    intro.data <- values$mydat
    intro.random <- values$mydat_rand
    
    cat_and_eval(paste0("data.subset <- process_logical(intro.data, ", paste0("c(", paste(paste0("'", input$subs, "'"), collapse = ", "), ")"), ")"), file = "code_sources.R")
    cat_and_eval(paste0("intro.random <- data.subset"), file = "code_sources.R", append = TRUE)
        
    values$mydat <<- data.subset
    values$mydat_rand <<- values$mydat
    
    if (input$randomsub & is.numeric(input$randomsubrows) & input$randomsubrows >= 1 & input$randomsubrows <= nrow(values$mydat)) {
        cat_and_eval(paste0("intro.random <- dplyr::sample_n(data.subset, ", input$randomsubrows, ")"), file = "code_sources.R", append = TRUE)
    }
    
    if (input$savesubset > oldsavesub) {                
        cat_and_eval(paste0("intro.data <- intro.random"), file = "code_sources.R", append = TRUE)
        cat(paste(readLines(file.path(userdir, "code_sources.R")), collapse = "\n"), file = file.path(userdir, "code_All.R"), append = TRUE)
        
        values$mydat <<- values$mydat_rand
        oldsavesub <<- input$savesubset
    }
    
    return(intro.data)
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