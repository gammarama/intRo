plot_var_trans <- function(data, x) {
    if (is.null(data)) return(NULL)
    if (!(x %in% names(data))) return(NULL)
    
    if (is.numeric(data[,x])) {
        data %>%
            filter_(paste0("!is.na(", x, ")")) %>%
            ggvis(x = as.name(x)) %>%
            layer_histograms()
    } else {
        data %>%
            ggvis(x = as.name(x)) %>%
            layer_bars()
    }
}

input_trans_binwidthdata <- function(binwidth) {
    if (is.na(binwidth) || binwidth == 0) return(NULL)
    else return(binwidth)
}

transform_data <- function(intro.data, trans, var_trans, colname, method = "direct", intervals = 4, power = 1, logbase = exp(1)) {
    colname <- ifelse(trans == "power", 
           paste(var_trans, sub("\\.", "", ifelse(power == 0, "log", power)), sep = "_"), 
           paste(var_trans, "trans", sep = "_"))
    
    if (trans == "power" && var_trans %in% numericNames(intro.data)) {
        if (!is.numeric(power) || is.null(power)) power <- 1
        if (power == 0) interpolate(~(trans_x <- log(df$var, base = bs)), df = quote(intro.data), var = var_trans, bs = as.numeric(logbase), mydir = userdir, file = "code_transform.R") else interpolate(~(trans_x <- df$var^power), df = quote(intro.data), var = var_trans, power = power, mydir = userdir, file = "code_transform.R") 
        
        if (all(!is.infinite(trans_x))) interpolate(~(df$col <- trans_x), df = quote(intro.data), col = colname, mydir = userdir, file = "code_transform.R", append = TRUE)
    } else if (trans %in% c("categorical", "numeric")) {
        if (trans == "numeric") {
            interpolate(~(trans_x <- as.numeric(type.convert(as.character(df$var)))), df = quote(intro.data), var = var_trans, mydir = userdir, file = "code_transform.R")
        } else {
            if (method == "direct") interpolate(~(trans_x <- factor(df$var)), df = quote(intro.data), var = var_trans, mydir = userdir, file = "code_transform.R")
            else if (method == "binning") interpolate(~(trans_x <- cut(df$var, breaks = intervals)), df = quote(intro.data), var = var_trans, intervals = intervals, mydir = userdir, file = "code_transform.R")
        }
        interpolate(~(df$col <- trans_x), df = quote(intro.data), col = colname, mydir = userdir, file = "code_transform.R", append = TRUE)
    } else {
        interpolate(~(df$col <- df$var), df = quote(intro.data), col = colname, var = var_trans, mydir = userdir, file = "code_transform.R", append = TRUE)        
    }
    
    return(intro.data)
}
