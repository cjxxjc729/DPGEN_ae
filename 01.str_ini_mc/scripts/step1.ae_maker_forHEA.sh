#!/bin/bash
home_dir=$(pwd)
#script_dir=
#tmp_dir=
#mkdir 

#read -p "enter the prefix: " prefix
#read -p "enter the ref pwin file: " f_ref

#--------------------------------------------------------


read -p "enter the cif file(s): " fs_cif
for f_cif in ${fs_cif}
do
  prefix=$(echo ${f_cif} | awk -F '.cif' '{print $1}')
  mkdir ${prefix}
  echo "cp ${f_cif}  ${prefix}/0.cif"
  cp ${f_cif}  ${prefix}/0.cif
  cd ${prefix}
  ls
  echo "sleep 10s"
  sleep 10s 
    
    cif_to_vaspin_with_fix_list.sh << EOF
0
EOF 
    mv 0.cif.vasp/POSCAR ./
    vaspout_to_cif.py << EOF
POSCAR
EOF
    mv POSCAR.cif 0.cif
    rm -rf 0.cif.vasp


    line_atom_site_occupancy=$(grep -n "_atom_site_occupancy" 0.cif | awk -F ':' '{print $1}')
    n_line_cif=$(cat 0.cif | wc -l)
    natm=$(echo "$n_line_cif-$line_atom_site_occupancy" | bc -l)
    
    for atm_id in `seq 1 ${natm}`
    do
      line_to_del=$(echo "${line_atom_site_occupancy}+${atm_id}" | bc -l)
      cp 0.cif ${atm_id}.cif
      sed -i "${line_to_del},${line_to_del}d"  ${atm_id}.cif
    done
    all_cif_to_vaspin_with_fix_list.sh
    cp ../scripts/INCAR ./ 
    sed -i "s/ENCUT=.*/ENCUT=300/g" */INCAR
    sed -i "s/IBRION=.*/IBRION=-1/g" */INCAR
    sed -i "s/NSW=.*/NSW=1/g" */INCAR
    sub_all_vasp_into_5_nodes.sh
    cd ${home_dir}
done


