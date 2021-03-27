var margin = {left: 50, bottom: 70, right: 75};

svg.select("g").remove()

svg.style("background-color", "rgba(0, 0, 0, 0)")

var plot = svg.append("g")
              .attr("transform", "translate(" + margin.left + "," + (-margin.bottom) + ")")


var data_nested = d3.groups(data, d => d.language)


var data_plot = [];


var max_y = [];


for (var i = 0; i < data_nested.length; i++) {
  data_plot[i] = data_nested[i][1]
  var pops = [];
  for (var j = 0; j < data_plot[i].length; j++) {
    pops[j] = data_plot[i][j].mean_yearly_pop
  }
  max_y[i] = d3.max(pops)
}


var yScale = d3.scaleLinear()
               .domain([0, d3.max(max_y)])
               .range([height, margin.bottom])


var xScale = d3.scaleLinear()
               .domain([2004, 2020])
               .range([0, width - margin.right])


var lines = plot.selectAll("path")
               .data(data_plot)
               
lines.enter()
     .append("path")
     .attr("fill", "none")
     .attr("stroke", d => {return d[0].hex})
     .attr("stroke-width", 1.5)
     .attr("d", d => {
       return d3.line()
         .x(d => xScale(d.year))
         .y(d => yScale(d.mean_yearly_pop))
         (d)
     })

lines.transition()
     .attr("d", d => {
      return d3.line()
        .x(d => xScale(d.year))
        .y(d => yScale(d.mean_yearly_pop))
        (d)
     })

lines.exit().remove()

var legend = plot.append("g")
                 .attr("transform", "translate(0," + margin.bottom + ")")

var l_sep = 20;

var l_text_size = 20;

var legend_lines = legend.selectAll("path")
                         .data(data_plot)
                         
legend_lines.enter()
            .append("path")
            .attr("stroke", d => {return d[0].hex})
            .attr("fill", "none")
            .attr("stroke-width", 1.5)
            .attr("d", (d, i) => {
              coords = [[0, l_sep*i+10],[30, l_sep*i+10]]
              return d3.line()(coords)
            })

legend_lines.transition()
            .attr("stroke", d => {return d[0].hex})
            .attr("fill", "none")
            .attr("stroke-width", 1.5)
            .attr("d", (d, i) => {
              coords = [[0, l_sep*i+10],[30, l_sep*i+10]]
              return d3.line()(coords)
            })
            
legend_lines.exit().remove()

var legend_labels = legend.selectAll("text")
                          .data(data_plot)
                          
legend_labels.enter()
             .append("text")
             .style("font-weight", "bold")
             .style("font-size", l_text_size)
             //.attr("text-anchor", "start")
             .attr("x", 34)
             .attr("y", (d, i) => l_sep*i+10+l_text_size/4)
             .attr("color", d => {return d[0].hex})
             .text(d => { return d[0].language })

legend_labels.transition()
             .attr("y", (d, i) => l_sep*i+10+l_text_size/4)
             .attr("color", d => {return d[0].hex})
             .text(d => { return d[0].language })

legend_labels.exit().remove()

plot.append("g")
   .attr("transform", "translate(0," + height + ")")
   .style("font-size", "20px")
   .call(d3.axisBottom(xScale).tickFormat(d3.format("d")));