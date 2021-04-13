import pandas as pd
import seaborn as sns
from matplotlib.pyplot import figure

figure(figsize=(15, 5))

palette = {
  "C/C++": "#00599C",
  "C#": "#813084",
  "Java": "#F8981E",
  "JavaScript": "#F3D23C",
  "Julia": "#369325",
  "Matlab": "#F0800E",
  "Perl": "#113E62",
  "Python": "#336994",
  "R": "#2566B5",         
  "Ruby": "#B01E00",
  "Rust": "#000000",
  "Scala": "#DE3424",
  "Swift": "#E94F37"}
  


def make_python_barplot(data_input):
  ordered_data = data_input.sort_values("relative_perc", ascending = False).language
  bplot = sns.barplot(x = "relative_perc", y = "language", data = data_input, ci = False, orient = "h", order = ordered_data, palette = palette, saturation=1)
  bplot.spines['right'].set_visible(False)
  bplot.spines['top'].set_visible(False)
  bplot.spines['left'].set_visible(False)
  bplot.xaxis.set_ticks_position('bottom')
  bplot.xaxis.label.set_visible(False)
  bplot.yaxis.label.set_visible(False)
  bplot.set_xlim(0, 1)
  bplot.tick_params(axis='both', which='major', labelsize=15)
  bplot.tick_params(axis='both', which='minor', labelsize=15)
  bplot.get_figure().savefig("www/seaborn_barplot.png", bbox_inches = "tight", dpi = 600, transparent = True)
  bplot.get_figure().clf()

def make_python_lineplot(data_input):
  lplot = sns.lineplot(data = data_input, x = "year", y = "mean_yearly_pop", hue = "language", palette = palette)
  leg = lplot.legend_
  leg.set_title(None)
  leg.get_frame().set_linewidth(0.0)
  lplot.legend(framealpha=0,prop={'size': 15})
  lplot.spines['right'].set_visible(False)
  lplot.spines['top'].set_visible(False)
  lplot.spines['left'].set_visible(False)
  lplot.xaxis.set_ticks_position('bottom')
  lplot.xaxis.label.set_visible(False)
  lplot.yaxis.label.set_visible(False)
  lplot.tick_params(axis='both', which='major', labelsize=15)
  lplot.tick_params(axis='both', which='minor', labelsize=15)
  y_axis = lplot.axes.get_yaxis()
  y_axis.set_visible(False)
  lplot.get_figure().savefig("www/seaborn_lineplot.png", bbox_inches = "tight", dpi = 600, transparent = True)
  lplot.get_figure().clf()
