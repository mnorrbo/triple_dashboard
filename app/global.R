# This script defines global objects to de-clutter other scripts 

# Packages ----------------------------------------------------------------

library(shiny)
library(readr)
library(dplyr)
library(ggplot2)
library(r2d3)
# library(reticulate)
# sns <- import("seaborn")
# pd <- import("pandas")

# Data --------------------------------------------------------------------

popularity_df <- read_csv("clean_data/js_py_r_popularity.csv")


# Create choice vectors for UI input --------------------------------------

language_choices <- unique(popularity_df$language)

year_choices <- unique(popularity_df$year)

month_choices <- unique(popularity_df$month)

