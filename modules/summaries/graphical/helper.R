intro.plotdata <- function(intro.data, x, y, plottype) {
    xvar <- if (checkVariable(intro.data, x)) x else names(intro.data)[1];
    yvar <- if (checkVariable(intro.data, y)) y else names(intro.data)[2];
    
    interpolate(
        ~(intro.plot <- df %>%
            mutate(id = 1:n(),
                   intro_x_cat = factor(x),
                   intro_x_num = as.numeric(x),
                   intro_y_cat = factor(y),
                   intro_y_num = as.numeric(y))),
        df = quote(intro.data),
        x = as.name(xvar),
        y = as.name(yvar),
        mydir = userdir, `_env` = environment(), file = "code_graphical_reactive.R"
    )

    if (plottype == "paretochart") interpolate(~(intro.plot$intro_x_cat <- factor(intro.plot$intro_x_cat, levels = names(sort(table(intro.plot$intro_x_cat), decreasing = TRUE)))), mydir = userdir, `_env` = environment(), file = "code_graphical_reactive.R", append = TRUE)
    
    return(intro.plot)
}

intro.quantdata <- function(intro.plot) {
    interpolate(
        ~(intro.quant <- df %>%
              filter(!is.na(intro_x_num)) %>%
              mutate(intro_quant = qnorm(tail(head(seq(0, 1, by = (1/(length(intro_x_num) + 1))), -1), -1)),
                     intro_x_num = sort(intro_x_num))),
        df = quote(intro.plot),
        mydir = userdir, `_env` = environment(), file = "code_graphical_reactive.R", append = TRUE
    )
    
    return(intro.quant)
}

input_xdomaindata <- function(xmin, xmax) {
    interpolate(~(input_xdomain <- c(xmin, xmax)), xmin = xmin, xmax = xmax, mydir = userdir, `_env` = environment(), file = "code_graphical_reactive.R", append = TRUE)
}

input_ydomaindata <- function(ymin, ymax) {
    interpolate(~(input_ydomain <- c(ymin, ymax)), ymin = ymin, ymax = ymax, mydir = userdir, `_env` = environment(), file = "code_graphical_reactive.R", append = TRUE)
}

input_binwidthdata <- function(binwidth) {
    if (is.na(binwidth) || binwidth == 0) interpolate(~(input_binwidth <- NULL),  mydir = userdir, `_env` = environment(), file = "code_graphical_reactive.R", append = TRUE)
    else interpolate(~(input_binwidth <- bw), bw = binwidth, mydir = userdir, `_env` = environment(), file = "code_graphical_reactive.R", append = TRUE)
}

helper_text <- function(x, y, plottype) {
    mystr <- paste0("X Variable: ", x, (if (plottype %in% c("histogram", "quantileplot")) "" else paste0("; Y Variable: ", y)))    
    return(mystr)
}

mosaicplot <- function (intro.data, x, y, numnames, catnames, ...) {
    if (!(x %in% catnames)) return(NULL)
    if (!(y %in% catnames)) return(NULL)
    
    interpolate(
        ~(intro.mosaic <- table(df[,c(x, y)]) %>%
              as.data.frame
    ), df = quote(intro.data), x = x, y = y, mydir = userdir, `_env` = environment(), file = "code_mosaicplot.R")

  interpolate(~(ggplot(df) +
    geom_mosaic(aes(weight = Freq, x = product(xvar), fill = yvar)) +
    theme_bw()), df = quote(intro.mosaic), xvar = as.name(x), yvar = as.name(y), mydir = userdir, `_env` = environment(), append = TRUE, file = "code_mosaicplot.R")
}
