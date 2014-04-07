scatterplotreg <- function(data, x, y)  {
    ggplot() + geom_point(aes_string(x = x, y = y), data = data) +
        ggtitle(paste("Regression of", y, "on", x)) +
        geom_smooth(aes_string(x = x, y = y), data = data, method = "lm")
}

tablereg <- function(data, x, y) {
    lm.fit <- lm(data[,y] ~ data[,x])
    
    tbl.fit <- coef(summary(lm.fit))
    rownames(tbl.fit)[2] <- x
    
    return(tbl.fit)
}
