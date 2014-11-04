x_choices <- reactive({
    if (input$plottype %in% c("boxplot", "barchart", "paretochart", "mosaicplot")) intro.categoricnames()
    else intro.numericnames()
})
    
y_choices <- reactive({
    if (input$plottype %in% c("mosaicplot")) intro.categoricnames()
    else intro.numericnames()
})

x_selected <- reactive({
    x_choices()[1]
})

y_selected <- reactive({
    y_choices()[2]
})

intro.plot <- reactive({
        if (is.null(intro.data())) return(NULL)
        
        mydat <- na.omit(intro.data())
        
        xvar <- if (checkVariable(intro.data(), input$x)) input$x else 1
        yvar <- if (checkVariable(intro.data(), input$y)) input$y else 2

        mydat$intro_x_cat <- factor(mydat[,xvar])
        mydat$intro_x_num <- as.numeric(mydat[,xvar])
        mydat$intro_y_cat <- factor(mydat[,yvar])
        mydat$intro_y_num <- as.numeric(mydat[,yvar])
        
        if (input$plottype == "paretochart") mydat$intro_x_cat <- factor(mydat$intro_x_cat, levels = names(sort(table(mydat$intro_x_cat), decreasing = TRUE)))
        
        return(mydat)
    })
    
    intro.quant <- reactive({
        if (is.null(intro.plot())) return(NULL)
        
        mydat <- intro.plot()
        
        yy <- quantile(mydat$intro_x_num, na.rm = TRUE, c(0.25, 0.75))
        xx <- qnorm(c(0.25, 0.75))
        slope <- diff(yy) / diff(xx)
        int <- yy[1] - slope * xx[1]
        
        mydat$intro_quant <- qnorm(seq(0, 1, by = (1/(length(mydat$intro_x_num) + 1)))[-c(1, (length(mydat$intro_x_num) + 2))])
        mydat$intro_x_num <- sort(mydat$intro_x_num)
        
        return(mydat)
    })
    
    input_binwidth <- reactive({
        if (is.na(input$binwidth)) NULL
        else input$binwidth
    })
    
    input_xdomain <- reactive({
        return(c(input$xmin, input$xmax))
    })
    
    input_ydomain <- reactive({
        return(c(input$ymin, input$ymax))
    })
