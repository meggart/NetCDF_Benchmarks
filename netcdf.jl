using NetCDF

include("common.jl")
filename = parse_inputs()["filename"]
# Note: sqrt should be taken on the maximum
# But keep this choice for consistency with other benchmarks
function get_max(fname)
    NetCDF.open(fname) do f
        usfc = f["USFC"]
        vsfc = f["VSFC"]
        ws = sqrt.(usfc.^2 .+ vsfc.^2)
        maximum(ws,dims=(1,2))
    end
end

#max_speed3 = @time get_max_sp_ncdatasets3(file_unchunked);
t1 = @elapsed get_max("smallarray.nc");
t2 = @elapsed get_max(filename);

printresults("NetCDF.jl", filename, t1, t2)
