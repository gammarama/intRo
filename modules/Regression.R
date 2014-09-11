scatterplotreg <- function (data, x, y)  {
    lm.fit <- lm(data[,y] ~ data[,x])
    
    my.range <- range(data[,x], na.rm = TRUE)
    adjustment <- (my.range[2] - my.range[1]) / 10
    
    coord <- c(min(data[,x], na.rm = TRUE) + adjustment, max(data[,y], na.rm = TRUE))
    
    if (coef(lm.fit)[2] < 0) coord <- c(min(data[,x], na.rm = TRUE) + adjustment, min(data[,y], na.rm = TRUE))
    
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

residualreg1 <- function (data, x, y) {
    lm.fit <- lm(data[,y] ~ data[,x])
    data$residuals <- resid(lm.fit)
    
    p1 <- ggplot() + geom_point(data = data, aes_string(x = x, y = "residuals")) +
                     geom_hline(yintercept = 0, linetype = 2) + theme(aspect.ratio = 1) + ggtitle(paste("Residuals vs", x))
    
    all_values <- function(x) {
        if (is.null(x)) return(NULL)
        paste0(names(x), ": ", format(x), collapse = "<br />")
    }
        
    data %>%
        ggvis(x = as.name(x), y = as.name("residuals")) %>%
        layer_points() %>%
        add_tooltip(all_values, "hover")
}

residualreg2 <- function (data, x, y) {
    lm.fit <- lm(data[,y] ~ data[,x])
    data$residuals <- resid(lm.fit)
    
    yy <- quantile(data$residuals, na.rm = TRUE, c(0.25, 0.75))
    xx <- qnorm(c(0.25, 0.75))
    slope <- diff(yy) / diff(xx)
    int <- yy[1] - slope * xx[1]
    
    qplot(sample = data$residuals, stat = "qq") + geom_abline(slope = slope, intercept = int, linetype = 2) + theme(aspect.ratio = 1) + ggtitle("Normal Quantile Plot")
}
