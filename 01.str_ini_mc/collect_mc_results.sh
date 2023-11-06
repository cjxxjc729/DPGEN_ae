#!/bin/bash

home_dir=$(pwd)

digfs << EOF
POSCAR
-1
EOF

shorten_dir_by_ramdomly_pick_some_files.sh << EOF
POSCAR_coll
50
EOF

rm -rf POSCAR_coll
cd POSCAR_coll_shorten
  fs=$(lxargs POSCAR)
  vaspout_to_cif.py << EOF
$fs
EOF
  rm $fs

cd $home_dir

mv POSCAR_coll_shorten mc.resutls.pp
