r <- function (intro.data, x, y) {
    if (!(x %in% names(intro.data)) | !(y %in% names(intro.data))) return(NULL)
    if (!is.numeric(intro.data[,x]) | !is.numeric(intro.data[,y])) return(NULL)
    
    return(paste("r =", round(cor(intro.data[,y], intro.data[,x], use = "complete.obs"), digits = 4)))
}

r2 <- function (intro.regression) {
    return(paste("R^2 =", round(summary(intro.regression)$r.squared, digits = 4)))
}

tablereg <- function (intro.regression, x) {
    tbl.fit <- coef(summary(intro.regression))
    rownames(tbl.fit)[2] <- x
    
    return(tbl.fit)
}

savefit <- function (intro.data, intro.regression) { 
    intro.data$fitted <- predict(intro.regression)
    intro.data$resid <- resid(intro.regression)
    
    return(intro.data)
}