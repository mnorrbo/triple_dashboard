# This script defines global objects to de-clutter other scripts 

# Packages ----------------------------------------------------------------

library(shiny)
library(readr)
library(here)

# Data --------------------------------------------------------------------

popularity_df <- read_csv("clean_data/js_py_r_popularity.csv")

