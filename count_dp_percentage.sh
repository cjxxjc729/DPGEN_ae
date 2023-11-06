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

iter_content=$(ls -l | grep " iter" | awk -F ' ' '{print $9}' | xargs)

for iter in $iter_content
do
  labelling_content=$(lld ${iter}/03.labelling/  | xargs )
  echo "==============$iter====================="
  ndft_tot=0
  ndp_tot=0
  for f_cif_vasp in $labelling_content
  do
    if [ -f ${iter}/03.labelling/${f_cif_vasp}/id_for_dft.txt ]
    then
      ndft=$(cat  ${iter}/03.labelling/${f_cif_vasp}/id_for_dft.txt | wc -l)
      ndp=$(cat ${iter}/03.labelling/${f_cif_vasp}/id_for_dp.txt | wc -l)
      ndft_tot=$(echo "${ndft_tot}+${ndft}" | bc -l)
      ndp_tot=$(echo "${ndp_tot}+${ndp}" | bc -l)
    fi
  done

  echo "ndft_tot ndp_tot"
  echo "$ndft_tot $ndp_tot"
  if [ $ndp_tot -ne 0 ]
  then
    ratio=$(echo "${ndp_tot}/(${ndft_tot}+${ndp_tot})" | bc -l)
    echo $ratio
  fi
done
