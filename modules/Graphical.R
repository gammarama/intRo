require(ggplot2)
require(ggvis)
require(dplyr)

scatterplot <- function (data, x, y, ...)  {
    data %>%
        ggvis(x = as.name(x), y = as.name(y)) %>%
        layer_points()
}

linechart <- function (data, x, y, ...)  {
    data %>%
        ggvis(x = as.name(x), y = as.name(y)) %>%
        layer_lines()
}

histogram <- function (data, x, y, ...) {        
    data %>%
        ggvis(x = as.name(x)) %>%
        layer_histograms()
}

boxplot1 <- function (data, x, y, ...) {        
    data %>%
        ggvis(x = as.name(x)) %>%
        layer_boxplots()
}

boxplot2 <- function (data, x, y, ...) {
    data[,x] <- factor(data[,x])
    data %>%
        ggvis(x = as.name(x), y = as.name(y)) %>%
        layer_boxplots()
}

barchart <- function (data, x, y, ...) {  
    data[,x] <- factor(data[,x])    
    data$x <- data[,x]
    data$y <- data[,y]
    
    my.func <- list(...)[[1]]
    
    data <- data %>% group_by(x) %>% summarise(y = my.func(y))
    
    data$x <- factor(data$x, levels = rev(levels(data$x)))
    
    data %>%
        ggvis(x = ~x, y = ~y) %>%
        layer_bars() %>%
        add_axis("x", title = x) %>%
        add_axis("y", title = y)
}

paretochart <- function (data, x, y, ...) {
    data[,x] <- factor(data[,x])    
    data$x <- data[,x]
    data$y <- data[,y]
    
    my.func <- list(...)[[1]]
    
    data <- data %>% group_by(x) %>% summarise(y = my.func(y))
    
    data$x <- reorder(data$x, data$y)
    data$x <- factor(data$x, levels = rev(levels(data$x)))
    
    data %>%
        ggvis(x = ~x, y = ~y) %>%
        layer_bars() %>%
        add_axis("x", title = x) %>%
        add_axis("y", title = y)
}
