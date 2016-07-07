# intRo
[![Travis-CI Build Status](https://travis-ci.org/gammarama/intRo.svg?branch=master)](https://travis-ci.org/gammarama/intRo)

## About
This repository contains our R Package for Downloading, Running, and Installing the intRo Statistical Software. You can use this to download and run your own instance of intRo. If you intend to use intRo for a class, you can also deploy your own customized instance of intRo to the ShinyApps.io service using this package. Note that if you only wish to demo the intRo statistical software, you can use our hosted instance available at http://www.intro-stats.com

## Installation
Currently, intRo is not available on CRAN, but can be installed directly from github using the **devtools** package. First install RStudio's **shinyapps** package, followed by intRo:

`devtools::install_github("rstudio/shinyapps")`

`devtools::install_github("gammarama/intRo")`

## Usage

There are three basic functions provided in the package:

* download_intRo - Downloads a current revision of intRo to your machine
* run_intRo - Runs an intRo session locally with the specified options
* deploy_intRo - Deploys an instance of intRo to ShinyApps.io with the specified options

The simplest way to download and run intRo is as follows:

    download_intRo() # downloads intRo to your current working directory
    run_intRo() # runs intRo with the default options

Once intRo is downloaded, it can be ran with the specified modules by passing the **enabled_modules** option. A **theme** from the shinythemes package can also be specified:

    run_intRo(enabled_modules = c("data/transform", "summaries/graphical"), theme = "cerulean")

Deploying intRo accepts the same arguments as run_intRo, and an additional argument to specify a Google Analytics tracking id, if desired.
