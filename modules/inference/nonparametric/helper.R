nonparametrictest <- function (intro.data, x, y, conflevel, althyp, hypval) {
    interpolate(~(wilcox.test(x = df$x, y = df$y, conf.level = conf, alternative = althyp, mu = hypval)),
                  df = quote(intro.data),
                  x = x,
                  y = y,
                  conf = conflevel,
                  althyp = althyp,
                  hypval = hypval,
                  mydir = userdir, 
                  `_env` = environment(), 
                  file = "code_nonparametric.R")
}
