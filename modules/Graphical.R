require(ggplot2)
require(ggvis)
require(dplyr)

scatterplot <- function (data, x, y, ...)  {
    all_values <- function(x) {
        if (is.null(x)) return(NULL)
        paste0(names(x), ": ", format(x), collapse = "<br />")
    }
    
    data %>%
        ggvis(x = as.name(x), y = as.name(y)) %>%
        layer_points() %>%
        add_tooltip(all_values, "hover")
}

linechart <- function (data, x, y, ...)  {
    data %>%
        ggvis(x = as.name(x), y = as.name(y)) %>%
        layer_lines()
}

histogram <- function (data, x, y, ...) {        
    na.omit(data) %>%
        ggvis(x = as.name(x)) %>%
        layer_histograms(width = list(...)[[2]])
}

boxplot <- function (data, x, y, ...) {
    data[,x] <- factor(data[,x])
    data %>%
        ggvis(x = as.name(x), y = as.name(y)) %>%
        layer_boxplots()
}

barchart <- function (data, x, y, ...) { 
    data[,x] <- factor(data[,x])    
    data$x <- data[,x]
    
    addy <- list(...)[[3]]
    
    my.func <- list(...)[[1]]
    
    if (addy) {
        data$y <- data[,y]
        
        data <- data %>% group_by(x) %>% summarise(y = my.func(y))
        
        data$x <- factor(data$x, levels = rev(levels(data$x)))
        data <- as.data.frame(data)
        
        data %>%
            ggvis(x = ~x, y = ~y) %>%
            layer_bars() %>%
            add_axis("x", title = x) %>%
            add_axis("y", title = y)
    } else {
        data %>%
            ggvis(x = ~x) %>%
            layer_bars() %>%
            add_axis("x", title = x)
    }
}

paretochart <- function (data, x, y, ...) {
    data[,x] <- factor(data[,x], levels = names(sort(table(data[,x]), decreasing = TRUE)))    
    data$x <- data[,x]
    
    addy <- list(...)[[3]]
    my.func <- list(...)[[1]]
    
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
            add_axis("y", title = y)
    } else {
        data %>%
            ggvis(x = ~x) %>%
            layer_bars() %>%
            add_axis("x", title = x)
    }
}

quantileplot <- function (data, x, y, ...) {
    yy <- quantile(data[,x], na.rm = TRUE, c(0.25, 0.75))
    xx <- qnorm(c(0.25, 0.75))
    slope <- diff(yy) / diff(xx)
    int <- yy[1] - slope * xx[1]
    
    all_values <- function(x) {
        if (is.null(x)) return(NULL)
        paste0(names(x), ": ", format(x), collapse = "<br />")
    }
    
    data$yy <- qnorm(seq(0, 1, by = (1/(length(data[,x]) + 1)))[-c(1, (length(data[,x]) + 2))])
    data[,x] <- sort(data[,x])
    
    data %>%
        ggvis(x = as.name("yy"), y = as.name(x)) %>%
        layer_points() %>%
        add_tooltip(all_values, "hover")
}

mosaicplot <- function (data, x, y, ...) {
  stopifnot(class(data[,x]) == "factor" & class(data[,y]) == "factor")
  
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
    geom_text(aes_string(label = x, x = "x_center", y = "1.05")) +
    xlab(x) + ylab(y) +
    theme_bw()
  
}
