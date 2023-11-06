#!/bin/bash 

lld > fids.list

home_dir=$(pwd)
nfile=$(cat fids.list | wc -l)


for i in `seq 1 $nfile`
do

file=$(cat fids.list | head -$i | tail -1)
echo "-------------------$file begins ---------------------"
cd $file
#if [ ! -d deepmd ]
#then
../ae_maker.sh
#fi
percentage=$(echo "${i}/${nfile}*100" | bc -l | awk {printf'("%.3f\n",$0)'})
echo "$percentage %"

cd $home_dir
echo "-------------------$file ends ---------------------"
done


