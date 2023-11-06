#!/bin/bash
home_dir=$(pwd)
signature=$0

./scripts/configure.sh
#script_dir=
#tmp_dir=
#mkdir 

#read -p "enter the prefix: " prefix
#read -p "enter the ref pwin file: " f_ref

#--------------------------------------------------------

cd mc.resutls.pp

fs_cif=$(lxargs cif)
echo $fs_cif > step1.ae_maker_forHEA.sh.in.t

hpc_sub "../scripts/step1.ae_maker_forHEA.sh < step1.ae_maker_forHEA.sh.in.t"


