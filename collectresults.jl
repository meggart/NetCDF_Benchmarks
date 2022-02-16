using DataFrames, CSV, Statistics
df = CSV.read("timings.csv",DataFrame,header=false)
gdf = groupby(df,:Column1)
combine(gdf,:Column4=>mean)