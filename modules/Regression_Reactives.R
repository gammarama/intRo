regression_react <- function(data, input) {
    intro.regression <- reactive({
        if (is.null(data)) return(NULL)
        cat(input$yreg)
        cat(names(data))
        lm.fit <- lm(data[,input$yreg] ~ data[,input$xreg])
        
#         if (input$saveresid > oldsaveresid) {
#             curxreg <- input$xreg
#             curyreg <- input$yreg
#             
#             values$mydat <<- savefit(data, input$xreg, input$yreg, lm.fit)
#             
#             oldsaveresid <<- input$saveresid
#         }
        
        return(lm.fit)
    })
    
    reg.data <- reactive({
        if (is.null(intro.regression())) return(NULL)
        
        reg.data <- data
        reg.data$xreg <- reg.data[,input$xreg]
        reg.data$yreg <- reg.data[,input$yreg]
        
        return(reg.data)
    })
    
    reg.resid1 <- reactive({
        if (is.null(intro.regression())) return(NULL)
        
        mydat <- data.frame(residuals = resid(intro.regression()), x = data[as.numeric(names(resid(intro.regression()))),input$xreg])
        
        return(mydat)
    })
    
    reg.resid2 <- reactive({
        if (is.null(intro.regression())) return(NULL)
        
        myresid <- resid(intro.regression())
        
        yy <- quantile(myresid, na.rm = TRUE, c(0.25, 0.75))
        xx <- qnorm(c(0.25, 0.75))
        slope <- diff(yy) / diff(xx)
        int <- yy[1] - slope * xx[1]
        
        mydat <- data.frame(yy = qnorm(seq(0, 1, by = (1/(length(na.omit(myresid)) + 1)))[-c(1, (length(na.omit(myresid)) + 2))]),
                            residuals = sort(myresid))
        
        return(mydat)
    })
    
    return(list(intro.regression = intro.regression, reg.data = reg.data, reg.resid1 = reg.resid1, reg.resid2 = reg.resid2))
}
