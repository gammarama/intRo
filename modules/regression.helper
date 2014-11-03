r <- function (data, x, y, lm.fit) {
    if (!(x %in% names(data)) | !(y %in% names(data))) return(NULL)
    if (!is.numeric(data[,x]) | !is.numeric(data[,y])) return(NULL)
    
    return(paste("r =", round(cor(data[,y], data[,x], use = "complete.obs"), digits = 4)))
}

r2 <- function (data, x, y, lm.fit) {
    return(paste("R^2 =", round(summary(lm.fit)$r.squared, digits = 4)))
}

tablereg <- function (data, x, y, lm.fit) {
    tbl.fit <- coef(summary(lm.fit))
    rownames(tbl.fit)[2] <- x
    
    return(tbl.fit)
}

savefit <- function (data, x, y, lm.fit) { 
    data$fitted <- predict(lm.fit)
    data$resid <- resid(lm.fit)
    
    return(data)
}