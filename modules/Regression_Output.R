reg_output <- function(mylist) {
        
    mylist[["reg.data"]] %>%
        ggvis(x = ~xreg, y = ~yreg) %>%
        layer_points() %>%
        layer_model_predictions(model = "lm") %>% 
        bind_shiny("regplot")
    
    mylist[["reg.resid1"]] %>%
        ggvis(x = ~x, y = ~residuals) %>%
        layer_points() %>%
        set_options(width = 200, height = 200) %>% 
        bind_shiny("resplot1")
    
    mylist[["reg.resid2"]] %>%
        ggvis(x = ~yy, y = ~residuals) %>%
        layer_points() %>%
        set_options(width = 200, height = 200) %>% 
        bind_shiny("resplot2")
    
    mylist[["reg.resid1"]] %>%
        ggvis(x = ~residuals) %>%
        layer_histograms() %>%
        set_options(width = 200, height = 200) %>%
        bind_shiny("resplot3")
}
