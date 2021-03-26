# This script contains the UI of the Shiny app


ui <- fluidPage(
  
  useShinyjs(),
  
  setBackgroundColor("#FFDFD3"),
  
  theme = "styles.css",
  
  titlePanel(h1("Which programming language is most popular?", align = "center")),
  
  br(),
  br(),
  
  fluidRow(
  ),
  
  br(),
  br(),
  br(),
    
    fluidRow(
      
      column(6, align = "center",
             conditionalPanel(
               condition = "input.plotting_lang == 'ggplot'",
               br(),
               plotOutput("ggplot_barplot", width = "90%") %>% withSpinner(image = "r_loading.gif", image.width = 100, image.height = 100),
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
               imageOutput("seaborn_barplot") %>% withSpinner(image = "python_loading.gif", image.width = 100, image.height = 100),
               br(),
               markdown("### This plot was made in `seaborn`")),
             
      ),
      column(6, align = "center",
             conditionalPanel(
               condition = "input.plotting_lang == 'ggplot'",
               br(),
               plotOutput("ggplot_lineplot") %>% withSpinner(image = "r_loading.gif", image.width = 100, image.height = 100),
               br(),
               markdown("### This plot was made in `ggplot`")),
             
             conditionalPanel(
               condition = "input.plotting_lang == 'seaborn'",
               br(),
               plotOutput("seaborn_lineplot") %>% withSpinner(image = "python_loading.gif", image.width = 100, image.height = 100),
               br(),
               markdown("### This plot was made in `seaborn`"))
      
    )),

  
  br(),
  br(),
  br(),
  
 
 
 br(),
 
 br(),
 
 
 fluidRow(
   column(4, align = "left", 
          actionButton(
            "toggleOptions", 
            label = "Options", 
            icon = icon("Code", "fa-cogs")),
          hidden(div(id = "my_div",
                     selectizeInput(
                       "popularity_lang", 
                       label = "Add more language to plots", 
                       choices = language_choices,
                       multiple = TRUE,
                       selected = c("JavaScript", "R", "Python"),
                       options = list(minItems = 1))
                     
          ))),
   column(4, align = "center",
          radioGroupButtons(
            "plotting_lang",
            label = "I want to see the plots in:",
            choices = c("ggplot", "D3", "seaborn")
          )))
   

)
