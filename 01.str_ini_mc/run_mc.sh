#!/bin/bash


if [ -d mc ]
then
  rm -r mc
fi


#cp ../blank.cif ./

#先做一个mc
natm=$(get_natm_from_strfile.py blank.cif)
cif_to_vaspin_with_fix_list.sh << EOF
blank
EOF

cp -r mc0 mc

mv blank.cif.vasp/POSCAR ./mc/POSCAR.0
mv blank.cif.vasp/POTCAR ./mc/POTCAR
rm -rf blank.cif.vasp POTCAR*

cd mc
  ./main.sh << EOF
1-${natm}
EOF


