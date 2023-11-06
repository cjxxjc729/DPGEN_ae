#!/bin/bash
home_dir=$(pwd)
#script_dir=
#tmp_dir=
#mkdir 

#read -p "enter the prefix: " prefix
#read -p "enter the ref pwin file: " f_ref

#--------------------------------------------------------

ntot=$(ls -1 | grep ae_std | wc -l)
ndone=$(lld | wc -l)
echo "ntot ndone"
echo "$ntot $ndone"

done_ratio=$(echo "$ndone/$ntot" | bc -l)
echo "$done_ratio"
