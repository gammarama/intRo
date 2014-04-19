require(ggplot2)
require(dplyr)

scatterplot <- function (data, x, y, ...)  {
    ggplot() + geom_point(aes_string(x = x, y = y), data = data)
}

linechart <- function (data, x, y, ...)  {
    ggplot() + geom_line(aes_string(x = x, y = y), data = data)
}

histogram <- function (data, x, y, ...) {        
    ggplot() + geom_histogram(aes_string(x = x), data = data)
}

boxplot1 <- function (data, x, y, ...) {        
    ggplot() + geom_boxplot(data = data, aes_string(x = 0, y = x)) + xlab("") + theme(axis.text.x = element_blank(), axis.ticks.x = element_blank()) + coord_flip()
}

boxplot2 <- function (data, x, y, ...) {
    data[,x] <- factor(data[,x])
    ggplot() + geom_boxplot(aes_string(x = x, y = y), data = data)
}

barchart <- function (data, x, y, type = "identity", ...) {  
    data[,x] <- factor(data[,x])
    data <- eval(parse(text = paste("summarise(group_by(data, ", x, "), ", y, " = ", type, "(", y, "))", sep = "")))
            
    ggplot() + geom_bar(aes_string(x = x, y = y), stat = "identity", data = data)
}

paretochart <- function (data, x, y, type = "identity", ...) {
    data[,x] <- factor(data[,x])
    data <- eval(parse(text = paste("summarise(group_by(data, ", x, "), ", y, " = ", type, "(", y, "))", sep = "")))
    
    data[,x] <- eval(parse(text = paste("with(data, reorder(", x, ", ", y, "))", sep = "")))
    data[,x] <- factor(data[,x], levels = rev(levels(data[,x])))
    
    ggplot() + geom_bar(aes_string(x = x, y = y), stat = "identity", data = data)
}
