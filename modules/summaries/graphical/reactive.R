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
    select = y_choices()[1]
    if (select == x_selected() && length(y_choices()) > 1) select = y_choices()[2]
    
    return(select)
})

    intro.plot <- reactive({
            if (is.null(intro.data())) return(NULL)
    
            return(intro.plotdata(intro.data(), input$x, input$y, input$plottype))
    })
    
    intro.quant <- reactive({
        if (is.null(intro.plot())) return(NULL)
        
        return(intro.quantdata(intro.plot()))
    })
    
    input_binwidth <- reactive({        
        return(input_binwidthdata(input$binwidth))
    })
    
    input_xdomain <- reactive({        
        return(input_xdomaindata(input$xmin, input$xmax))
    })
    
    input_ydomain <- reactive({        
        return(input_ydomaindata(input$ymin, input$ymax))
    })
