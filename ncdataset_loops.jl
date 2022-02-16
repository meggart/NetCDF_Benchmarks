using NCDatasets
const ncd = NCDatasets

include("common.jl")
filename = parse_inputs()["filename"]
# Note: sqrt should be taken on the maximum
# But keep this choice for consistency with other benchmarks
function get_max_sp_ncdatasets3(fname)
    NCDataset(fname) do ds
        ncu = ds["USFC"];
        ncv = ds["VSFC"];
        sz = size(ncu)
        u = zeros(Float32,sz[1],sz[2]);
        v = zeros(Float32,sz[1],sz[2]);
        max_speed = zeros(Float32,sz[3])
        speed = zeros(Float32,sz[1],sz[2]);

        @inbounds for t = 1:sz[3]
            ncd.load!(ncu.var,u,:,:,t)
            ncd.load!(ncv.var,v,:,:,t)
            @. speed = sqrt(u^2 + v^2)
            # this avoids the array speed but it is not faster
            #max_speed[t] = maximum(uv -> sqrt(uv[1]^2 + uv[2]^2),zip(u,v))
            max_speed[t] = maximum(speed)
        end
        return max_speed
    end
end

#max_speed3 = @time get_max_sp_ncdatasets3(file_unchunked);
t1 = @elapsed get_max_sp_ncdatasets3("smallarray.nc");
t2 = @elapsed get_max_sp_ncdatasets3(filename);

printresults("NCDataset_Loops",filename, t1, t2)
