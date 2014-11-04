output$data <- renderDataTable({  
  return(intro.data())
}, options = dt.options)

output$downloaddata <- downloadHandler(
    filename = function() { paste0("intro_data_", today(), ".csv") },
    content = function(file) {
        write.csv(intro.data(), file)
    }
)