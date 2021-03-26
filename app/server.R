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
      ungroup() %>% 
      group_by(year, month, language, hex) %>%
      summarise(relative_perc = popularity/date_total, .groups = "keep") %>% 
      ungroup() %>%
      mutate(language = factor(language),
             language = forcats::fct_reorder(language, relative_perc)) %>% 
      select(language, relative_perc, hex)
  })
  

# Render bar plots --------------------------------------------------------


output$ggplot_barplot <- renderPlot({

    filtered_bar_data() %>% 
    make_barplot()
    },bg="transparent")
  
  output$d3_barplot <- renderD3({
    r2d3(
      data = filtered_bar_data(),
      script = "plots/d3_plots.js"
    )
  })


output$seaborn_barplot <- renderImage({


    make_python_barplot(filtered_bar_data())

  
  pfad <- "www/seaborn_barplot.png"
  list(src = pfad,
       contentType = 'image/png',
       width = "100%",
       height = "100%",
       alt = "Relative popularity of programming languages in December 2020")
}, deleteFile = F
)



# Data for line plots -----------------------------------------------------

filtered_line_data <- reactive({ 
  popularity_df %>% 
    filter(language %in% input$popularity_lang) %>% 
    group_by(language, year, hex) %>% 
    summarise(mean_yearly_pop = mean(popularity)/100, .groups = "keep") %>% 
    ungroup()
})
  
  

# Render line plots -------------------------------------------------------

output$ggplot_lineplot <- renderPlot({

  filtered_line_data() %>% 
  make_lineplot()
},bg="transparent")

output$seaborn_lineplot <- renderImage({
  
  
  make_python_lineplot(filtered_line_data())
  
  
  pfad <- "www/seaborn_lineplot.png"
  list(src = pfad,
       contentType = 'image/png',
       width = "100%",
       height = "100%",
       alt = "This is alternate text")
}, deleteFile = F
)


# Toggle options ----------------------------------------------------------


  observeEvent(input$toggleOptions, {
    shinyjs::toggle(id = "my_div",
                    anim = TRUE)
  })
}
# output$seaborn_plot <- renderImage{
#   source_python("plots/python_plots.py")
#   outfile <- tempfile()
#   }