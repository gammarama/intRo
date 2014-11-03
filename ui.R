addResourcePath(prefix="images", directoryPath="images/")


## Source ui
sourceDir("modules", "ui")

shinyUI(
    navbarPage("intRo", id="top-nav",  theme = "bootstrap.min.css",
               tabPanel(title="", icon=icon("home"),
                        fluidRow(
                            div(class='intRoPrint', h3('Results from intRo session:')),
                            navlistPanel(id = "side-nav", widths = c(2, 10),
                                         "Data",
                                         sources_ui,                                         
                                         "-----",
                                         "Statistics",
                                         reg_ui

                            )
                        )     
               ),
               tabPanel(title="", value="http://harekaplan.github.io/intRo", icon=icon('question-circle')),
               tabPanel(title="", value="http://github.com/harekaplan/intRo", icon=icon("github")),
               navbarMenu("", icon=icon("envelope"),
                          tabPanel("Eric Hare"),
                          tabPanel("Andee Kaplan")),
               tabPanel(title="hide_me"),
               tabPanel(title="", icon=icon("print"), value = "javascript:print_intRo();"),
               footer=tagList(includeScript("scripts/top-nav-links.js"),
                              includeScript("scripts/print.js"),
                              includeScript("http://code.jquery.com/color/jquery.color-2.1.2.min.js"),
                              includeScript("scripts/other-helpers.js")
               ),
               tags$head(tags$link(rel="shortcut icon", href="images/icon.png"))
    ))
