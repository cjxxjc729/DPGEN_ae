#!/bin/bash
mkdir 01.anneal_lmp

home_dir=$(pwd)
cd ../../
root_dir=$(pwd)
cd $home_dir

echo "$home_dir" 
#itern=$(echo "$home_dir" | sed 's\/02.site_mark\\g' | sed 's\/\ \g' | awk -F ' ' '{print $7}'  | sed 's/iter//')
#itern_neg1=$(echo "$itern-1" | bc -l)

cp -r  $root_dir/iter00/02.site_mark/01.anneal_lmp ./

cd 01.anneal_lmp
mkdir traj
ln -s ../../01.learning_sets_in/000/frozen_model.pb  ./graph.000.pb
ln -s ../../01.learning_sets_in/001/frozen_model.pb  ./graph.001.pb
ln -s ../../01.learning_sets_in/002/frozen_model.pb  ./graph.002.pb
ln -s ../../01.learning_sets_in/003/frozen_model.pb  ./graph.003.pb
sub_dp_lmp
