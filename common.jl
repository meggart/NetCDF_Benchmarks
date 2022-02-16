using ArgParse

function parse_inputs()
    s = ArgParseSettings()
    @add_arg_table s begin
        "filename"
            help = "NetCDF file to be tested"
            required = true
    end

    return parse_args(s)
end

function printresults(method,file,t1,t2)
println(method,": ",t1," ",t2)
open("timings.csv",write=true,create=true, append=true) do f
    println(f,method,";",file,";",t1,";",t2)
end
end