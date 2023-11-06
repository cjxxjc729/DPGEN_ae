#!/bin/bash

cp -r ../iter00/03.learning_sets_out_for_MC ./

cd 03.learning_sets_out_for_MC
home_dir=$(pwd)
cp -r ../02.site_mark/02.err_str_select/poscar/* ./
ref_poscar=$(ls -lt | grep POSCAR | awk -F ' ' '{print $9}' | head -1)
grep -B2 Direct $ref_poscar

read -p "enter the atoms id to do MC (example: 40 41 43-48 49 60-61)): "  mc_id

poscar_content=$(ls -l | grep POSCAR | awk -F ' ' '{print $9}' | xargs)

for pscarfile in $poscar_content
do
  echo "-------------fro $pscarfile-------------------"
  prefix=$(echo $pscarfile | sed "s/POSCAR\.//g")
  mkdir $prefix
  mv $pscarfile $prefix
  cd $prefix
    echo "$pscarfile" > gen_POTCAR.sh.in.t
    gen_POTCAR.sh < gen_POTCAR.sh.in.t
    rm -rf gen_POTCAR.sh.in.t
    cp ../MC_input/* ./
    cp $pscarfile POSCAR.0
    echo "$mc_id" > main.sh.in.t
    ./main.sh < main.sh.in.t
    echo "sleep 20s"
    sleep 20s
  cd $home_dir
done
