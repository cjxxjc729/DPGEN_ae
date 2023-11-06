#!/bin/bash


cd 01.learning_sets_in

make_dp_in_group_for_ae.sh << EOF
../../
EOF

cd init

sed -i "/exclude_types/d"  input-1.json
sed -i "/atom_ener/d" input-1.json

./dp_sub_cjx.sh

