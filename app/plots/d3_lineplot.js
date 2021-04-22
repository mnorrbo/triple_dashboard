// set margins

var margin = {left: 50, bottom: 70, right: 75};

// remove group

svg.select("g").remove()


// set transparent background

svg.style("background-color", "transparent")


// setting up the plot area

var plot = svg.append("g")
              .attr("transform", "translate(" + margin.left + "," + (-margin.bottom) + ")")

// creating nested data structure for line graph 

var data_nested = d3.groups(data, d => d.language)


// define empty arrays for for loop

var lines_data = [];

var max_y = [];

// reformatting nested data for line plot
// and finding the maximum popularities of each language to define max y value

for (var i = 0; i < data_nested.length; i++) {
  
  lines_data[i] = data_nested[i][1]
  var pops = [];
  
  for (var j = 0; j < lines_data[i].length; j++) {
    pops[j] = lines_data[i][j].mean_yearly_pop
  }
  
  max_y[i] = d3.max(pops)
}

// defining axis scales

var yScale = d3.scaleLinear()
               .domain([0, d3.max(max_y)])
               .range([height, margin.bottom])


var xScale = d3.scaleLinear()
               .domain([2004, 2020])
               .range([0, width - margin.right])

// define lines (path) with data from r2d3() function in server

var lines = plot.selectAll("path")
               .data(lines_data)


// create lines with dynamic attributes depending on data

lines.enter()
     .append("path")
     .attr("fill", "none")
     .attr("stroke", d => {return d[0].hex})
     .attr("stroke-width", 1.5)
     .attr("d", d => {
       return d3.line()
         .x(j => xScale(j.year))
         .y(j => yScale(j.mean_yearly_pop))
         (d)
     })

  
// create dynamic transitions

lines.transition()
     .attr("d", d => {
      return d3.line()
        .x(d => xScale(d.year))
        .y(d => yScale(d.mean_yearly_pop))
        (d)
     })


// remove lines that are no longer in the data

lines.exit().remove()

// define legend

var legend = plot.append("g")
                 .attr("transform", "translate(0," + margin.bottom + ")")

// define gap and text size for legend text

var l_sep = 20;

var l_text_size = 20;

// define legend lines

var legend_lines = legend.selectAll("path")
                         .data(lines_data)

// create legend lines that depend on data

legend_lines.enter()
            .append("path")
            .attr("stroke", d => {return d[0].hex})
            .attr("fill", "none")
            .attr("stroke-width", 1.5)
            .attr("d", (d, i) => {
              coords = [[0, l_sep*i+10],[30, l_sep*i+10]]
              return d3.line()(coords)
            })


// create legend line transitions

legend_lines.transition()
            .attr("stroke", d => {return d[0].hex})
            .attr("fill", "none")
            .attr("stroke-width", 1.5)
            .attr("d", (d, i) => {
              coords = [[0, l_sep*i+10],[30, l_sep*i+10]]
              return d3.line()(coords)
            })


// remove legend lines

legend_lines.exit().remove()

// define legend labels (text)

var legend_labels = legend.selectAll("text")
                          .data(lines_data)

// create legend labels that depend on data

legend_labels.enter()
             .append("text")
             .style("font-weight", "bold")
             .style("font-size", l_text_size)
             .attr("x", 34)
             .attr("y", (d, i) => l_sep*i+10+l_text_size/4)
             .attr("color", d => {return d[0].hex})
             .text(d => { return d[0].language })


// create dynamic transition for legend text

legend_labels.transition()
             .attr("y", (d, i) => l_sep*i+10+l_text_size/4)
             .attr("color", d => {return d[0].hex})
             .text(d => { return d[0].language })


// remove legend entries that are no longer in the data 

legend_labels.exit().remove()

// create axis lines with location, font size and ticks

plot.append("g")
   .attr("transform", "translate(0," + height + ")")
   .style("font-size", "20px")
   .call(d3.axisBottom(xScale).tickFormat(d3.format("d")));