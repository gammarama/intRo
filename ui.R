###
### Libraries
###
library(shinythemes)
library(shinyjs)

###
### UI Definition
###
addResourcePath(prefix = "images", directoryPath = "images/")

## For printing
dynFrame <- function(outputId) 
{
    HTML(paste0("<iframe class = 'print_results' src='about:blank' id = '", outputId, "'></iframe>"))
}

## Source ui
sapply(file.path("modules", modules, "ui.R"), source)

## Generates the UI tabs
mylist <- list()
old_heading <- ""
for (i in seq_along(modules)) {
    my.module <- strsplit(modules[i], "/")[[1]]
    if (my.module[1] != old_heading) {
        mylist[[length(mylist) + 1]] <- Hmisc::capitalize(my.module[1])
        old_heading <- my.module[1]
    }
    mylist[[length(mylist) + 1]] <- get(paste(my.module[2], "ui", sep = "_"))
}

shinyUI(
    navbarPage("intRo", id = "top-nav", theme = shinytheme(intRo_theme),
               
               tabPanel(title = "", icon = icon("home", "fa-2x"),
                        
                        ## Shiny JS
                        useShinyjs(),
                        
                        fluidRow(
                            dynFrame(outputId = 'print_output'),
                            do.call(navlistPanel, c(list(id = "side-nav", widths = c(2, 10)), mylist))
                        ),
                        hr(),                        
                        fluidRow(
                            column(12,
                                   aceEditor("myEditor", "", mode = "r", readOnly = TRUE, theme = "chrome")
                            )
                        ),
                        downloadButton("mydownload")
               ),
               tabPanel(title = "", value = "http://gammarama.github.io/intRo", icon = icon('question-circle', "fa-2x")),
               tabPanel(title = "", value = "http://github.com/gammarama/intRo", icon = icon("github", "fa-2x")),
               navbarMenu("", icon = icon("envelope", "fa-2x"),
                          tabPanel("Eric Hare"),
                          tabPanel("Andee Kaplan")),
               tabPanel(title = "hide_me"),
               tabPanel(title = "", icon = icon('code', "fa-2x"), value = "javascript:$('#myEditor').slideToggle(); $('.fa-code').parent().parent().toggleClass('active'); code_clicked();"),
               tabPanel(title = "", icon = icon('download', "fa-2x"), value = "javascript:document.getElementById('mydownload').click();"),
               tabPanel(title = "", icon = icon("print", "fa-2x"), value = "javascript: $(this).addClass('print_button'); print_clicked();"),
               footer = tagList(includeScript("scripts/top-nav-links.js"),
                              includeScript("scripts/print.js"),
                              includeScript("scripts/other-helpers.js"),
                              includeCSS("www/additional.css")         
               ),
               tags$head(includeScript("scripts/google-analytics.js"), tags$link(rel = "shortcut icon", href = "images/icon.png"))
    ))
