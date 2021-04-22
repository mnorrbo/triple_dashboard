# Packages ----------------------------------------------------------------

suppressPackageStartupMessages({
  
  # Shiny-related packages
  library(shiny)
  library(shinyjs)
  library(shinyWidgets)
  library(shinydisconnect)
  library(shinycssloaders)
  library(shinyalert)
  
  # Data wrangling and visualising
  library(readr)
  library(dplyr)
  library(ggplot2)
  
  # D3 in R
  library(r2d3)
  
  # Python in R
  library(reticulate)
  
})


# Source plotting scripts -------------------------------------------------

source("plots/r_plots.R")

source_python("plots/python_plots.py")

# Data --------------------------------------------------------------------

popularity_df <- read_csv("clean_data/language_popularity.csv",
                          col_types = cols())


# Create choice vectors for UI input --------------------------------------

language_choices <- popularity_df %>% 
  distinct(language) %>%
  # selected subset of languages
  filter(language %in% c(
    "C/C++",
    "C#",
    "Java",
    "JavaScript",
    "Julia",
    "Matlab",
    "Perl",
    "Python",
    "R",         
    "Ruby",
    "Rust",
    "Scala",
    "Swift"
  )) %>% 
  pull(language)


# Text for About modal ----------------------------------------------------

about_text <- 
  "This app was created as a personal project to expand my 
  <br> Shiny, data viz and CSS skills. 
  <br> <br>
  The data used in this app comes from
  <a href = 'https://www.kaggle.com/muhammadkhalid/most-popular-programming-languages-since-2004'> Muhammad Khalid </a> 
  on Kaggle, who
  <br> obtained it from the <a href = https://pypl.github.io/PYPL.html>PYPL index</a>, which ranks programming languages
  <br> by how often language tutorials are searched on Google.
  <br>"