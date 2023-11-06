#!/bin/bash
home_dir=$(pwd)
echo "./main01.sh"
./main01.sh

echo "./01.learning_sets_in/000 ./01.learning_sets_in/001 ./01.learning_sets_in/002 ./01.learning_sets_in/003/" > holdon_wait_following_dir_done.sh.in.t
holdon_wait_following_dir_done.sh < holdon_wait_following_dir_done.sh.in.t
rm -rf holdon_wait_following_dir_done.sh.in.t

echo "./main02.sh"
./main02.sh
#--------------------------------------------------------
cd 02.site_mark
echo "./main21.sh"
./main21.sh

echo "./01.anneal_lmp/" > holdon_wait_following_dir_done.sh.in.t
holdon_wait_following_dir_done.sh < holdon_wait_following_dir_done.sh.in.t
rm -rf holdon_wait_following_dir_done.sh.in.t
#========================================================
echo "./main22_for_MC.sh"
./main22_for_MC.sh
#-------------------------------------------------------
cd $home_dir
echo "./main03_for_MC.sh"
./main03_for_MC.sh << EOF
1-104
EOF

echo "do vasp"
cd 03.learning_sets_out_for_MC
dirs_in_active=$(ls -l  | grep ^d | awk -F ' ' '{print $9}' | xargs )
echo $dirs_in_active > holdon_wait_following_dir_done_new_V.sh.in.t
holdon_wait_following_dir_done_new_V.sh < holdon_wait_following_dir_done_new_V.sh.in.t
rm -rf holdon_wait_following_dir_done_new_V.sh.in.t
echo "make dp system files"
./main2.sh

