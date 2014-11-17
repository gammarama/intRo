addResourcePath(prefix="images", directoryPath="images/")

## For printing
dynDiv <- function(outputId, title) 
{
  div(id = outputId, class = "print-results", title = title)
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
                            dynDiv(outputId = 'print_output', title="Print Results"),
                            div(class='intRoPrint', h3('Results from intRo session:')),
                            do.call(navlistPanel, c(list(id = "side-nav", widths = c(2, 10)), mylist))
                        )     
               ),
               tabPanel(title="", value="http://gammarama.github.io/intRo", icon=icon('question-circle')),
               tabPanel(title="", value="http://github.com/gammarama/intRo", icon=icon("github")),
               navbarMenu("", icon=icon("envelope"),
                          tabPanel("Eric Hare"),
                          tabPanel("Andee Kaplan")),
               tabPanel(title="hide_me"),
               tabPanel(title="", icon=icon("print"), class="print-button", value = "javascript:print_intRo();"),
               footer=tagList(includeScript("scripts/top-nav-links.js"),
                              includeScript("scripts/print.js"),
                              includeScript("scripts/other-helpers.js"),
                              includeCSS("http://code.jquery.com/ui/1.11.2/themes/smoothness/jquery-ui.css"),
                              includeScript("http://code.jquery.com/jquery-1.10.2.js"),
                              includeScript("http://code.jquery.com/ui/1.11.2/jquery-ui.js")
               ),
               tags$head(tags$link(rel="shortcut icon", href="images/icon.png"))
    ))
