# This script defines global objects to de-clutter other scripts 

# Packages ----------------------------------------------------------------

library(shiny)
library(shinyjs)
library(shinyWidgets)
library(readr)
library(dplyr)
library(ggplot2)
library(r2d3)
library(shinycssloaders)

library(reticulate)
source("plots/r_plots.R")
source_python("plots/python_plots.py")
sns <- import('seaborn')
pd <- import("pandas")

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
    "Swift",
    "Visual Basic"
  )) %>% 
  pull(language)

# test <- popularity_df %>%
#   filter(language %in% c("JavaScript", "Python", "R"),
#          year == "2020",
#          month == "December") %>%
#   group_by(year, month) %>%
#   mutate(
#     date_total = sum(popularity)
#   ) %>%
#   group_by(year, month, language, hex) %>%
#   summarise(relative_perc = popularity/date_total, .groups = "keep") %>%
#   ungroup() %>%
#   mutate(language = factor(language),
#          language = forcats::fct_reorder(language, relative_perc)) %>%
#   select(language, relative_perc, hex)
# 
# test = sns$barplot(data = r_to_py(test), x = "language", y = "relative_perc")

# py_to_r(get_figure(test))
# .savefig("www/seaborn_barplot.png", bbox_inches = "tight")