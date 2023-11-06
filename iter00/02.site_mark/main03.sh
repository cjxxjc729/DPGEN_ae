#!/bin/bash
home_dir=$(pwd)

mkdir 03.str_validation
cd 03.str_validation
cp ../02.correction/*data ./
echo "../../01.learning_sets_in" >  connect_to_group_dp.sh.in.t
connect_to_group_dp.sh < connect_to_group_dp.sh.in.t
rm -rf connect_to_group_dp.sh.in.t

#all_calculate_atomic_e_model_dev.py
hpc_ae_in_20_groups.sh
#sub_all_data_no_rest_test.sh

