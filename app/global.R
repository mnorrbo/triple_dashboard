# This script defines global objects to de-clutter other scripts 

# Packages ----------------------------------------------------------------
suppressPackageStartupMessages({
library(shiny)
library(shinyjs)
library(shinyWidgets)
library(readr)
library(dplyr)
library(ggplot2)
library(r2d3)
library(shinycssloaders)})

library(reticulate)
source("plots/r_plots.R")
source_python("plots/python_plots.py")
#sns <- import('seaborn')
#pd <- import("pandas")

# Data --------------------------------------------------------------------

popularity_df <- read_csv("clean_data/language_popularity.csv")


# Create choice vectors for UI input --------------------------------------

language_choices <- popularity_df %>% 
  distinct(language) %>% 
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
