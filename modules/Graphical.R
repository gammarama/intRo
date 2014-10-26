require(ggplot2)
require(ggvis)
require(dplyr)

scatterplot <- function (data, x, y, ...)  {
    if (!(x %in% names(data)) | !(y %in% names(data))) return(NULL)
    if (!is.numeric(data[,x]) | !is.numeric(data[,y])) return(NULL)
    
    all_values <- function(x) {
        if (is.null(x)) return(NULL)
        paste0(names(x), ": ", format(x), collapse = "<br />")
    }
    
    args <- list(...)
    
    domainx <- if (!is.na(args[[4]]) | !is.na(args[[5]])) c(args[[4]], args[[5]]) else NULL
    nicex <- if (is.null(domainx)) NULL else FALSE
    clampx <- if (is.null(domainx)) NULL else TRUE
    
    domainy <- if (!is.na(args[[6]]) | !is.na(args[[7]])) c(args[[6]], args[[7]]) else NULL
    nicey <- if (is.null(domainy)) NULL else FALSE
    clampy <- if (is.null(domainy)) NULL else TRUE
    
    data %>%
        ggvis(x = as.name(x), y = as.name(y)) %>%
        layer_points() %>%
        add_tooltip(all_values, "hover") %>%
        scale_numeric("x", domain = domainx, nice = nicex, clamp = clampx) %>%
        scale_numeric("y", domain = domainy, nice = nicey, clamp = clampy)
}

linechart <- function (data, x, y, ...)  {
    if (!(x %in% names(data)) | !(y %in% names(data))) return(NULL)
    if (!is.numeric(data[,x]) | !is.numeric(data[,y])) return(NULL)
    
    args <- list(...)
    
    domainx <- if (!is.na(args[[4]]) | !is.na(args[[5]])) c(args[[4]], args[[5]]) else NULL
    nicex <- if (is.null(domainx)) NULL else FALSE
    clampx <- if (is.null(domainx)) NULL else TRUE
    
    domainy <- if (!is.na(args[[6]]) | !is.na(args[[7]])) c(args[[6]], args[[7]]) else NULL
    nicey <- if (is.null(domainy)) NULL else FALSE
    clampy <- if (is.null(domainy)) NULL else TRUE
    
    data %>%
        ggvis(x = as.name(x), y = as.name(y)) %>%
        layer_lines() %>%
        scale_numeric("x", domain = domainx, nice = nicex, clamp = clampx) %>%
        scale_numeric("y", domain = domainy, nice = nicey, clamp = clampy)
}

histogram <- function (data, x, y, ...) {
    if (!(x %in% names(data))) return(NULL)
    if (!is.numeric(data[,x])) return(NULL)
    
    args <- list(...)
    
    domainx <- if (!is.na(args[[4]]) | !is.na(args[[5]])) c(args[[4]], args[[5]]) else NULL
    nicex <- if (is.null(domainx)) NULL else FALSE
    clampx <- if (is.null(domainx)) NULL else TRUE
    
    domainy <- if (!is.na(args[[6]]) | !is.na(args[[7]])) c(args[[6]], args[[7]]) else NULL
    nicey <- if (is.null(domainy)) NULL else FALSE
    clampy <- if (is.null(domainy)) NULL else TRUE
    
    bw <- if (is.na(list(...)[[2]])) NULL else list(...)[[2]]
    na.omit(data) %>%
        ggvis(x = as.name(x)) %>%
        layer_histograms(width = bw) %>%
        scale_numeric("x", domain = domainx, nice = nicex, clamp = clampx) %>%
        scale_numeric("y", domain = domainy, nice = nicey, clamp = clampy)
}

boxplot <- function (data, x, y, ...) {
    if (!(x %in% names(data)) | !(y %in% names(data))) return(NULL)
    if (is.numeric(data[,x]) | !is.numeric(data[,y])) return(NULL)
    
    args <- list(...)
    
    domainy <- if (!is.na(args[[6]]) | !is.na(args[[7]])) c(args[[6]], args[[7]]) else NULL
    nicey <- if (is.null(domainy)) NULL else FALSE
    clampy <- if (is.null(domainy)) NULL else TRUE
    
    data[,x] <- factor(data[,x])
    data %>%
        ggvis(x = as.name(x), y = as.name(y)) %>%
        layer_boxplots() %>%
        scale_numeric("y", domain = domainy, nice = nicey, clamp = clampy)
}

barchart <- function (data, x, y, ...) {
    args <- list(...)
    
    addy <- args[[3]]
    my.func <- args[[1]]

    if ((addy & (!(x %in% names(data)) | !(y %in% names(data)))) | !addy & ((!(x %in% names(data)))))
    if (is.numeric(data[,x]) | (!addy & !is.numeric(data[,y]))) return(NULL)
    
    data[,x] <- factor(data[,x])    
    data$x <- data[,x]
    
    domainy <- if (!is.na(args[[6]]) | !is.na(args[[7]])) c(args[[6]], args[[7]]) else NULL
    nicey <- if (is.null(domainy)) NULL else FALSE
    clampy <- if (is.null(domainy)) NULL else TRUE
    
    if (addy) {
        data$y <- data[,y]
        
        data <- data %>% group_by(x) %>% summarise(y = my.func(y))
        
        data$x <- factor(data$x, levels = rev(levels(data$x)))
        data <- as.data.frame(data)
        
        data %>%
            ggvis(x = ~x, y = ~y) %>%
            layer_bars() %>%
            add_axis("x", title = x) %>%
            add_axis("y", title = y) %>%
            scale_numeric("y", domain = domainy, nice = nicey, clamp = clampy)
    } else {
        data %>%
            ggvis(x = ~x) %>%
            layer_bars() %>%
            add_axis("x", title = x) %>%
            scale_numeric("y", domain = domainy, nice = nicey, clamp = clampy)
    }
}

paretochart <- function (data, x, y, ...) {
    args <- list(...)
    
    addy <- args[[3]]
    my.func <- args[[1]]
    
    if ((addy & (!(x %in% names(data)) | !(y %in% names(data)))) | !addy & ((!(x %in% names(data))))) return(NULL)
    if (is.numeric(data[,x]) | (addy & !is.numeric(data[,y]))) return(NULL)
    
    data[,x] <- factor(data[,x], levels = names(sort(table(data[,x]), decreasing = TRUE)))    
    data$x <- data[,x]
    
    domainy <- if (!is.na(args[[6]]) | !is.na(args[[7]])) c(args[[6]], args[[7]]) else NULL
    nicey <- if (is.null(domainy)) NULL else FALSE
    clampy <- if (is.null(domainy)) NULL else TRUE
    
    if (addy) {
        data$y <- data[,y]
        
        data <- data %>% group_by(x) %>% summarise(y = my.func(y))
        
        data$x <- reorder(data$x, data$y)
        data$x <- factor(data$x, levels = rev(levels(data$x)))
        
        data <- as.data.frame(data)
        
        data %>%
            ggvis(x = ~x, y = ~y) %>%
            layer_bars() %>%
            add_axis("x", title = x) %>%
            add_axis("y", title = y) %>%
            scale_numeric("y", domain = domainy, nice = nicey, clamp = clampy)
    } else {
        data %>%
            ggvis(x = ~x) %>%
            layer_bars() %>%
            add_axis("x", title = x) %>%
            scale_numeric("y", domain = domainy, nice = nicey, clamp = clampy)
    }
}

quantileplot <- function (data, x, y, ...) {
    if (!(x %in% names(data))) return(NULL)
    if (!is.numeric(data[,x])) return(NULL)
        
    yy <- quantile(data[,x], na.rm = TRUE, c(0.25, 0.75))
    xx <- qnorm(c(0.25, 0.75))
    slope <- diff(yy) / diff(xx)
    int <- yy[1] - slope * xx[1]
    
    args <- list(...)
    
    domainx <- if (!is.na(args[[4]]) | !is.na(args[[5]])) c(args[[4]], args[[5]]) else NULL
    nicex <- if (is.null(domainx)) NULL else FALSE
    clampx <- if (is.null(domainx)) NULL else TRUE
    
    domainy <- if (!is.na(args[[6]]) | !is.na(args[[7]])) c(args[[6]], args[[7]]) else NULL
    nicey <- if (is.null(domainy)) NULL else FALSE
    clampy <- if (is.null(domainy)) NULL else TRUE
    
    all_values <- function(x) {
        if (is.null(x)) return(NULL)
        paste0(names(x), ": ", format(x), collapse = "<br />")
    }
    
    data$yy <- qnorm(seq(0, 1, by = (1/(length(data[,x]) + 1)))[-c(1, (length(data[,x]) + 2))])
    data[,x] <- sort(data[,x])
    
    data %>%
        ggvis(x = as.name("yy"), y = as.name(x)) %>%
        layer_points() %>%
        add_tooltip(all_values, "hover") %>%
        scale_numeric("x", domain = domainx, nice = nicex, clamp = clampx) %>%
        scale_numeric("y", domain = domainy, nice = nicey, clamp = clampy)
}

mosaicplot <- function (data, x, y, ...) {
    if (!(x %in% names(data)) | !(y %in% names(data))) return(NULL)
    if (is.numeric(data[,x]) | is.numeric(data(,y))) return(NULL)

    data[,x] <- factor(data[,x])
    data[,y] <- factor(data[,y])
  #stopifnot(class(data[,x]) == "factor" & class(data[,y]) == "factor")
  
  lev_x <- length(levels(data[,x]))
  lev_y <- length(levels(data[,y]))
  
  joint_table <- prop.table(table(data[,c(x,y)]))
  plot_data <- as.data.frame(joint_table)
  plot_data$margin_x <- prop.table(table(data[,x]))
  plot_data$y_height <- plot_data$Freq / plot_data$margin_x
  plot_data$x_center <- c(0, cumsum(plot_data$margin_x)[1:lev_x -1]) +
    plot_data$margin_x / 2
  
  ggplot(plot_data, aes(x_center, y_height)) +
    geom_bar(stat = "identity", aes_string(width= "margin_x", fill = y), col = "Black") +
    geom_text(aes_string(label = x, x = "x_center", y = "1.05"), angle = 45, hjust = 0) +
    xlim(c(0, 1.2)) +
    ylim(c(0, 1.2)) +
    xlab(x) + ylab(y) +
    theme_bw()
  
}
