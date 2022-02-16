import NCDatasets as ncd
include("common.jl")
filename = parse_inputs()["filename"]
dssmall = ncd.Dataset("./smallarray.nc")
ds=ncd.Dataset(filename)
get_max_sp_ncdatasets(t::Int,ds) = 
    maximum(sqrt.(ds["USFC"][:,:,t].^2 .+ ds["VSFC"][:,:,t].^2), dims = (1,2))[1]

t1 = @elapsed get_max_sp_ncdatasets.(1:2400,Ref(dssmall))
t2 = @elapsed get_max_sp_ncdatasets.(1:2400,Ref(ds))

printresults("ncd_gael", filename, t1, t2)