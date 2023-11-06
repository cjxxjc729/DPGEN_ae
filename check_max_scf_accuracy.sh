#!/bin/bash
home_dir=$(pwd)
#script_dir=
#tmp_dir=
#mkdir 

#read -p "enter the prefix: " prefix
#read -p "enter the ref pwin file: " f_ref

#--------------------------------------------------------


fids=$(find ./iter0*/03.labelling/ -type d -maxdepth 1 | grep '[0-9]$' | xargs)
n=$(find ./iter0*/03.labelling/ -type d -maxdepth 1 | grep '[0-9]$' | wc -l)
echo "find $n floders"

rm -rf id_max_value.txt
count=0
for fid in $fids
do
  ((count=count+1))
  cd $fid

  if [ !  -f sorted_num.t ]
  then

    echo "-------- $fid -------"
    grep -B5 "iteration # 70" *out | grep "estimated scf accuracy"  | awk -F ' ' '{print $6}'  > num.t
    sort_data.py << EOF
num.t
EOF
  fi 

  n_uncoverge_files=$(cat sorted_num.t | wc -l) 
  if [ $n_uncoverge_files -eq 0 ]
  then
    max_value=0
  else
    max_value=$(cat sorted_num.t | tail -1 )
  fi


  echo "$fid $max_value" >>  ${home_dir}/id_max_value.txt
  cd $home_dir
  echo "$count/$n" | bc -l

done

