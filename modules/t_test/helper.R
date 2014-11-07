ttesttable <- function (intro.data, x, y = NULL, twovar = FALSE, conflevel, althyp, hypval) {
    if (is.null(y) | y == "" | !twovar) {
        cat_and_eval(paste0("t.test(x=intro.data[,'", x, "'], conf.level=", conflevel, ", alternative='", althyp, "', mu=", hypval, ")"), environment())
    } else {
        cat_and_eval(paste0("t.test(x=intro.data[,'", x, "'], y=intro.data[,'", y, "'], conf.level=", conflevel, ", alternative='", althyp, "', mu=", hypval, ")"), environment())
    }
}
