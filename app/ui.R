ui <- fluidPage(

# Basics & top of the page ------------------------------------------------

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
        tags$head(
          tags$link(rel = "icon", type = "image/png", href = "icon.png"), # tab icon
          tags$title("Triple Dashboard"))), # tab title

      br(),
      br(),
      br(),

      fluidRow(

        column(
          6, 
          align = "center",

# Small well | Left -------------------------------------------------------

          wellPanel(
            id = "small_well",

# Ggplot bar plot ----------------------------------------------------------

            conditionalPanel(
              condition = "input.plotting_lang == 'ggplot'",
              br(),
              plotOutput("ggplot_barplot") %>%
                
                # custom R loading spinner gif
                withSpinner(
                  image = "r_loading.gif", 
                  image.width = 100, 
                  image.height = 100
                ),
              br(),
              markdown("### This plot was made in `ggplot`")
            ),

# D3 bar plot --------------------------------------------------------------

            conditionalPanel(
              condition = "input.plotting_lang == 'D3'",
              br(),
              br(),
              d3Output("d3_barplot"),
              markdown("### This plot was made in `D3.js`")
            ),

# Seaborn bar plot ---------------------------------------------------------

            conditionalPanel(
              condition = "input.plotting_lang == 'seaborn'",
              br(),
              imageOutput("seaborn_barplot") %>%
                
                # custom python loading spinner gif
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



# Small well | Right ------------------------------------------------------

        column(
          6, 
          align = "center",

          wellPanel(
            id = "small_well",

# Ggplot line plot --------------------------------------------------------

            conditionalPanel(
              condition = "input.plotting_lang == 'ggplot'",
              br(),
              plotOutput("ggplot_lineplot") %>% 
                withSpinner(
                  image = "r_loading.gif", 
                  image.width = 100, 
                  image.height = 100
                ),

              br(),
              markdown("### This plot was made in `ggplot`")
            ),

# D3 line plot ------------------------------------------------------------

            conditionalPanel(
              condition = "input.plotting_lang == 'D3'",
              br(),
              br(),
              d3Output("d3_lineplot"),
              markdown("### This plot was made in `D3.js`")
            ),

# Seaborn line plot -------------------------------------------------------

            conditionalPanel(
              condition = "input.plotting_lang == 'seaborn'",
              br(),
              plotOutput("seaborn_lineplot") %>% 
                withSpinner(
                  image = "python_loading.gif", 
                  image.width = 100, 
                  image.height = 100
                ),
              br(),
              markdown("### This plot was made in `seaborn`"))))),

      br(),


# Plotting language button ------------------------------------------------

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

# Toggle more data button -------------------------------------------------

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

# Hidden data languages input ---------------------------------------------

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


# About button ------------------------------------------------------------

  fluidRow(
    
    column(
      6,
      align = "left",
      actionButton(
        inputId = "about", 
        label = tags$b("Want to know more?"))
    ),


# GitHub linked image -----------------------------------------------------

    column(
      6,
      align = "right",
      HTML(
        '<a href="https://github.com/mnorrbo">
        <img src="github_logo.png" alt="Link to my GitHub" style="width:12%;height:12%;">
        </a>'
      ),


# Twitter linked image ----------------------------------------------------

      HTML(
        '<a href="https://twitter.com/MandyNorrbo">
        <img src="twitter_logo.png" alt="Link to my Twitter" style="width:10%;height:10%;">
        </a>'
      )
    )
  ),


# Disconnect message ------------------------------------------------------

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
