intRo
=====

Shiny-based statistics learning application available at http://www.intro-stats.com . 

Detailed documentation and tutorial for use available at http://gammarama.github.io/intRo .

Motivation
-----------
The goal of intRo is to foster a student interest in coding while learning basic statistics, or at a minimum, help students to learn a bit more about working with data. This project serves as a prototype of this application, with functionality that exhibits the basic user experience.

As a web-based application, this tool is immediately more familiar to students than a desktop application. The need for dealing with software licenses, installation configuration, and supported platforms has been eliminated. This allows students to spend more time working with the data and learning statistics than having to struggle to get the software running.

Running Locally
----------
To run the application locally, clone the repository and checkout branch `master`. Navigate to the directory and execute the following in `R`:
```
library(shiny)
runApp()
``` 


To run the documentation locally on a machine with Jekyll installed and configured for GitHub Pages, checkout the `gh-pages` branch and execute the following command in the terminal: 
```
bundle exec jekyll serve --baseurl ''
``` 

For more information on installing Jekyll and configuring for GitHub Pages, please see https://help.github.com/articles/using-jekyll-with-pages .
