scatterplotreg <- function(data, x, y)  {
    lm.fit <- lm(data[,y] ~ data[,x])
    
    my.range <- range(data[,x], na.rm = TRUE)
    adjustment <- (my.range[2] - my.range[1]) / 10
    
    coord <- c(min(data[,x], na.rm = TRUE) + adjustment, max(data[,y], na.rm = TRUE))
    
    if (coef(lm.fit)[2] < 0) coord <- c(min(data[,x], na.rm = TRUE) + adjustment, min(data[,y], na.rm = TRUE))
    
    ggplot() + geom_point(aes_string(x = x, y = y), data = data) +
        ggtitle(paste("Regression of", y, "on", x)) +
        geom_smooth(aes_string(x = x, y = y), data = data, method = "lm") +
        annotate("text", label = paste("R^2 =", round(summary(lm.fit)$r.squared, digits = 4)), x = coord[1], y = coord[2], size = 6)
}

tablereg <- function(data, x, y) {
    lm.fit <- lm(data[,y] ~ data[,x])
    
    tbl.fit <- coef(summary(lm.fit))
    rownames(tbl.fit)[2] <- x
    
    return(tbl.fit)
}
