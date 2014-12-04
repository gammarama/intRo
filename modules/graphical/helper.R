intro.plotdata <- function(intro.data, x, y, plottype) {
    cat_and_eval(paste0("intro.plot <- na.omit(intro.data);
    
    xvar <- if (checkVariable(intro.data, '", x, "')) '", x, "' else 1;
    yvar <- if (checkVariable(intro.data, '", y, "')) '", y, "' else 2;
    
    intro.plot$intro_x_cat <- factor(intro.plot[,xvar]);
    intro.plot$intro_x_num <- as.numeric(intro.plot[,xvar]);
    intro.plot$intro_y_cat <- factor(intro.plot[,yvar]);
    intro.plot$intro_y_num <- as.numeric(intro.plot[,yvar])"),  mydir = userdir, env = environment(), file = "code_graphical_reactive.R")
    
    if (plottype == "paretochart") cat_and_eval("intro.plot$intro_x_cat <- factor(intro.plot$intro_x_cat, levels = names(sort(table(intro.plot$intro_x_cat), decreasing = TRUE)))",  mydir = userdir, env = environment(), file = "code_graphical_reactive.R", append = TRUE)
    
    return(intro.plot)
}

intro.quantdata <- function(intro.plot) {
    cat_and_eval("
        intro.quant <- intro.plot;
        
        yy <- quantile(intro.quant$intro_x_num, na.rm = TRUE, c(0.25, 0.75));
        xx <- qnorm(c(0.25, 0.75));
        slope <- diff(yy) / diff(xx);
        int <- yy[1] - slope * xx[1];
        
        intro.quant$intro_quant <- qnorm(seq(0, 1, by = (1/(length(intro.quant$intro_x_num) + 1)))[-c(1, (length(intro.quant$intro_x_num) + 2))]);
        intro.quant$intro_x_num <- sort(intro.quant$intro_x_num)
    ",  mydir = userdir, env = environment(), file = "code_graphical_reactive.R", append = TRUE)
    
    return(intro.quant)
}

input_xdomaindata <- function(xmin, xmax) {
    cat_and_eval(paste0("input_xdomain <- c(", xmin, ", ", xmax, ")"),  mydir = userdir, env = environment(), file = "code_graphical_reactive.R", append = TRUE)
    
    return(input_xdomain)
}

input_ydomaindata <- function(ymin, ymax) {
    cat_and_eval(paste0("input_ydomain <- c(", ymin, ", ", ymax, ")"),  mydir = userdir, env = environment(), file = "code_graphical_reactive.R", append = TRUE)
    
    return(input_ydomain)
}

input_binwidthdata <- function(binwidth) {
    if (is.na(binwidth)) cat_and_eval("input_binwidth <- NULL",  mydir = userdir, env = environment(), file = "code_graphical_reactive.R", append = TRUE)
    else cat_and_eval(paste0("input_binwidth <- ", binwidth),  mydir = userdir, env = environment(), file = "code_graphical_reactive.R", append = TRUE)
    
    return(input_binwidth)
}

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