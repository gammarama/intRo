require(ggplot2)
require(dplyr)

scatterplot <- function (data, x, y, ...)  {
    ggplot() + geom_point(aes_string(x = x, y = y), data = data)
}

linechart <- function (data, x, y, ...)  {
    ggplot() + geom_line(aes_string(x = x, y = y), data = data)
}

histogram <- function (data, x, y, ...) {        
    ggplot() + geom_histogram(aes_string(x = x), data = data, binwidth = list(...)[[2]])
}

boxplot1 <- function (data, x, y, ...) {        
    ggplot() + geom_boxplot(data = data, aes_string(x = 0, y = x)) + xlab("") + theme(axis.text.x = element_blank(), axis.ticks.x = element_blank()) + coord_flip()
}

boxplot2 <- function (data, x, y, ...) {
    data[,x] <- factor(data[,x])
    ggplot() + geom_boxplot(aes_string(x = x, y = y), data = data)
}

barchart <- function (data, x, y, ...) {  
    data[,x] <- factor(data[,x])    
    data$x <- data[,x]
    data$y <- data[,y]
    
    my.func <- list(...)[[1]]
    
    data <- data %.% group_by(x) %.% summarise(y = my.func(y))
    
    data$x <- factor(data$x, levels = rev(levels(data$x)))
    
    ggplot() + geom_bar(aes(x = x, y = y), stat = "identity", data = data) +
        xlab(x) + ylab(y)
}

paretochart <- function (data, x, y, ...) {
    data[,x] <- factor(data[,x])    
    data$x <- data[,x]
    data$y <- data[,y]
    
    my.func <- list(...)[[1]]
    
    data <- data %.% group_by(x) %.% summarise(y = my.func(y))
    
    data$x <- reorder(data$x, data$y)
    data$x <- factor(data$x, levels = rev(levels(data$x)))
    
    ggplot() + geom_bar(aes(x = x, y = y), stat = "identity", data = data) +
        xlab(x) + ylab(y)
}
