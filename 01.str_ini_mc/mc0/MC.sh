#!/bin/bash
#SBATCH -p v6_384
#SBATCH -N 1
#SBATCH -n 16
source /public1/soft/modules/module.sh
module load  mpi/intel/20.0.4
export PATH=/public1/home/sch0149/tools/vasp.5.4.4/bin:$PATH
export OMP_NUM_THREADS=1



RT=0.025875
Nstep=120
n_switched_atoms=$(cat switch_id_list | wc -l)

for i in `seq 1 $Nstep`
do
  echo "---------------------now begin step=${i}----------------------"
  mkdir $i
  mpirun -n 16 vasp_gam
  cp POSCAR OUTCAR OSZICAR $i
  if [ $i -eq 1 ]
  then
    Eattempt=$(grep "F=" OSZICAR | awk -F ' ' '{print $3}')
    Energy=$Eattempt
    Elast=$Eattempt
    echo $Energy > energy.t
    echo "intial energy is $Energy"
  else
    Eattempt=$(grep "F=" OSZICAR | awk -F ' ' '{print $3}')
    echo "the attempt energy is ${Eattempt}. Compare that with $Elast "    
    echo "import math
import random
RT=${RT}
Elast=${Elast}
Eattempt=${Eattempt}
fmetropolise=math.exp((Elast-Eattempt)/RT)
print(\"fmetropolise  is\"+ str(fmetropolise))
if fmetropolise >= 1:
  accpro=1
else:
  accpro=fmetropolise
print(\"accpro is \"+str(accpro) )
#f=open(\"accpro.t\",\"w\")
#f.write(str(accpro))
#f.close
f=open(\"whether_accpet.t\",\"w\")
random.seed()
rn=random.random()
print(\"rn = \"+str(rn))
if rn > accpro:
  f.write(\"reject\")
else:
  f.write(\"accept\")
f.close
" > python.t
    python python.t
    if grep -q reject whether_accpet.t
    then
      echo "reject and backroll the change"
      cp POSCAR.bk POSCAR
    else
      echo "accept the change"
      Energy=$Eattempt
      Elast=$Eattempt
    fi
  fi
  echo "step $i. Energy $Energy"
  echo "-----now make attmpt move in POSCAR-----"
  echo "before that, make a copy"
  cp POSCAR POSCAR.bk
  echo "pick two elements"
  
  line_1_of_sel_list=$(echo $(($RANDOM%${n_switched_atoms})))
  line_2_of_sel_list=$(echo $(($RANDOM%${n_switched_atoms})))
  line_1_of_sel_list=$(echo "$line_1_of_sel_list+1" | bc -l)
  line_2_of_sel_list=$(echo "$line_2_of_sel_list+1" | bc -l)
  echo "$line_1_of_sel_list $line_2_of_sel_list"
  line_1=$(cat switch_id_list | head -$line_1_of_sel_list | tail -1)
  line_2=$(cat switch_id_list | head -$line_2_of_sel_list | tail -1)
  ele_id_1=$(cat all_ordered_eleid_list | head -$line_1 | tail -1 )
  ele_id_2=$(cat all_ordered_eleid_list | head -$line_2 | tail -1 )  
  echo "$line_1 $line_2 $ele_id_1 $ele_id_2"
 

  while [ $ele_id_1 -eq $ele_id_2 ]
  do
  line_1_of_sel_list=$(echo $(($RANDOM%${n_switched_atoms})))
  line_2_of_sel_list=$(echo $(($RANDOM%${n_switched_atoms})))
  line_1_of_sel_list=$(echo "$line_1_of_sel_list+1" | bc -l)
  line_2_of_sel_list=$(echo "$line_2_of_sel_list+1" | bc -l)
  line_1=$(cat switch_id_list | head -$line_1_of_sel_list | tail -1)
  line_2=$(cat switch_id_list | head -$line_2_of_sel_list | tail -1)
  ele_id_1=$(cat all_ordered_eleid_list | head -$line_1 | tail -1 )
  ele_id_2=$(cat all_ordered_eleid_list | head -$line_2 | tail -1 )
  done
  echo "they are number $ele_id_1 and $ele_id_2"

  line_direct=$(grep -n Direct POSCAR | awk -F ':' '{print $1}')
  cor_line1=$(echo "$line_direct+$line_1" | bc -l)  
  cor_line2=$(echo "$line_direct+$line_2" | bc -l)
  content1=$(sed -n "${cor_line1},${cor_line1}p" POSCAR)
  content2=$(sed -n "${cor_line2},${cor_line2}p" POSCAR)
  sed -i "${cor_line1}s/${content1}/${content2}/" POSCAR
  sed -i "${cor_line2}s/${content2}/${content1}/" POSCAR
  echo "coordinate switched between atom ids $line_1 and $line_2"
done
