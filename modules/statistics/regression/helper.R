my.lm <- function (intro.data, x, y) {
    interpolate(
        ~(intro.regression <- lm(df$x ~ df$y, na.action = na.exclude)),
        df = quote(intro.data),
        x = x,
        y = y,
        mydir = userdir,
        `_env` = environment(),
        file = "code_regression_reactives.R"
    )
}

my_regdata <- function(intro.data, x, y) {
    interpolate(
        ~(reg.data <- cbind(df, xreg = df$x, yreg = df$y, id = 1:nrow(df))),
        df = quote(intro.data),
        x = x,
        y = y,
        mydir = userdir,
        `_env` = environment(),
        file = "code_regression_reactives.R",
        append = TRUE
    )
}

my_regresid1 <- function(intro.data, intro.regression, xvar) {
    interpolate(
        ~(reg.resid1 <- data.frame(id = 1:length(resid(myreg)), residuals = resid(myreg), myx = df[as.numeric(names(resid(myreg))),]$xvar)),
        df = quote(intro.data),
        myreg = quote(intro.regression),
        xvar = xvar,
        mydir = userdir,
        `_env` = environment(),
        file = "code_regression_reactives.R",
        append = TRUE
    )
}

my_regresid2 <- function(intro.data, intro.regression) {
    interpolate(
        ~(reg.resid2 <- data.frame(id = as.numeric(names(na.omit(resid(myreg)))), 
                                   yy = qnorm(seq(0, 1, by = (1/(length(na.omit(resid(myreg))) + 1)))[-c(1, (length(na.omit(resid(myreg))) + 2))]), 
                                   residuals = sort(resid(myreg)))),
        myreg = quote(intro.regression),
        mydir = userdir,
        `_env` = environment(),
        file = "code_regression_reactives.R",
        append = TRUE
    )
}

tablereg <- function (intro.regression, x) {
    interpolate(
        ~(structure(coef(summary(myreg)), dimnames = list(c("Intercept", x), 
                                                        c("Estimate", "Std. Error", "T-Value", "P-Value")))),
        myreg = quote(intro.regression),
        x = x,
        mydir = userdir,
        `_env` = environment(),
        file = "code_regression.R"
    )
}

r <- function (intro.data, x, y) {
    interpolate(
        ~(paste('r =', round(cor(df$y, df$x, use = 'complete.obs'), digits = 4))),
        df = quote(intro.data),
        x = x,
        y = y,
        mydir = userdir,
        `_env` = environment(),
        file = "code_regression.R",
        append = TRUE
    )
}

r2 <- function (intro.regression) {
    interpolate(
        ~(paste('R^2 =', round(summary(myreg)$r.squared, digits = 4))),
        myreg = quote(intro.regression),
        mydir = userdir,
        `_env` = environment(),
        file = "code_regression.R",
        append = TRUE
    )
}

savefit <- function (intro.data, intro.regression) { 
    cat(paste0("\n\n", paste(readLines(file.path(userdir, "code_regression_reactives.R")), collapse = "\n"), "\n"), file = file.path(userdir, "code_All.R"), append = TRUE)
    interpolate(
        ~(intro.data <- cbind(df, fitted = predict(myreg), resid = resid(myreg))),
        df = quote(intro.data),
        myreg = quote(intro.regression),
        mydir = userdir,
        `_env` = environment(),
        file = "code_regression.R",
        save_result = TRUE
    )
}
