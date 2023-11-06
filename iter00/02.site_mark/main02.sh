#!/bin/bash

mkdir 02.correction
home_dir=$(pwd)
cd 01.anneal_lmp
shorten_dir_by_ramdomly_pick_some_files.sh << EOF
traj
1600
EOF
cd $home_dir

cd 02.correction
cp ../01.anneal_lmp/traj_shorten/* ./
#expel_the_same_file.sh
sleep 20s
all_lpj_to_data_replace_version.sh




