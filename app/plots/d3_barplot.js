// sort data according to relative perc

data.sort((a, b) => {
  return d3.descending(a.relative_perc, b.relative_perc)
});

// define margins and lifted (height)

var margin = {top: 40, right: 150, bottom: 30, left: 120};

var lifted = height - margin.top - margin.bottom;

// remove axes

svg.select("g").remove()

// set transparent background

svg.style("background-color", "transparent")

    
// define bars (rect) and labels (text) with data from r2d3() in server

var bars = r2d3.svg.selectAll('rect')
    .data(r2d3.data);
    
var labels = r2d3.svg.selectAll("text")
    .data(r2d3.data);

// define x axis (used to determine width of bars)

var x = d3.scaleLinear()
          .domain([0, 1])
          .rangeRound([0, width - margin.right]);


// create bars with dynamic attributes depending on data

bars.enter()
    .append('rect')
      .attr("x", margin.left)
      .attr('width', function(d) { return x(d.relative_perc); })
      .attr('height', d => { return Math.floor(lifted / data.length) - 5; })
      .attr('y', (d, i) => { return i * Math.floor(lifted / data.length); })
      .attr('fill', d => { return d.hex; });

// create dynamic transitions

bars.transition()
  .duration(100)
  .attr("width", d => { return x(d.relative_perc); })
  .attr("height", d => { return Math.floor(lifted / data.length) - 5; })
  .attr("y", (d, i) => { return i * Math.floor(lifted / data.length); })
  .attr('fill', d => { return d.hex; });

// remove bars that are no longer in data

bars.exit().remove();


// create labels (define dynamic location and static alignment, size & weight)

labels.enter()
    .append("text")
      .attr("x", margin.left - 15)
      .attr("y", (d, i) => { 
        return i * Math.floor(lifted/data.length) + (Math.floor(lifted/data.length)/ 2);
      })
      .text(d => { return d.language})
      .attr("text-anchor", "end")
      .attr("font-size", "1.3em")
      .attr("font-weight", "bold")

// create label transition


labels.transition()
  .duration(100)
  .attr("y", (d, i) => { 
    return i * Math.floor(lifted/data.length) + (Math.floor(lifted/data.length) / 2); 
  })
  .text( d => { return d.language });
  

// remove labels that are no longer in data

labels.exit().remove();


// create axis lines with location, font size and ticks

svg.append("g")
    .attr("class", "axis axis--x")
    .attr("transform", "translate("+ margin.left + "," + lifted + ")")
    .style("font-size", "20px")
    .call(d3.axisBottom(x).ticks(5));

