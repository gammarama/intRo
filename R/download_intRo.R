#' Download an instance of intRo to your machine
#' 
#' @param path The directory to download intRo to
#' 
#' @export
#' 
#' @importFrom git2r clone
#' 
#' @examples
#' \dontrun{
#'     download_intRo()
#' }
download_intRo <- function(path = getwd()) {
    message("Downloading intRo to ", path, "/intRo")
    path <- file.path(path, "intRo")
    clone("https://github.com/gammarama/intRo", local_path = path, branch = "application")
}
