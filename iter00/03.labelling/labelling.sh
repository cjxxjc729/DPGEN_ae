#!/bin/bash
home_dir=$(pwd)
signature=$0
#script_dir=
#tmp_dir=
#mkdir 

#read -p "enter the prefix: " prefix
#read -p "enter the ref pwin file: " f_ref

#--------------------------------------------------------

hpc_sub_hide_trace ./run_step1_by_6_group.sh

holdon_v1

hpc_sub ./step2.make_deepmd_in_eacho_floder.sh
