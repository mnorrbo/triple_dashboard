import pandas as pd
import seaborn as sns

popularity_df = pd.read_csv("clean_data/js_py_r_popularity.csv")

popularity_df = popularity_df.loc[(popularity_df["year"] == 2004) & (popularity_df["language"].isin(["JavaScript", "Python", "R"])) & (popularity_df["month" == "April"])]


popularity_df["total_col"] = popularity_df.groupby(by = ["year", "month"]).transform(lambda x: sum(x))


popularity_df["percentage"] = popularity_df["popularity"]/popularity_df["total_col"]

test_plot = sns.barplot(x = "percentage", y = "language", data = popularity_df, ci = False, orient = "h")
plup = test_plot.get_figure()
plup.savefig("test_seaborn_plot.png", bbox_inches = "tight") 

