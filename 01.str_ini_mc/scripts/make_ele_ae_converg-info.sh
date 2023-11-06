#!/bin/bash
home_dir=$(pwd)
#script_dir=
#tmp_dir=
#mkdir 

#read -p "enter the prefix: " prefix
#read -p "enter the ref pwin file: " f_ref

#--------------------------------------------------------
rm -rf ele_ae.t if_convege.t
cd deepmd
  dpfile_to_xyz.py
  cat deepmd.xyz | sed '1,2d' | awk -F ' ' '{print $1,$NF}' > ../ele_ae.t

cd $home_dir

max_idx=$(lld | grep "cif.vasp" | grep -v deepmd | grep -v "^0.cif.vasp$" | wc -l)


for i in `seq 1 $max_idx`
do
  convege_step=$(grep RMM ${i}.cif.vasp/OSZICAR | tail -1 | awk -F ' '  '{print $2}' )
  if [ $convege_step -eq 128 ]
  then
    echo false >> if_convege.t
  else
    echo true >> if_convege.t
  fi

done

paste ele_ae.t if_convege.t > ele_ae_ifconverge.txt
