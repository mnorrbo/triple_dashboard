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
        
      )

      ),
    
    
    mainPanel(
      
      radioButtons(
        "plotting_lang",
        "Select your favourite plotting library",
        choices = c("ggplot", "D3")
      ),
      
      conditionalPanel(
        condition = "input.plotting_lang == 'ggplot'",
        plotOutput("ggplot_plot")
      ),
      
      conditionalPanel(
        condition = "input.plotting_lang == 'D3'",
        d3Output("d3")
      )
      
    )
  )
)
