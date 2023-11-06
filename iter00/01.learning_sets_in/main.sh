#!/bin/bash



make_dp_in_group_for_ae.sh << EOF
../../
EOF

cd init

sed -i "/exclude_types/d"  input-1.json
sed -i "/atom_ener/d" input-1.json

./dp_sub_cjx.sh

sleep 1m
cd ../
holdon_wait_following_dir_done_V2.sh
