# This script contains the server of the Shiny app


server <- function(input, output) {


# Data for bar plots ------------------------------------------------------

  filtered_bar_data <- reactive({
    popularity_df %>%
    filter(language %in% input$popularity_lang,
             year == "2020", 
             month == "December") %>% 
    group_by(year, month) %>%
      mutate(
        date_total = sum(popularity)
      ) %>%
      group_by(year, month, language, hex) %>%
      summarise(relative_perc = popularity/date_total, .groups = "keep") %>% 
      ungroup() %>%
      mutate(language = factor(language),
             language = forcats::fct_reorder(language, relative_perc))
  })
  

# Render bar plots --------------------------------------------------------


output$ggplot_barplot <- renderPlot({
    filtered_bar_data() %>% 
    make_barplot()
    
    })
  
  output$d3 <- renderD3({
    r2d3(
      data = filtered_bar_data(),
      script = "plots/d3_plots.js"
    )
  })


# Data for line plots -----------------------------------------------------

filtered_line_data <- reactive({ popularity_df %>% 
    filter(language %in% input$popularity_lang) %>% 
    group_by(language, year) %>% 
    summarise(mean_yearly_pop = mean(popularity)/100, .groups = "keep") %>% 
    ungroup()
})
  
  

# Render line plots -------------------------------------------------------

output$ggplot_lineplot <- renderPlot({
  filtered_line_data() %>% 
  make_lineplot()
  
})
  

}
# output$seaborn_plot <- renderImage{
#   source_python("plots/python_plots.py")
#   outfile <- tempfile()
#   }