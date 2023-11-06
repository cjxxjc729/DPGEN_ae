#!/bin/bash
home_dir=$(pwd)
#script_dir=
#tmp_dir=
#mkdir 

#read -p "enter the prefix: " prefix
#read -p "enter the ref pwin file: " f_ref

#--------------------------------------------------------

fs_lpj=$(ls -lt traj/*lammpstrj |  head -10 | awk -F ' ' '{print $NF}' | xargs)

rm -rf fractions.txt

for f_lpj in $fs_lpj
do
  n1=$(grep " 1 " $f_lpj   | wc -l )
  n2=$(grep " 2 " $f_lpj   | wc -l )
  n3=$(grep " 3 " $f_lpj   | wc -l )
  n4=$(grep " 4 " $f_lpj   | wc -l )
  n5=$(grep " 5 " $f_lpj   | wc -l )

  p1=$(echo "$n1 / 36 " | bc -l | awk {printf'("%.2f\n",$0)'})
  p2=$(echo "$n2 / 36 " | bc -l | awk {printf'("%.2f\n",$0)'})
  p3=$(echo "$n3 / 36 " | bc -l | awk {printf'("%.2f\n",$0)'})
  p4=$(echo "$n4 / 36 " | bc -l | awk {printf'("%.2f\n",$0)'})
  p5=$(echo "$n5 / 36 " | bc -l | awk {printf'("%.2f\n",$0)'})  

  echo "$p1 $p2 $p3 $p4 $p5" >> fractions.txt

done

python -c "import numpy as np

u0Cu=np.loadtxt('./u0s/u0Cu.txt')
u0Fe=np.loadtxt('./u0s/u0Fe.txt')
u0Ni=np.loadtxt('./u0s/u0Ni.txt')
u0Ru=np.loadtxt('./u0s/u0Ru.txt')
u0W=np.loadtxt('./u0s/u0W.txt')
u0s=np.array([u0Cu,u0Fe,u0Ni,u0Ru,u0W])

M=np.loadtxt('fractions.txt')
current_fract=np.mean(M,axis=0)
preset_fract=np.array([0.19,0.13,0.46,0.15,0.06])
diff=current_fract-preset_fract
du  = -diff/4     #0.4 fract equal 0.1
u0s=u0s+du
print('new u0s = ', u0s)
np.savetxt('./u0s/u0Cu.txt',[u0s[0]],fmt='%.3f')
np.savetxt('./u0s/u0Fe.txt',[u0s[1]],fmt='%.3f')
np.savetxt('./u0s/u0Ni.txt',[u0s[2]],fmt='%.3f')
np.savetxt('./u0s/u0Ru.txt',[u0s[3]],fmt='%.3f')
np.savetxt('./u0s/u0W.txt',[u0s[4]],fmt='%.3f')

"

