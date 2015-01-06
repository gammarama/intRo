<style>
.reveal section del,
.reveal h1 del,
.reveal h3 del {
  color: #1abc9c;
}

.reveal, .reveal h3 {
  color: #2c3e50;
}

.reveal section code {
  font-size: 24px;
}

.reveal table {
  font-size: 14px;
  border-collapse: collapse;
  float: left;
}


/*** section background ***/
.section .reveal .state-background {
   background: #2c3e50;
}

.section .reveal a {
  color: #ecf0f1;
}

/*** navigation color ***/
.reveal .controls div.navigate-left,
.reveal .controls div.navigate-left.enabled {
  border-right-color: #1abc9c;
}

.reveal .controls div.navigate-right,
.reveal .controls div.navigate-right.enabled {
  border-left-color: #1abc9c;
}

.reveal .controls div.navigate-up,
.reveal .controls div.navigate-up.enabled {
  border-bottom-color: #1abc9c;
}

.reveal .controls div.navigate-down,
.reveal .controls div.navigate-down.enabled {
  border-top-color: #1abc9c;
}

.reveal .controls div.navigate-left.enabled:hover {
  border-right-color: #148f77;
}

.reveal .controls div.navigate-right.enabled:hover {
  border-left-color: #148f77;
}

.reveal .controls div.navigate-up.enabled:hover {
  border-bottom-color: #148f77;
}

.reveal .controls div.navigate-down.enabled:hover {
  border-top-color: #148f77;
}

.reveal .progress span {
  background: #1abc9c;
}

.reveal blockquote {
  background: #1abc9c;
  color: white;
}
</style>



intRo
========================================================
author: Andee Kaplan & Eric Hare
date: January 12, 2015
font-family: Helvetica

Statistical  Analysis Software for Teaching
 
Introduction
========================================================
type: section

Do we really need another statistical software package?
========================================================
Short answer: ~~yes~~

 - `R` is great, but requires students to have some knowledge/interest in programming
 - JMP is powerful, but confusing to students
   - Licenses
   - Inconsistent UI
 - Students fight with software rather than focusing on the goal: statistics

What is intRo?
========================================================
 - A modern ~~web-based~~ application for performing basic data analysis and statistical routines
 - Built using `R` and `Shiny`
 - Powerful and extensible modular structure
 - Simple enough for the novice statistician
 - Meant to assist in the learning of statistics rather than a stand-alone deliverer of statistics education

Easy
========================================================

![user experience](images/user_experience.png)

Exciting
========================================================

Extensible
========================================================


Live demo
========================================================
type: section

http://intro-stats.com


Lesson plans
========================================================
type: section

Design decisions
========================================================
type: section

Consistent UI
========================================================

Code printing
=======================================================


Modularity
=======================================================
![app creation](images/app_creation_modules.png)

Modularity (Cont'd)
=========================================================
The interface is created with the following statement.

```r
## Source ui
module_info <- read.table("modules/modules.txt", header = TRUE, sep=",")
sapply(file.path("modules", dir("modules")[dir("modules") != "modules.txt"], "ui.R"), source)

## mylist is a list containing the different ui module code
## Create the UI
shinyUI(
    navbarPage("intRo", id="top-nav",  theme = "bootstrap.min.css",
               tabPanel(title="", icon=icon("home"),
                        fluidRow(
                            do.call(navlistPanel, c(list(id = "side-nav", widths = c(2, 10)), mylist))
                        )
               ), ...
    ))
```

Modularity (Cont'd)
=======================================================
The server functions are dynamically generated using a similar method.

```r
shinyServer(function(input, output, session) {
  ## Module info
  module_info <- read.table("modules/modules.txt", header = TRUE, sep=",")

  ## Modules
  types <- c("helper.R", "static.R", "observe.R", "reactive.R", "output.R")
  modules_tosource <- file.path("modules", 
                                apply(expand.grid(module_info$module, types), 1, paste, collapse = "/"))

  ## Source the modules
  for (mod in modules_tosource) {
      source(mod, local = TRUE)
  }
})
```

Challenges
========================================================
type: section

Future Work
========================================================
type: section

Questions?
========================================================
type: section

Thank you!

Contact:<br/>
ajkaplan@iastate.edu<br/>
erichare@iastate.edu

