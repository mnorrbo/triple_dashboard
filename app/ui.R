# This script contains the UI of the Shiny app


ui <- fluidPage(
  
  setBackgroundImage("background3.png"),
  
  useShinyjs(),
  
  useShinyalert(),
  
  wellPanel(
    id = "big_well",
    
    fluidPage(
      
      theme = "styles.css",
      
      br(),
      br(),
      
      titlePanel(
        title = h1("Which programming language is most popular?", align = "center"),
        tags$head(tags$link(rel = "icon", type = "image/png", href = "icon.png"),
                  tags$title("Triple Dashboard"))),
      
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
                withSpinner(
                  image = "r_loading.gif", 
                  image.width = 100, 
                  image.height = 100
                ),
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
                withSpinner(
                  image = "python_loading.gif", 
                  image.width = 100, 
                  image.height = 100
                ),
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
      6,
      align = "left",
      actionButton("about", tags$b("Want to know more?"))
    ),
    
    column(
      6,
      align = "right",
      HTML(
        '<a href="https://github.com/mnorrbo">
            <img src="github_logo.png" alt="Link to my GitHub" style="width:12%;height:12%;">
            </a>'
      ),
      
      HTML(
        '<a href="https://twitter.com/MandyNorrbo">
            <img src="twitter_logo.png" alt="Link to my Twitter" style="width:10%;height:10%;">
            </a>'
      )
    )
  ),
  
  disconnectMessage(
    text = "Your session has timed out.",
    refresh = "Refresh",
    background = "#646464e6",
    size = 36,
    width = "full",
    top = "center",
    colour = "white",
    overlayColour = "#999",
    overlayOpacity = 0.4,
    refreshColour = "black"
  )
  
)
