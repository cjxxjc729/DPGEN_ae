#!/bin/bash
ls -l  | grep  seed | awk -F ' ' '{print $9}' > file.list

home_dir=$(pwd)
nfile=$(cat file.list | wc -l)


for i in `seq 1 $nfile`
do

file=$(cat file.list | head -$i | tail -1)
echo "-------------------$file begins ---------------------"
cd $file
../make_deepmd_leanring_set.sh

cd $home_dir
echo "-------------------$file ends ---------------------"
done


