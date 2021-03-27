# This script contains the UI of the Shiny app


ui <- 
  fluidPage(wellPanel(
  id = "big_well",
  fluidPage(
  
  useShinyjs(),
  
  
  theme = "styles.css",
  
  titlePanel(h1("Which programming language is most popular?", align = "center")),
  
  br(),
  br(),
  br(),
    
    fluidRow(
      
      column(6, align = "center",
             wellPanel(
               id = "small_well",
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
               markdown("### This plot was made in `seaborn`"))),
             
      ),
      column(6, align = "center",
             
             wellPanel(
               id = "small_well",
             conditionalPanel(
               condition = "input.plotting_lang == 'ggplot'",
               br(),
               plotOutput("ggplot_lineplot") %>% withSpinner(image = "r_loading.gif", image.width = 100, image.height = 100),
               br(),
               markdown("### This plot was made in `ggplot`")),
             
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
               plotOutput("seaborn_lineplot") %>% withSpinner(image = "python_loading.gif", image.width = 100, image.height = 100),
               br(),
               markdown("### This plot was made in `seaborn`"))
      
    ))),
 
  br(),
  br(),
  br(),
 
 fluidRow(
   column(12, align = "center",
          radioGroupButtons(
            "plotting_lang",
            label = "I want to see the plots in:",
            choices = c("ggplot", "D3", "seaborn")
          ))),
 
 fluidRow(br()),

)),
fluidRow(column(12, align = "center", 
       actionButton(
         "toggleOptions", 
         label = "Options", 
         icon = icon("Code", "fa-cogs")),
       br(),
       hidden(div(id = "hidden_div",
                  br(),
                  selectizeInput(
                    "popularity_lang", 
                    label = NULL, 
                    choices = language_choices,
                    multiple = TRUE,
                    selected = c("JavaScript", "R", "Python"))
       )))))