#!/bin/bash
home_dir=$(pwd)
iter_content=$(ls -l | grep " iter" | awk -F ' ' '{print $9}' | xargs)

touch  U_max_std_e_by_iters.txt
for iter in $iter_content
do
echo "--------for $iter-------------"
cd $iter/02.site_mark/03.str_validation/
if [ -f max_std_e.txt ]
then
  sed -i "/final/d" max_std_e.txt
  data_files=$(cat max_std_e.txt | awk -F ' ' '{print $1}' | xargs)
  cat max_std_e.txt | awk -F ' ' '{print $2}'  > max_std_e.t
  rm -rf U_to_label.t
  for data_file in $data_files
  do
    echo "$data_file" | awk -F '_' '{print $2}' >> U_to_label.t
  done
  cat max_std_e.t > U_max_std_e.txt
  #sed -i "1i/\${iter}_U  ${iter}_max_std_e" U_max_std_e.txt
  python -c 'import numpy as np
M=np.loadtxt("U_max_std_e.txt")
N_Uh_stdh=0
N_Uh_stdm=0
N_Uh_stdl=0
N_Um_stdh=0
N_Um_stdm=0
N_Um_stdl=0
N_Ul_stdh=0
N_Ul_stdm=0
N_Ul_stdl=0

U1=-400
U2=0
U3=400
U4=400

std1=0.18
std2=0.4

for index in range(len(M)):
  std=M[index]
  if std <= std1:
    N_Uh_stdh=N_Uh_stdh+1
  elif std1 < std <= std2:
    N_Uh_stdm=N_Uh_stdm+1
  elif std > std2:
    N_Uh_stdl=N_Uh_stdl+1
print("Ugeion N_stdh[0,"+str(std1)+"] N_std["+str(std1)+","+str(std2)+"] N_stdl["+str(std2)+",10]")
print("for 0.4<U<0.77: "+str(N_Uh_stdh)+"   "+str(N_Uh_stdm)+"    "+str(N_Uh_stdl))

'
else
echo "no max_std_e.txt"
fi
cd $home_dir
done

#sed -i "1s/^/^#/" U_max_std_e_by_iters.txt
