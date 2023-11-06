#!/bin/bash 

script_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
source $script_DIR/env.sh
echo "script_dir_global= ${script_dir_global}"

lld > file.list

home_dir=$(pwd)
nfile=$(cat file.list | wc -l)


for i in `seq 1 $nfile`
do

file=$(cat file.list | head -$i | tail -1)
echo "-------------------$file begins ---------------------"
cd $file
${script_dir_global}/ae_maker.sh

cd $home_dir
echo "-------------------$file ends ---------------------"
done


