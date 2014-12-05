nonparametrictable <- function (intro.data, x, y, conflevel, althyp, hypval) {
    cat_and_eval(paste0("wilcox.test(x=intro.data[,'", x, "'], y=intro.data[,'", y, "'], conf.level=", conflevel, ", alternative='", althyp, "', mu=", hypval, ")"),  mydir = userdir, env = environment(), file = "code_nonparametric.R")
}
