reg_observers <- function(session, data) {
        s1 <- updateSelectInput(session, "xreg", choices = data)
        s2 <- updateSelectInput(session, "yreg", choices = data)
        
        return(list(s1, s2))
}
