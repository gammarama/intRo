if (!("package:dplyr" %in% search())) interpolate(~(library(dplyr)), file = "code_All.R", mydir = userdir, append = TRUE)
if (!("package:ggplot2" %in% search())) interpolate(~(library(ggplot2)), file = "code_All.R", mydir = userdir, append = TRUE)
if (!("package:ggvis" %in% search())) interpolate(~(library(ggvis)), file = "code_All.R", mydir = userdir, append = TRUE)
