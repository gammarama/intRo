scatterplotreg <- function (data, x, y)  {
    lm.fit <- lm(data[,y] ~ data[,x])

    all_values <- function(x) {
        if (is.null(x)) return(NULL)
        paste0(names(x), ": ", format(x), collapse = "<br />")
    }
    
    data %>%
        ggvis(x = as.name(x), y = as.name(y)) %>%
        layer_points() %>%
        layer_model_predictions(model = "lm") %>%
        add_tooltip(all_values, "hover")
}

tablereg <- function (data, x, y) {
    lm.fit <- lm(data[,y] ~ data[,x])
    
    tbl.fit <- coef(summary(lm.fit))
    rownames(tbl.fit)[2] <- x
    
    return(tbl.fit)
}

r <- function (data, x, y) {
    return(paste("r =", round(cor(data[,y], data[,x], use = "complete.obs"), digits = 4)))
}

r2 <- function (data, x, y) {
    lm.fit <- lm(data[,y] ~ data[,x])
    
    return(paste("R^2 =", round(summary(lm.fit)$r.squared, digits = 4)))
}

residualreg1 <- function (data, x, y) {
    lm.fit <- lm(data[,y] ~ data[,x])
    
    mydat <- data.frame(residuals = resid(lm.fit), x = data[as.numeric(names(resid(lm.fit))),x])
    names(mydat)[2] <- x
    
    all_values <- function(x) {
        if (is.null(x)) return(NULL)
        paste0(names(x), ": ", format(x), collapse = "<br />")
    }
            
    mydat %>%
        ggvis(x = as.name(x), y = as.name("residuals")) %>%
        layer_points() %>%
        add_tooltip(all_values, "hover") %>%
        set_options(width = 200, height = 200)
}

residualreg2 <- function (data, x, y) {
    lm.fit <- lm(data[,y] ~ data[,x], na.action = na.exclude)
    data$residuals <- resid(lm.fit)
    
    yy <- quantile(data$residuals, na.rm = TRUE, c(0.25, 0.75))
    xx <- qnorm(c(0.25, 0.75))
    slope <- diff(yy) / diff(xx)
    int <- yy[1] - slope * xx[1]
    
    all_values <- function(x) {
        if (is.null(x)) return(NULL)
        paste0(names(x), ": ", format(x), collapse = "<br />")
    }
    
    mydat <- data.frame(yy = qnorm(seq(0, 1, by = (1/(length(na.omit(data$residuals)) + 1)))[-c(1, (length(na.omit(data$residuals)) + 2))]),
                        residuals = sort(data$residuals))

    mydat %>%
        ggvis(x = as.name("yy"), y = as.name("residuals")) %>%
        layer_points() %>%
        add_tooltip(all_values, "hover") %>%
        set_options(width = 200, height = 200)
}

residualreg3 <- function (data, x, y) {
    lm.fit <- lm(data[,y] ~ data[,x])
    mydat <- data.frame(residuals = resid(lm.fit))
    
    mydat %>%
        ggvis(x = as.name("residuals")) %>%
        layer_histograms() %>%
        set_options(width = 200, height = 200)
}
