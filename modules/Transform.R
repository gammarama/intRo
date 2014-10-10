plot_var_trans <- function (data, x) {        
    na.omit(data) %>%
        ggvis(x = as.name(x)) %>%
        layer_histograms()
}
