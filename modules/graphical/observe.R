observe({
    plottypes <- NULL
    if (numericNames(intro.data())[1] != "") plottypes <- c(plottypes, "Histogram" = "histogram", "Normal Quantile Plot" = "quantileplot")
    if (length(numericNames(intro.data())) > 1) plottypes <- c(plottypes, "Scatterplot" = "scatterplot", "Line Chart" = "linechart")
    
    if (categoricNames(intro.data())[1] != "") {
        plottypes <- c(plottypes, "Bar Chart" = "barchart", "Pareto Chart" = "paretochart")
        if ("histogram" %in% plottypes) plottypes <- c(plottypes, "Boxplot" = "boxplot")
        if (length(categoricNames(intro.data())) > 1) plottypes <- c(plottypes, "Mosaic Plot" = "mosaicplot")
    }

    updateSelectizeInput(session, "plottype", choices = plottypes)
})

observe({
    input$plottype
    updateSelectizeInput(session, "x", choices = x_choices(), selected = x_selected())
    updateSelectizeInput(session, "y", choices = y_choices(), selected = y_selected())
})

observeEvent(input$store_graphical, {
    cat(paste0("\n\n", paste(readLines(file.path(userdir, "code_graphical_reactive.R")), collapse = "\n")), file = file.path(userdir, "code_All.R"), append = TRUE)

    mystr <- paste0("X Variable: ", input$x, (if (input$plottype %in% c("histogram", "quantileplot")) "" else paste0("; Y Variable: ", input$y)))
    
    cat("\n\n", file = file.path(userdir, paste0("code_", input$plottype, ".R")), append = TRUE)
    cat(paste0("\n\n", paste(readLines(file.path(userdir, paste0("code_", input$plottype, ".R"))), collapse = "\n")), file = file.path(userdir, "code_All.R"), append = TRUE)
    cat(paste0("\ncat('", mystr, "')"), file = file.path(userdir, "code_All.R"), append = TRUE)
})
