data.sort(function(a, b) {
  return d3.descending(a.relative_perc, b.relative_perc)
});

var margin = {top: 20, right: 100, bottom: 30, left: 100};

var lifted = height - margin.top- margin.bottom;

//var shifted = width - margin.left - margin.right;

var bars = r2d3.svg.selectAll('rect')
    .data(r2d3.data);
    
    
svg.select("g").remove()
    
var labels = r2d3.svg.selectAll("text")
    .data(r2d3.data);

var x = d3.scaleLinear().rangeRound([0, width - margin.right]);



x.domain([0, 1]);
//Math.max(data, function(d) { return d.relative_perc; })
//svg.append("g")
    //.attr("class", "axis axis--x")
    //.attr("transform", "translate(0," + height + ")")
    //.call(d3.axisBottom(x));

bars.enter()
    .append('rect')
      .attr("x", margin.left)
      .attr('width', function(d) { return x(d.relative_perc); })
      .attr('height', function(d) { return Math.floor(lifted / data.length) - 5; })
      .attr('y', function(d, i) { return i * Math.floor(lifted / data.length); })
      .attr('fill', function(d) { return d.hex; });
//    .attr("rx", 36);
      
//bars.append("text")
//    .text(function(d) { 
//        return d.language;
//    })
//    .attr("y", function(d, i) { return i * Math.floor(lifted / data.length); });
      

bars.transition()
  .duration(100)
  .attr("width", function(d) { return x(d.relative_perc); })
  .attr("height", function(d) { return Math.floor(lifted / data.length) - 5; })
  .attr("y", function(d, i) { return i * Math.floor(lifted / data.length); })
  .attr('fill', function(d) { return d.hex; });
  
bars.exit().remove();
  
labels.enter()
    .append("text")
      .attr("x", margin.left - 15)
      .attr("y", function(d, i) { return i * Math.floor(lifted/data.length) + (Math.floor(lifted/data.length) / 2); })
      .text(function(d) { return d.language})
      .attr("text-anchor", "end")
      
labels.transition()
  .duration(100)
  .attr("y", function(d, i) { return i * Math.floor(lifted/data.length) + (Math.floor(lifted/data.length) / 2); })
  .text(function(d) { return d.language});
  
labels.exit().remove();




svg.append("g")
    .attr("class", "axis axis--x")
    .attr("transform", "translate("+ margin.left + "," + lifted + ")")
    .call(d3.axisBottom(x).ticks(5, size= lifted));

//function(d, i) { return i * Math.floor(lifted / data.length); }