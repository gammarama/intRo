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
- Focused on aspects of the user interface (UI) and output that make it easy to pick up without training
- Minimal necessary functionality for an introductory statistics course
- Organized around specific tasks a student may perform in the process of a data analysis

<img src=images/user_experience.png height="300"></img>

Exciting
========================================================
 - Fun, easy to use (available on the web)
 - Interactive plots using `ggvis`
 
~~Ulterior motive~~: get students excited about programming
 - By navigating about the user interface of intRo, students are creating a fully-executable `R` script that they can download and run locally
 - Viewing their script change real-time within the application
 
Extensible
========================================================
 - User interaction with intRo is split into bitesize chunks that we call *modules*
 - Each module is a self contained set of `R` code that is dynamically added to the application at run time
 - `intRo` can be easily extended by the addition of modules within the frame-work underlying the application
 - Allows `intRo` to be tailored to the needs of a particular course

First look
========================================================
type: section

http://intro-stats.com


Classroom
========================================================
type: section

intRo in the wild
========================================================
 - `intRo` is currently being used in STAT 201
  - Homework assignments and labs will use `intRo` to emphasize class concepts
 - `intRo` is a supplement, not the focus of the class 

Homework 1
=======================================================
 - *Data*: OECD PISA Results in Focus report to assess the workforce readiness of 15-year old students
 - *Goal*: Explore graphically and numerically how the students perceive academics and math
 - `intRo` *Tasks*:
   1. Make a summary of the Enjoy.Maths variable. What proportion of these students agree or strongly agree with the statement "I enjoy mathematics"?
  1. Make a barchart of the variable Enjoy.Maths.
  1. Give the conditional distribution of ``Strongly agree'' given the Country.
  2. Obtain a contingency table and mosaic plot of the relationship between Country and Enjoy.Maths
 
Our turn
=======================================================
type: section


Design decisions
========================================================
type: section

Consistent UI
=======================================================
Elements of `intRo`: 1) top navigation, 2) side navigation, 3) options
panel, 4) results panel, and 5) code panel.

<img src="images/ui_annotate.png" height="500"></img>


Consistent UI (Cont'd)
========================================================
 - Large, easy to click icons in the page header to help students find
exactly what they need easily
 - Each module maintains a consistent layout, helping the user to become familiar with the location of the options, the results, and the code
 - Documentation website that is consistent with
the interface of the application; covers all default modules and makes learning to use `intRo` even more painless

Modularity
=======================================================
![app creation](images/app_creation_modules.png)

Modularity (Cont'd)
=========================================================
The interface is created with the following statement

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
The server functions are dynamically generated using a similar method

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

Tradeoffs
========================================================
There were a number of challenges we encountered in striving to strike the balance of functionality and ease-of-use:

* Storing the user's results
* Presenting only relevant options to the user
* Producing clean and executable R code

Storing results
========================================================
* Users must be able to print results, but only the results they want
* Reactivity makes this somewhat challenging

~~Solution~~: Store Buttons

![](images/store.png)

Storing results (Cont'd)
========================================================
* Each module contains, at the bottom, a Store button
* When Store is pressed, code is stored in code panel
    * Additional challenge: All options selected must also be stored!
* When user goes to print results, only this particular code is executed

Presenting choices
========================================================
* `intRo` is flexible, but must also be simple for the introductory student
* Despite increasing the complexity of the code, we decided to only show options appropriate for the given selections.

~~Example~~:

<img src="images/graphical.png" height="300">

Presenting choices (Cont'd)
========================================================
<img src="images/graphical_table.png">

Producing clean code
========================================================
Code generated must be:

* Executable on the server
* Executable on the user's machine
* Clean

Producing clean code (Cont'd)
========================================================
But how do we handle uploaded data?


```r
file.choose <- function () {
    return(input$data_own[,"datapath"])
}
```

Now we can provide to the user *and* the server:


```r
intro.data <- read.csv(file.choose())
```

Future work
========================================================
type: section

What's next?
========================================================
* Module creation package
* Server load
* Use in other classes

Module creation package
========================================================
*Modularity* is a key feature of `intRo`, but module creation is currently:
* Undocumented
* Entirely manual
* Unnecessarily lengthy

~~Idea~~: R package (with associated Shiny app?) to automate creation of `intRo` modules

Server load
========================================================
Limited testing has been done to assess how `intRo` handles heavy user load
* Dozens of students at accessing app at once
* Simultaneous larger computations like printing results

More server resources may need to be devoted to handle this, particularly if `intRo` is more widely adopted

More Classes
========================================================
* We would like to see `intRo` used in more classes
* Module creation package will allow it to suit more curricula
* We welcome collaborators interested in extending `intRo` to submit pull requests on GitHub (http://www.github.com/gammarama/intRo)
    * Additional modules
    * Improvements and bug fixes

Special thanks
========================================================
Dr. Cook, for guiding many of the features and interface decisions, and helping test the functionality in preparation for STAT 201

Any questions?
========================================================
type: section

Thank you!

Contact:<br/>
ajkaplan@iastate.edu<br/>
erichare@iastate.edu

