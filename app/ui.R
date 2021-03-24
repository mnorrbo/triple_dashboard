# This script contains the UI of the Shiny app


ui <- fluidPage(
  
  theme = "styles.css",
  
  titlePanel(markdown("# Popularity of programming languages")),
 
  sidebarLayout(
    
   
    
    sidebarPanel(


      tags$div(
        id='my_div',
        class='my_class',
        selectizeInput(
        "popularity_lang", 
        "Select Programming Languages", 
        choices = language_choices,
        multiple = TRUE,
        selected = c("R", "JavaScript")
        
      )),
      
      radioGroupButtons(
        "plotting_lang",
        "Select your favourite plotting library",
        choices = c("ggplot", "D3"),
        status = "danger"
      )

      ),
    
    
    mainPanel(

      
      
      conditionalPanel(
        condition = "input.plotting_lang == 'ggplot'",
        markdown("### This plot was made in `ggplot`"),
        br(),
        plotOutput("ggplot_barplot"),
        plotOutput("ggplot_lineplot")
      ),
      
      conditionalPanel(
        condition = "input.plotting_lang == 'D3'",
        markdown("### This plot was made in `D3.js`"),
        br(),
        br(),
        d3Output("d3")
      )
      
    )
  )
)
