#!/bin/bash
script_DIR="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"
source $script_DIR/env.sh
echo "script_dir_global= ${script_dir_global}"
#-----------------------------------------------------#
home_dir=$(pwd)

#--------------------------------------------------------

fids=$(lld | xargs)

for fid in $fids
do
  echo "--------------- $fid ---------------"
  cd $fid
    if [ -d deepmd ]
    then
      ${script_dir_global}/make_ele_ae_converg-info.sh
    fi
    if grep false if_convege.t
    then
      echo "not converge!"
    fi
  cd $home_dir 

done
