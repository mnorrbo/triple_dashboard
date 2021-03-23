library(shiny)
library(r2d3)

ui <- fluidPage(
  inputPanel(
    sliderInput("bar_max", label = "Max:",
                min = 0, max = 1, value = 1, step = 0.05)
  ),
  d3Output("d3")
)

server <- function(input, output) {
  output$d3 <- renderD3({
    r2d3(
      runif(5, 0, input$bar_max),
      script = system.file("examples/baranims.js", package = "r2d3")
    )
  })
}

shinyApp(ui = ui, server = server)



var barHeight = Math.floor(height / data.length);

var bars = r2d3.svg.selectAll('rect')
.data(r2d3.data);

bars.enter()
.append('rect')
.attr('width', function(d) { return d * width; })
.attr('height', barHeight)
.attr('y', function(d, i) { return i * barHeight; })
.attr('fill', 'steelblue');

bars.exit().remove();

bars.transition()
.duration(100)
.attr("width", function(d) { return d * width; });