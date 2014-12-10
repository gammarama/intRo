observe({
    updateSelectizeInput(session, "plottype", choices = if (intro.numericnames() == "") c("Mosaic Plot" = "mosaicplot") else if (intro.categoricnames() == "") c("Histogram" = "histogram", "Normal Quantile Plot" = "quantileplot", "Scatterplot" = "scatterplot", "Line Chart" = "linechart") else c("Histogram" = "histogram", "Normal Quantile Plot" = "quantileplot", "Scatterplot" = "scatterplot", "Line Chart" = "linechart", "Boxplot" = "boxplot", "Bar Chart" = "barchart", "Pareto Chart" = "paretochart", "Mosaic Plot" = "mosaicplot"))
})

observe({
    input$plottype
    updateSelectizeInput(session, "x", choices = x_choices(), selected = x_selected())
    updateSelectizeInput(session, "y", choices = y_choices(), selected = y_selected())
})

observeEvent(input$store_graphical, {
    cat(paste0("\n\n", paste(readLines(file.path(userdir, "code_graphical_reactive.R")), collapse = "\n")), file = file.path(userdir, "code_All.R"), append = TRUE)
    
    ## Fix this
    cat(paste0("\n\ninput_xdomain <- c(", input$xmin, ", ", input$xmax, ")\n"), file = file.path(userdir, "code_All.R"), append = TRUE)
    cat(paste0("input_ydomain <- c(", input$ymin, ", ", input$ymax, ")\n"), file = file.path(userdir, "code_All.R"), append = TRUE)
    cat(paste0("input_binwidth <- ", ifelse(is.na(input$binwidth), "NULL", input$binwidth), "\n"), file = file.path(userdir, "code_All.R"), append = TRUE)
    
    cat("\n\n", file = file.path(userdir, paste0("code_", input$plottype, ".R")), append = TRUE)
    cat(paste0("\n\n", paste(readLines(file.path(userdir, paste0("code_", input$plottype, ".R"))), collapse = "\n")), file = file.path(userdir, "code_All.R"), append = TRUE)
    if (input$plottype != "mosaicplot") cat(paste0("p.", input$plottype), file = file.path(userdir, "code_All.R"), append = TRUE)
})
