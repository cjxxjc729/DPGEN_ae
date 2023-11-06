#!/bin/bash
home_dir=$(pwd)
#script_dir=
#tmp_dir=
#mkdir 

#read -p "enter the prefix: " prefix
#read -p "enter the ref pwin file: " f_ref

#--------------------------------------------------------

check_file_list=""

for check_file in $check_file_list
do
  file_exit_sig=$(whether_files_exists.sh $check_file)

  if [ ${file_exit_sig} -eq 0 ]
  then
    echo "missing files"
    echo "check $check_file_list"
    exit 5
  fi
done

read -p "enter the cif file(s): " f_cifs
for f_cif in ${f_cifs}
do
  prefix=$(echo ${f_cif} | awk -F '.cif' '{print $1}')
  mkdir ${prefix}.cif.vasp
  echo "cp ${f_cif}  ${prefix}.cif.vasp/0.cif"
  cp ${f_cif}  ${prefix}.cif.vasp/0.cif
  echo "cp ${prefix}_ae_std.txt ${prefix}.cif.vasp/"
  cp ${prefix}_ae_std.txt ${prefix}.cif.vasp/0_ae_std.txt
  cd ${prefix}.cif.vasp
  ls
  sleep 10s 


  line_atom_site_occupancy=$(grep -n "_atom_site_occupancy" 0.cif | awk -F ':' '{print $1}')
  n_line_cif=$(cat 0.cif | wc -l)
  natm=$(echo "$n_line_cif-$line_atom_site_occupancy" | bc -l)

#---------------make dp list and dft list----------------------------#
  python -c "import numpy as np
#trust_thesh = 0.1  # if the value surpass this, use dp, other use dft
trust_thesh = 0.00
M=np.loadtxt('0_ae_std.txt')
id_dft=[]
id_dp=[]
for atm_id in range(len(M)):
  if M[atm_id,1] <= trust_thesh:
    id_dp.append(atm_id+1)
  else:
    id_dft.append(atm_id+1)
np.savetxt('id_for_dft.txt',id_dft,fmt='%d')
np.savetxt('id_for_dp.txt',id_dp,fmt='%d')
"
id_for_dft=$(cat id_for_dft.txt | xargs)
id_for_dp=$(cat id_for_dp.txt | xargs)

#--------------------------------------------------------------------#

  for atm_id in $id_for_dft 
  do
    line_to_del=$(echo "${line_atom_site_occupancy}+${atm_id}" | bc -l)
    cp 0.cif ${atm_id}.cif
    sed -i "${line_to_del},${line_to_del}d"  ${atm_id}.cif
  done
  all_cif_to_vaspin_with_fix_list.sh

  for atm_id in $id_for_dft
  do

  cp /public1/home/sch0149/work/wen_group_work/zhiwen_lu/01.material_make_from_ae/iter17/03.labelling/10_1014.cif.vasp/30.cif.vasp/INCAR ./${atm_id}.cif.vasp/


  done
  cp /public1/home/sch0149/work/wen_group_work/zhiwen_lu/01.material_make_from_ae/iter17/03.labelling/10_1014.cif.vasp/30.cif.vasp/INCAR ./0.cif.vasp


  job_num_control 40

  sub_all_vasp_into_5_nodes.sh
  
  for atm_id in $id_for_dp
  do  
    mkdir ${atm_id}.cif.vasp
    #E_ae=$(cat 0_ae_std.txt  | awk -F ' ' '{print $1}')
    echo "1 F= 7527" > ${atm_id}.cif.vasp/OSZICAR
  done

  cd ${home_dir}
done

touch
