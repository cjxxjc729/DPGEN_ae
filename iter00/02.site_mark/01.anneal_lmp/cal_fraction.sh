#!/bin/bash
home_dir=$(pwd)
#script_dir=
#tmp_dir=
#mkdir 

#read -p "enter the prefix: " prefix
#read -p "enter the ref pwin file: " f_ref

#--------------------------------------------------------

fs_lpj=$(ls -lt traj/*lammpstrj |  head -10 | awk -F ' ' '{print $NF}' | xargs)

#rm -rf fractions.txt

for f_lpj in $fs_lpj
do
  n1=$(grep " 1 " $f_lpj   | wc -l )
  n2=$(grep " 2 " $f_lpj   | wc -l )
  n3=$(grep " 3 " $f_lpj   | wc -l )
  n4=$(grep " 4 " $f_lpj   | wc -l )
  n5=$(grep " 5 " $f_lpj   | wc -l )

  p1=$(echo "$n1 / 36 " | bc -l | awk {printf'("%.2f\n",$0)'})
  p2=$(echo "$n2 / 36 " | bc -l | awk {printf'("%.2f\n",$0)'})
  p3=$(echo "$n3 / 36 " | bc -l | awk {printf'("%.2f\n",$0)'})
  p4=$(echo "$n4 / 36 " | bc -l | awk {printf'("%.2f\n",$0)'})
  p5=$(echo "$n5 / 36 " | bc -l | awk {printf'("%.2f\n",$0)'})  

  echo "$p1 $p2 $p3 $p4 $p5"

done
