# This script contains the UI of the Shiny app


ui <- fluidPage(
  sidebarLayout(
    
    
    sidebarPanel(

    
      selectizeInput(
        "popularity_lang", 
        "Select Programming Languages", 
        choices = language_choices,
        multiple = TRUE,
        selected = c("Python", "R", "JavaScript")
        
      ),
      
      selectizeInput(
        "year", 
        "Select Year",
        choices = year_choices,
        selected = "2020"
      ),
      
      selectizeInput("month",
                      "Choose a month",
                      choices = month_choices,
                      selected = "December")

      ),
    
    
    mainPanel(
      
      radioButtons(
        "plotting_lang",
        "Select your favourite plotting library",
        choices = c("ggplot", "seaborn", "D3")
      ),
      
      plotOutput(
        "ggplot_plot"
      )
    )
  )
)
