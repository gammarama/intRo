#' Deploy an instance of intRo to ShinyApps.io
#' 
#' @param path The directory containing the intRo folder
#' @param ... Additional arguments passed to the shinyapps deployApp function
#' 
#' @export
#' 
#' @importFrom shinyapps deployApp
#' 
#' @examples
#' \dontrun{
#'     deploy_intRo()
#' }
deploy_intRo <- function(path = getwd(), ...) {
    path <- file.path(path, "intRo")
    deployApp(appDir = path, ...)
}
