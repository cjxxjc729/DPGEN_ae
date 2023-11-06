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

line0=$(grep_lineidx _atom_site_occupancy 0.cif)
line1=$(cat 0.cif | wc -l)
idx_tot=$(echo "$line1 -$line0" | bc -l)
E0=$(grep F= 0.cif.vasp/OSZICAR | awk -F ' ' '{print $3}')

rm -rf idx_ele_u.txt
for idx in `seq 1 ${idx_tot}`
do
  file=${idx}.cif.vasp
  if [ ! -f ${file}/OSZICAR ]
  then
    echo "OSZICAR do not exist"
    exit 1
  fi
  Ei=$(grep "F=" ${file}/OSZICAR | awk -F ' ' '{print $3}')
  #echo $E0
  #echo $Ei
  u=$(echo "$E0 $Ei" |awk '{print $1 - $2}' )
  line_atom_site_occupancy=$(grep_lineidx _atom_site_occupancy 0.cif)
  line_atom=$(echo "${line_atom_site_occupancy}+${idx}" | bc -l)
  ele=$(sed -n "${line_atom},${line_atom}p" 0.cif | awk -F ' ' '{print $1}')
  echo "$idx $ele $u"
  echo "$idx $ele $u" >> idx_ele_u.txt
done

#cp 0.cif.vasp/OUTCAR ./
#cp 0.cif.vasp/POSCAR ./
#make_deepmd_files.py


cat idx_ele_u.txt | awk -F ' ' '{print $3}' | xargs > ae.txt
any_to_xyz.py << EOF
0.cif
EOF

assign_value_in_xyz.py << EOF
ae.txt
0.xyz
EOF


ae_xyz_to_deepmd.py << EOF
0_ae.xyz
EOF

cd deepmd
raw_to_set.sh 50

#rm -rf deepmd/set.000
#cd deepmd
#raw_to_set.sh 50

