inputfile=$1
#!/bin/bash
[ -e timings.csv ] && rm timings.csv
for i in {1..10}
do
    echo "Run number $i"
    julia --project netcdf.jl $inputfile
    julia --project ncdataset_gael.jl $inputfile
    julia --project ncdataset_loops.jl $inputfile
done