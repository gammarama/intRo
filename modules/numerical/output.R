    output$summary <- renderPrint({
        if (is.null(input$tblvars)){
            return(NULL)    
        } else if (input$grouping == "none") {
            return(summary(intro.data()[,input$tblvars]))
        } else {
            dat <- intro.data()[,input$tblvars]
            dat$intro_grouping <- intro.data()[,input$grouping]
            
            dat.dplyr <- dat[,names(dat) %in% c("intro_grouping", numericNames(dat))] %>% group_by(intro_grouping) %>% summarise_each(funs(min, q1, median, q3, max, mean, sd))
            dat.dplyr.df <- as.data.frame(dat.dplyr)
            names(dat.dplyr.df)[1] <- input$grouping
            
            return(dat.dplyr.df)
        }
    })