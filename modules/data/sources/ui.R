sources_ui <- tabPanel("Sources",
                                                  column(4,
                                                         wellPanel(
                                                             conditionalPanel(
                                                                 condition = "input.own == false",
                                                                 selectizeInput("data", label = "Choose Dataset", choices = c("MPG" = "mpg", "Air Quality" = "airquality", "Diamonds" = "diamonds", "Super Bowl Salaries" = "super_bowl_salaries"))
                                                             ),
                                                             conditionalPanel(
                                                                 condition = "input.own == true",
                                                                 fileInput('data_own', 'Choose CSV File',
                                                                           accept=c('text/csv', 
                                                                                    'text/comma-separated-values,text/plain', 
                                                                                    '.csv'))
                                                             ),
                                                             checkboxInput("own", "Upload Dataset"),
                                                             
                                                             hr(),
                                                             fluidRow(
                                                                 column(6, checkboxInput("randomsub", "Random Subset")),
                                                                 conditionalPanel(condition = "input.randomsub == true", 
                                                                                  column(6, numericInput("randomsubrows", "Rows", value = 1, min = 1))
                                                                 )
                                                             ),
                                                             tags$button("", id = "savesubset", type = "button", class = "btn action-button", onclick="var vals = []; var subsets = $('input[type = \"text\"][placeholder]'); for(i = 0; i < subsets.length; i++) {vals.push(subsets[i].value);}; Shiny.onInputChange(\"subs\", vals); $('#side-nav :contains(\"Sources\")').highlight(); $('#top-nav a:has(> .fa-print, .fa-code, .fa-download)').hightlight();", list(icon("save"), "Save Subset")),
                                                             br(), br(),
                                                             tags$button("", id = "clearsubset", type = "button", class = "btn action-button", onclick="Shiny.onInputChange(\"subs\", null);", list(icon("eraser"), "Reset Data")),
                                                             br(), br(),
                                                             downloadButton("downloaddata", "Download Data")
                                                         )
                                                  ),
                                                  
                                                  column(8,
                                                         dataTableOutput("data")
                                                  )
                                         )
