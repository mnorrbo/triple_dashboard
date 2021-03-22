# Dependencies & Raw Data -------------------------------------------------

library(readr) # version 1.0.4 
library(dplyr) # version 1.4.0
library(tidyr) # version 1.1.2
library(janitor) # version 2.1.0

## Data source: kaggle.com/muhammadkhalid/most-popular-programming-languages-since-2004
### This dataset contains data on the most popular Programming Languages 
### Data spans 2004 to 2020. 
### Numerical values are percentages

df <- read_csv("raw_data/programming_languages_popularity.csv")


# Checking Data -----------------------------------------------------------

# is percentage data accurate?
## the sum of all values for each row should equal 100
range_of_sums <- df %>%
  summarise(perc_sums = rowSums(.[-1])) %>% 
  summarise(range = range(perc_sums)) # [99.96, 100.04] OK range if rounded

# contains all months from all years?
## all years should contain 12 unique rows
year_obs <- df %>% 
  separate(Date, into = c("month", "year")) %>% 
  group_by(year) %>% 
  summarise(n()) # 2004 does not, contains 6

# Re-scaling percentages for JavaScript, Python & R ------------------------

# NOTE: May want to keep all languages for interactivity in Shiny app
# For now, just the 3 languages

df_subset <- df %>% 
  select(Date, JavaScript, Python, R) %>%
  pivot_longer(
    names_to = "language",
    values_to = "popularity",
    cols = JavaScript:R) %>%
  group_by(Date) %>% 
  mutate(
    date_total = sum(popularity)
    ) %>% 
  group_by(Date, language) %>%
  summarise(relative_perc = popularity/date_total)


# Create Year and Month columns -------------------------------------------

df_subset_clean <- df_subset %>% 
  separate(Date, 
           into = c("Month", "Year"),
           remove = F) %>% 
  clean_names()
  


# Write clean dataset -----------------------------------------------------

write_csv(df_subset_clean, "../app/clean_data/js_py_r_popularity.csv") 


# Clear all objects from Global Environment -------------------------------

# rm(list = ls())
