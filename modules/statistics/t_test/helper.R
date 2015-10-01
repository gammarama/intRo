ttesttable <- function (intro.data, x, y = NULL, twovar = FALSE, conflevel, althyp, hypval) {
    if (is.null(y) | y == "" | !twovar) {
        interpolate(
            ~(t.test(df$x, conf.level = conf, alternative = althyp, mu = hypval)),
            df = quote(intro.data),
            x = x,
            conf = conflevel,
            althyp = althyp,
            hypval = hypval,
            mydir = userdir,
            `_env` = environment(),
            file = "code_t_test.R"
        )
    } else {
        interpolate(
            ~(t.test(x = df$x, y = df$y, conf.level = conf, alternative = althyp, mu = hypval)),
            df = quote(intro.data),
            x = x,
            y = y,
            conf = conflevel,
            althyp = althyp,
            hypval = hypval,
            mydir = userdir,
            `_env` = environment(),
            file = "code_t_test.R"
        )
    }
}
