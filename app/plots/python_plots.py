import pandas as pd
import seaborn as sns
from matplotlib.pyplot import figure

figure(figsize=(11, 4))

#popularity_df = pd.read_csv("clean_data/language_popularity.csv")
#
#popularity_df = popularity_df.loc[(popularity_df["year"] == 2004) & (popularity_df["language"].isin(["JavaScript", "Python", "R"])) & (popularity_df["month" == "April"])]
#
#
#popularity_df["total_col"] = popularity_df.groupby(by = ["year", "month"]).transform(lambda x: sum(x))
#
#
#popularity_df["relative_perc"] = popularity_df["popularity"]/popularity_df["total_col"]
#
#sns.barplot(x = "relative_perc", y = "language", data = popularity_df, ci = False).get_figure().savefig("www/test_plot.png", bbox_inches = "tight")

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
  "Swift": "#E94F37",
  "Visual Basic": "#506AA0"}
  


def make_python_plot(data_input):
  ordered_data = data_input.sort_values("relative_perc", ascending = False).language
  splot = sns.barplot(x = "relative_perc", y = "language", data = data_input, ci = False, orient = "h", order = ordered_data, palette = palette, saturation=1)
  splot.spines['right'].set_visible(False)
  splot.spines['top'].set_visible(False)
  splot.spines['left'].set_visible(False)
  splot.xaxis.set_ticks_position('bottom')
  splot.xaxis.label.set_visible(False)
  splot.yaxis.label.set_visible(False)
  splot.set_xlim(0, 1)
  splot.get_figure().savefig("www/seaborn_barplot.png", bbox_inches = "tight", dpi = 600)
  splot.get_figure().clf()
  return
