mosaicplot <- function (data, x, y, numnames, catnames, ...) {
    if (!(x %in% catnames)) return(blank.ggvis)
    if (!(y %in% catnames)) return(blank.ggvis)

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
    theme_bw() +
    coord_fixed()
  
}