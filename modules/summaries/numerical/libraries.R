if (!("package:dplyr" %in% search())) interpolate(~(library(dplyr)), file = "code_All.R", mydir = userdir, append = TRUE)
if (!("package:tidyr" %in% search())) interpolate(~(library(tidyr)), file = "code_All.R", mydir = userdir, append = TRUE)
if (!("package:Hmisc" %in% search())) interpolate(~(library(Hmisc)), file = "code_All.R", mydir = userdir, append = TRUE)
