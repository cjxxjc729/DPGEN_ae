#!/bin/bash
home_dir=$(pwd)
#script_dir=
#tmp_dir=
#mkdir 

#read -p "enter the prefix: " prefix
#read -p "enter the ref pwin file: " f_ref

#--------------------------------------------------------

fids=$(lld | grep iter | grep -v iter00)

for fid in $fids
do
  echo "------------------ $fid --------------------------"
  cd ${fid}/02.site_mark/03.str_validation/
    fs=$(ls -1 | grep ae_std.txt | xargs )
    rm -rf ae_std_coll
    for f in $fs
    do
      cat $f | awk -F ' ' '{print $2}' >> ae_std_coll
    done
    if [ -f ae_std_coll ]
    then
      echo "we got ae_std_coll"
    else
      echo "no ae_std_coll"
    fi
    python -c "import numpy as np
M=np.loadtxt('ae_std_coll')
N_tot=len(M)
good_idx=np.where(M<=0.18)[0]
N_good=len(good_idx)
N_bad=N_tot-N_good
print('good '+' bad')
print(str(N_good)+'  '+str(N_bad))
ratio=N_good/N_tot
print('good ratio')
print(ratio)
"
  cd $home_dir
done 
