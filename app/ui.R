# This script contains the UI of the Shiny app


ui <- fluidPage(
  
  useShinyjs(),
  
  wellPanel(
    id = "big_well",
    
    fluidPage(
      
      theme = "styles.css",
      
      br(),
      br(),
      
      titlePanel(h1("Which programming language is most popular?", align = "center")),
      
      br(),
      br(),
      br(),
      
      fluidRow(
        
        column(
          6, 
          align = "center",
          
          wellPanel(
            id = "small_well",
            
            
            conditionalPanel(
              condition = "input.plotting_lang == 'ggplot'",
              br(),
              plotOutput("ggplot_barplot") %>%
                withSpinner(image = "r_loading.gif", image.width = 100, image.height = 100),
              br(),
              markdown("### This plot was made in `ggplot`")
            ),
            
            
            conditionalPanel(
              condition = "input.plotting_lang == 'D3'",
              br(),
              br(),
              d3Output("d3_barplot"),
              markdown("### This plot was made in `D3.js`")
            ),
                
                
            conditionalPanel(
              condition = "input.plotting_lang == 'seaborn'",
              br(),
              imageOutput("seaborn_barplot") %>% 
                withSpinner(image = "python_loading.gif", image.width = 100, image.height = 100),
              br(),
              markdown("### This plot was made in `seaborn`")
            )
                
          )
        ),
        
        
        column(
          6, 
          align = "center",
          
          
          wellPanel(
            id = "small_well",
            
            conditionalPanel(
              condition = "input.plotting_lang == 'ggplot'",
              br(),
              plotOutput("ggplot_lineplot") %>% 
                withSpinner(image = "r_loading.gif", image.width = 100, image.height = 100),
              br(),
              markdown("### This plot was made in `ggplot`")
            ),
             
            conditionalPanel(
              condition = "input.plotting_lang == 'D3'",
              br(),
              br(),
              d3Output("d3_lineplot"),
              markdown("### This plot was made in `D3.js`")
            ),
            
            conditionalPanel(
              condition = "input.plotting_lang == 'seaborn'",
              br(),
              plotOutput("seaborn_lineplot") %>% 
                withSpinner(image = "python_loading.gif", image.width = 100, image.height = 100),
              br(),
              markdown("### This plot was made in `seaborn`"))))),
      
      br(),
      
      fluidRow(
        column(
          12,
          align = "center",
          
          radioGroupButtons(
            inputId = "plotting_lang",
            label = NULL,
            choices = c("ggplot", "D3", "seaborn")
          )
        )
      ),
      
      fluidRow(
        column(
          12,
          align = "center",
          
          actionButton(
            inputId = "toggleOptions",
            label = "more data",
            icon = icon("Code", "fa-cogs"),
            width = 300
          ),
          
          hidden(
            div(
              id = "hidden_div",
              
              selectizeInput(
                inputId = "popularity_lang",
                label = NULL,
                choices = language_choices,
                multiple = TRUE,
                selected = c("JavaScript", "R", "Python")
              )
            )
          )
        )
      )
      
      
      
    )
  ),
  
  fluidRow(
    column(
      12,
      align = "right",
      HTML(
        '<a href="https://github.com/mnorrbo">
            <img src="github_logo.png" alt="Link to my GitHub" style="width:7%;height:7%;">
            </a>'
      ),
      
      HTML(
        '<a href="https://twitter.com/MandyNorrbo">
            <img src="twitter_logo.png" alt="Link to my Twitter" style="width:5%;height:5%;">
            </a>'
      )
    )
  )
)