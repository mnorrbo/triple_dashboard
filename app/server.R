# This script contains the server of the Shiny app


server <- function(input, output) {
  
  # Reactive relative percentages ------------------------
  filtered_data <- reactive({
    popularity_df %>%
      filter(language %in% input$popularity_lang, 
             year %in% input$year, 
             month %in% input$month) %>%
    group_by(year, month) %>%
      mutate(
        date_total = sum(popularity)
      ) %>%
      group_by(year, month, language) %>%
      summarise(relative_perc = popularity/date_total, .groups = "keep")
    
  })
  
  
  output$ggplot_plot <- renderPlot({
    filtered_data() %>% 
    ggplot() +
    aes(x = language, y = relative_perc) +
    geom_col() +
    scale_y_continuous(breaks = seq(0, 1, 0.2), limits = c(0, 1)) +
    coord_flip()
    
    })
  
  
  output$d3 <- renderD3({
    r2d3(
      data = filtered_data(),
      script = "plots/d3_plots.js"
    )
  })
    
  # output$seaborn_plot <- renderImage{
  #   source_python("plots/python_plots.py")
  #   outfile <- tempfile()
  #   }
}
