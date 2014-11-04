plot_var_trans <- function (data, x) {
    if (is.null(data)) return(NULL)
    if (!(x %in% names(data))) return(NULL)
    
    if (is.numeric(data[,x])) {
        na.omit(data) %>%
            ggvis(x = as.name(x)) %>%
            layer_histograms()
    } else {
        data %>%
            ggvis(x = as.name(x)) %>%
            layer_bars()
    }
}
