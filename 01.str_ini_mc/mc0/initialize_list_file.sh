#!/bin/bash

echo "we will begin the MC simulation. the POSCAR.0 should be prepared.
"

if [ -f all_ordered_eleid_list ]
then
  rm -rf all_ordered_eleid_list
fi

echo "make all_ordered_eleid_list based on POSCAR
"

line_direct=$(grep -n Direct POSCAR.0 | awk -F ':' '{print $1}')
#echo $line_direct
((line_direct=$line_direct-1))
natm_list=$(sed -n "${line_direct},${line_direct}p" POSCAR.0)


id=1
for n in $natm_list
do
  count=0
  while [ ${count} -lt ${n} ]
  do
    echo "$id" >> all_ordered_eleid_list
    ((count=$count+1))
  done
  ((id=$id+1))
done


echo "done"
read -p "enter the id list yout want to switch: (example: 40 41 43-48 49 60-61)) "  id_lists

echo "$id_lists" | sed "s/ /\n/g" > No_order_input.t
if grep -q "-" No_order_input.t
then
  nline_range_no=$(grep "-" No_order_input.t | wc -l)
  for i in `seq 1 $nline_range_no`
  do
    range_0=$(grep "-" No_order_input.t | head -$i | tail -1 | awk -F "-" '{print $1}')
    range_1=$(grep "-" No_order_input.t | head -$i | tail -1 | awk -F "-" '{print $2}')
    for j in `seq $range_0 $range_1`
    do
    echo "$j" >> No_order_input.t
    done
  done
fi
sed -i '/-/d' No_order_input.t
cat No_order_input.t | sort -n > switch_id_list

rm -rf No_order_input.t
