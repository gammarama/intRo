r <- function (intro.data, x, y) {
    if (!(x %in% names(intro.data)) | !(y %in% names(intro.data))) return(NULL)
    if (!is.numeric(intro.data[,x]) | !is.numeric(intro.data[,y])) return(NULL)
    
    cat_and_eval("r_result <- paste('r =', round(cor(intro.data[,y], intro.data[,x], use = 'complete.obs'), digits = 4))", env = environment(), file = "code_regression.R", append = TRUE)
    cat_and_eval("r_result", env = environment(), file = "code_regression.R", append = TRUE)
}

r2 <- function (intro.regression) {
    cat_and_eval("r2_result <- paste('R^2 =', round(summary(intro.regression)$r.squared, digits = 4))", env = environment(), file = "code_regression.R", append = TRUE)
    cat_and_eval("r2_result", env = environment(), file = "code_regression.R", append = TRUE)
}

tablereg <- function (intro.regression, x) {
    cat_and_eval("tbl.fit <- coef(summary(intro.regression))", env = environment(), file = "code_regression.R", append = TRUE)
    cat_and_eval("rownames(tbl.fit)[2] <- x", env = environment(), file = "code_regression.R", append = TRUE)
    
    cat_and_eval("tbl.fit", env = environment(), file = "code_regression.R", append = TRUE)
}

savefit <- function (intro.data, intro.regression) { 
    intro.data$fitted <- predict(intro.regression)
    intro.data$resid <- resid(intro.regression)
    
    return(intro.data)
}