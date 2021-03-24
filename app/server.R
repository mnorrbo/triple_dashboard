# This script contains the server of the Shiny app


server <- function(input, output) {
  
# Reactive relative percentages ------------------------
  filtered_data <- reactive({
    popularity_df %>%
      filter(language %in% input$popularity_lang, 
             year == "2020", 
             month == "December") %>% 
    group_by(year, month) %>%
      mutate(
        date_total = sum(popularity)
      ) %>%
      group_by(year, month, language) %>%
      summarise(relative_perc = popularity/date_total, .groups = "keep") %>% 
      ungroup() %>% 
      select(language, relative_perc) %>% 
      mutate(language = factor(language),
             language = forcats::fct_reorder(language, relative_perc))
  })
  

output$ggplot_plot <- renderPlot({
    filtered_data() %>% 
    make_plot()
    
    })
  
  output$d3 <- renderD3({
    r2d3(
      data = filtered_data(),
      script = "plots/d3_plots.js"
    )
  })
  
}
# output$seaborn_plot <- renderImage{
#   source_python("plots/python_plots.py")
#   outfile <- tempfile()
#   }