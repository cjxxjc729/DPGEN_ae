#!/bin/bash
read -p "tell the traj file: " file

nline_timestep=$(grep -n TIMESTEP $file | sed "s/:/ /g" | awk -F ' ' '{print $1}')
nline_natm=$(grep -n "NUMBER OF ATOMS" $file | sed "s/:/ /g" | awk -F ' ' '{print $1}')
nline_box=$(grep -n "BOX BOUNDS" $file | sed "s/:/ /g" | awk -F ' ' '{print $1}')
nline_cor=$(grep -n  "ATOMS id" $file | sed "s/:/ /g" | awk -F ' ' '{print $1}')
nline_timestep=$(echo "$nline_timestep+1" | bc -l)
nline_natm=$(echo "$nline_natm+1" | bc -l)
nline_box=$(echo "$nline_box+1" | bc -l)
nline_box_end=$(echo "$nline_box+2" | bc -l)
nline_cor=$(echo "$nline_cor+1" | bc -l)
nline_cor_end=$(cat $file | wc -l)

sed -n "${nline_timestep},${nline_timestep}p" $file > timestep.t
sed -n "${nline_natm},${nline_natm}p" $file > natm.t
sed -n "${nline_box},${nline_box_end}p" $file > box.t
sed -n "${nline_cor},${nline_cor_end}p" $file > cor.t

./traj2poscar.py
timestep=$(cat timestep.t)
mv POSCAR.t POSCAR.$timestep
rm -rf natm.t box.t cor.t timestep.t 
