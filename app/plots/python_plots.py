import pandas as pd
import seaborn as sns

#popularity_df = pd.read_csv("clean_data/js_py_r_popularity.csv")
#
#popularity_df = popularity_df.loc[(popularity_df["year"] == 2004) & (popularity_df["language"].isin(["JavaScript", "Python", "R"])) & (popularity_df["month" == "April"])]
#
#
#popularity_df["total_col"] = popularity_df.groupby(by = ["year", "month"]).transform(lambda x: sum(x))
#
#
#popularity_df["relative_perc"] = popularity_df["popularity"]/popularity_df["total_col"]
#


def make_python_plot(data_input):
  return sns.barplot(
    x = "relative_perc",
    y = "language", 
    data = data_input, 
    ci = False).get_figure().savefig("www/seaborn_barplot.png", bbox_inches = "tight")

