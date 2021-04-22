server <- function(input, output) {

# Wrangle data for bar plots ----------------------------------------------

  filtered_bar_data <- reactive({
    popularity_df %>%
      # most recent observations in dataset
      filter(
        language %in% input$popularity_lang,
        year == "2020",
        month == "December"
      ) %>%
      group_by(year, month) %>%
      mutate(date_total = sum(popularity)) %>%
      group_by(language, hex) %>%
      # relative percentage
      summarise(relative_perc = popularity/date_total, .groups = "drop") %>%
      mutate(
        language = factor(language),
        language = forcats::fct_reorder(language, relative_perc)
      ) %>% 
      select(language, relative_perc, hex)
  })
  

# Render ggplot bar plot --------------------------------------------------

output$ggplot_barplot <- renderPlot({

    filtered_bar_data() %>% 
    make_barplot()
    }, bg = "transparent")


# Render D3 bar plot ------------------------------------------------------
  
  output$d3_barplot <- renderD3({
    r2d3(
      data = filtered_bar_data(),
      script = "plots/d3_barplot.js"
    )
  })


# Render seaborn bar plot -------------------------------------------------

output$seaborn_barplot <- renderImage({
  
  make_python_barplot(filtered_bar_data())

  barplot_img <- "www/seaborn_barplot.png"
  list(src = barplot_img,
       contentType = 'image/png',
       width = "100%",
       height = "100%")},
  deleteFile = TRUE)


# Data for line plots -----------------------------------------------------

filtered_line_data <- reactive({ 
  popularity_df %>% 
    filter(language %in% input$popularity_lang) %>% 
    group_by(language, year, hex) %>%
    # mean popularity for each year
    summarise(mean_yearly_pop = mean(popularity)/100, .groups = "drop")
})


# Render ggplot line plot -------------------------------------------------

output$ggplot_lineplot <- renderPlot({

  filtered_line_data() %>% 
  make_lineplot()
}, bg = "transparent")


# Render D3 line plot -----------------------------------------------------

output$d3_lineplot <- renderD3({
  r2d3(
    data = filtered_line_data(),
    script = "plots/d3_lineplot.js"
  )
})

# Render seaborn line plot ------------------------------------------------

output$seaborn_lineplot <- renderImage({
  
  
  make_python_lineplot(filtered_line_data())
  
  
  lineplot_img <- "www/seaborn_lineplot.png"
  list(src = lineplot_img,
       contentType = 'image/png',
       width = "100%",
       height = "100%")}, 
  deleteFile = TRUE)


# Toggle options ----------------------------------------------------------

  observeEvent(input$toggleOptions, {
    shinyjs::toggle(id = "hidden_div",
                    anim = TRUE)
  })


# About modal -------------------------------------------------------------

  observeEvent(input$about, {
    shinyalert(
      title = "About", 
      text = about_text,
      className = "about_modal",
      html = TRUE,
      size = "l",
      animation = FALSE,
      closeOnClickOutside = TRUE,
      closeOnEsc = TRUE,
      showConfirmButton = FALSE, 
      imageUrl = "icon.png",
      imageWidth = 200,
      imageHeight = 200
    )
  })

}