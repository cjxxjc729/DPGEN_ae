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

#----------------------------------------

./main01.sh
cd 01.anneal_lmp
holdon
cd ${home_dir}
./main02.sh
cd ${home_dir}
./main03.sh 
./main04.sh
cd 04.cif_make


 



