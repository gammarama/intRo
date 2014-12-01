my.lm <- function (intro.data, x, y) {
    cat_and_eval(paste0("intro.regression <- lm(intro.data[,'", y, "'] ~ intro.data[,'", x, "'], na.action = na.exclude)"), env = environment(), file = "code_regression_reactives.R")
    
    return(intro.regression)
}

my_regdata <- function(intro.data, x, y) {
    cat_and_eval("reg.data <- intro.data", , env = environment(), file = "code_regression_reactives.R", append = TRUE)
    cat_and_eval(paste0("reg.data$xreg <- reg.data[,'", x, "']"), env = environment(), file = "code_regression_reactives.R", append = TRUE)
    cat_and_eval(paste0("reg.data$yreg <- reg.data[,'", y, "']"), env = environment(), file = "code_regression_reactives.R", append = TRUE)
    
    return(reg.data)
}

my_regresid1 <- function(intro.data, intro.regression, x) {
    cat_and_eval(paste0("reg.resid1 <- data.frame(residuals = resid(intro.regression), x = intro.data[as.numeric(names(resid(intro.regression))),'", x, "'])"), env = environment(), file = "code_regression_reactives.R", append = TRUE)
    
    return(reg.resid1)
}

my_regresid2 <- function(intro.regression) {
    cat_and_eval("myresid <- resid(intro.regression)", env = environment(), file = "code_regression_reactives.R", append = TRUE)
    
    cat_and_eval("yy <- quantile(myresid, na.rm = TRUE, c(0.25, 0.75))", env = environment(), file = "code_regression_reactives.R", append = TRUE)
    cat_and_eval("xx <- qnorm(c(0.25, 0.75))", env = environment(), file = "code_regression_reactives.R", append = TRUE)
    cat_and_eval("slope <- diff(yy) / diff(xx)", env = environment(), file = "code_regression_reactives.R", append = TRUE)
    cat_and_eval("int <- yy[1] - slope * xx[1]", env = environment(), file = "code_regression_reactives.R", append = TRUE)
    
    cat_and_eval("reg.resid2 <- data.frame(yy = qnorm(seq(0, 1, by = (1/(length(na.omit(myresid)) + 1)))[-c(1, (length(na.omit(myresid)) + 2))]), residuals = sort(myresid))", env = environment(), file = "code_regression_reactives.R", append = TRUE)
    
    return(reg.resid2)
}

tablereg <- function (intro.regression, x) {
    cat_and_eval("tbl.fit <- coef(summary(intro.regression))", env = environment(), file = "code_regression.R")
    cat_and_eval(paste0("rownames(tbl.fit)[2] <- '", x, "'"), env = environment(), file = "code_regression.R", append = TRUE)
    
    cat_and_eval("tbl.fit", env = environment(), file = "code_regression.R", append = TRUE)
}

r <- function (intro.data, x, y) {
    if (!(x %in% names(intro.data)) | !(y %in% names(intro.data))) return(NULL)
    if (!is.numeric(intro.data[,x]) | !is.numeric(intro.data[,y])) return(NULL)
    
    cat_and_eval(paste0("r_result <- paste('r =', round(cor(intro.data[,'", y, "'], intro.data[,'", x, "'], use = 'complete.obs'), digits = 4))"), env = environment(), file = "code_regression.R", append = TRUE)
    cat_and_eval("r_result", env = environment(), file = "code_regression.R", append = TRUE)
}

r2 <- function (intro.regression) {
    cat_and_eval("r2_result <- paste('R^2 =', round(summary(intro.regression)$r.squared, digits = 4))", env = environment(), file = "code_regression.R", append = TRUE)
    cat_and_eval("r2_result", env = environment(), file = "code_regression.R", append = TRUE)
}

savefit <- function (intro.data, intro.regression) { 
    intro.data$fitted <- predict(intro.regression)
    intro.data$resid <- resid(intro.regression)
    
    return(intro.data)
}