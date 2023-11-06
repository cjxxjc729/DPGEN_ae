#!/bin/bash
home_dir=$(pwd)
echo "we will begin the MC simulation. the POSCAR.0 should be prepared.
"
grep -B2 Direct POSCAR.0

read -p "enter the id list yout want to switch: (example: 40 41 43-48 49 60-61)) "  id_lists
echo $id_lists > initialize_list_file.sh.in.t
./initialize_list_file.sh < initialize_list_file.sh.in.t
rm -rf initialize_list_file.sh.in.t


for i in `seq 1 1`
do
  mkdir seed$i
  cd seed$i
  cp ../MC.sh MC-seed${i}.sh
  cp ../POSCAR.0 ./POSCAR
  cp ../POTCAR ./
  cp ../INCAR ./
  cp ../KPOINTS ./
  cp ../switch_id_list ./
  cp ../all_ordered_eleid_list ./
  T=$(echo "$i*300" | bc -l)
  RT=$(echo "0.025875/300*$T" | bc -l)
  echo $RT > RT.t
  sed -i "s/RT=0.025875/RT=${RT}/g" MC-seed${i}.sh
  #sbatch -A slchen -p hpib MC-seed${i}.sh 
  sbatch MC-seed${i}.sh
  sleep 40s
  cd $home_dir
done
