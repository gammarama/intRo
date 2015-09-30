###
### Libraries
###
library(shinythemes)

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
module_info <- read.table("modules/modules.txt", header = TRUE, sep = ",")
sapply(file.path("modules", dir("modules")[dir("modules") != "modules.txt"], "ui.R"), source)

## Generates the UI tabs
mylist <- list()
old_heading <- ""
for (i in 1:nrow(module_info)) {
    if (module_info[i,1] != old_heading) {
        mylist[[length(mylist) + 1]] <- capitalize(as.character(module_info[i,1]))
        old_heading <- module_info[i,1]
    }
    mylist[[length(mylist) + 1]] <- get(paste(module_info[i,2], "ui", sep = "_"))
}

shinyUI(
    navbarPage("intRo", id = "top-nav", theme = shinytheme("united"),
               tabPanel(title = "", icon = icon("home", "fa-2x"),
                        fluidRow(
                            dynFrame(outputId = 'print_output'),
                            do.call(navlistPanel, c(list(id = "side-nav", widths = c(2, 10)), mylist))
                        ),
                        hr(),                        
                        fluidRow(
                            column(12,
                                   aceEditor("myEditor", "", mode = "r", readOnly = TRUE, theme = "chrome")
                            )
                        )
               ),
               tabPanel(title = "", value = "http://gammarama.github.io/intRo", icon = icon('question-circle', "fa-2x")),
               tabPanel(title = "", value = "http://github.com/gammarama/intRo", icon = icon("github", "fa-2x")),
               navbarMenu("", icon = icon("envelope", "fa-2x"),
                          tabPanel("Eric Hare"),
                          tabPanel("Andee Kaplan")),
               tabPanel(title = "hide_me"),
               tabPanel(title = "", icon = icon('code', "fa-2x"), value = "javascript:$('#myEditor').slideToggle(); $('.fa-code').parent().parent().toggleClass('active'); code_clicked();"),
               tabPanel(title = "", icon = icon("print", "fa-2x"), value = "javascript: $(this).addClass('print_button'); print_clicked();"),
               footer = tagList(includeScript("scripts/top-nav-links.js"),
                              includeScript("scripts/print.js"),
                              includeScript("scripts/other-helpers.js"),
                              includeCSS("www/additional.css")         
               ),
               tags$head(includeScript("scripts/google-analytics.js"), tags$link(rel = "shortcut icon", href = "images/icon.png"))
    ))
