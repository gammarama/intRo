if (!("package:dplyr" %in% search())) interpolate(~(library(dplyr)), file = "code_All.R", mydir = userdir, append = TRUE, nodupes = TRUE)
if (!("package:YaleToolkit" %in% search())) interpolate(~(library(YaleToolkit)), file = "code_All.R", mydir = userdir, append = TRUE, nodupes = TRUE)
