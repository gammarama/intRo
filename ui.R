addResourcePath(prefix="images", directoryPath="images/")

## For printing
dynFrame <- function(outputId) 
{
  HTML(paste0("<iframe class = 'print_results', id = '", outputId, "'></iframe>"))
}

## Source ui
sapply(file.path("modules", dir("modules")[dir("modules") != "modules.txt"], "ui.R"), source)

## Generates the UI tabs
mylist <- list()
old_heading <- ""
for (i in 1:nrow(module_info)) {
    if (module_info[i,1] != old_heading) {
        if (i != 1) mylist[[length(mylist) + 1]] <- "-----"
        mylist[[length(mylist) + 1]] <- as.character(module_info[i,1])
        old_heading <- module_info[i,1]
    }
    mylist[[length(mylist) + 1]] <- get(paste(module_info[i,2], "ui", sep = "_"))
}

shinyUI(
    navbarPage("intRo", id="top-nav",  theme = "bootstrap.min.css",
               tabPanel(title="", icon=icon("home"),
                        fluidRow(
                            dynFrame(outputId = 'print_output'),
                            do.call(navlistPanel, c(list(id = "side-nav", widths = c(2, 10)), mylist))
                        )     
               ),
               tabPanel(title="", value="http://gammarama.github.io/intRo", icon=icon('question-circle')),
               tabPanel(title="", value="http://github.com/gammarama/intRo", icon=icon("github")),
               navbarMenu("", icon=icon("envelope"),
                          tabPanel("Eric Hare"),
                          tabPanel("Andee Kaplan")),
               tabPanel(title="hide_me"),
               tabPanel(title="", icon=icon("print"), value="javascript: $(this).addClass('print_button'); print_clicked();"),
               footer=tagList(includeScript("scripts/top-nav-links.js"),
                              includeScript("scripts/print.js"),
                              includeScript("scripts/other-helpers.js")
                              
                              
               ),
               tags$head(tags$link(rel="shortcut icon", href="images/icon.png"))
    ))
