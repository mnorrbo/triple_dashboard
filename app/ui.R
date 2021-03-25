# This script contains the UI of the Shiny app


ui <- fluidPage(
  
  useShinyjs(),
  
  theme = "styles.css",
  
  titlePanel(h1("Which programming language is most popular?", align = "center")),
  
  br(),
  br(),
  
  
  fluidRow(column(12, align = "left",actionButton("toggleSidebar", "Add programming languages"))),
  
  fluidRow(
    
    column(12, align = "left",
           
           hidden(div(id = "my_div",
                      selectizeInput(
                        "popularity_lang", 
                        label = NULL, 
                        choices = language_choices,
                        multiple = TRUE,
                        selected = c("JavaScript", "R"),
                        options = list(minItems = 1))
           ))
    )),
    
    fluidRow(
      
      column(6, align = "center",
             conditionalPanel(
               condition = "input.plotting_lang == 'ggplot'",
               br(),
               plotOutput("ggplot_barplot") %>% withSpinner(image = "r_loading.gif", image.width = 100, image.height = 100),
               br(),
               markdown("### This plot was made in `ggplot`")
             ),
             
             conditionalPanel(
               condition = "input.plotting_lang == 'D3'",
               br(),
               br(),
               d3Output("d3_barplot"),
               markdown("### This plot was made in `D3.js`")
             )),
      
      column(6, align = "center",
             conditionalPanel(
               condition = "input.plotting_lang == 'ggplot'",
               br(),
               plotOutput("ggplot_lineplot") %>% withSpinner(image = "r_loading.gif", image.width = 100, image.height = 100),
               br(),
               markdown("### This plot was made in `ggplot`"))
      
    )
  ),
  
  br(),
  br(),
  br(),
  
  fluidRow(column(12, align = "center",
                  
                  radioGroupButtons(
                    "plotting_lang",
                    label = NULL,
                    choices = c("ggplot", "D3"),
                    status = "danger"
                  )
  )),

  fluidRow(column(12, align = "center",
                  
                  imageOutput("seaborn_barplot") %>% withSpinner()
                    )
                  )
)
