#!/bin/bash
#
cp 02.site_mark/04.cif_make/*cif ./03.labelling
cp 02.site_mark/04.cif_make/*_ae_std.txt ./03.labelling

ngroup=6

cd 03.labelling

ls -1 | grep ".cif$" > cif_list_tot.txt
seperate_list_to_serveral_sublists.sh << EOF
cif_list_tot.txt
${ngroup}
EOF

width=2

for gid in `seq 1 ${ngroup}`
do

  idx=$(echo $gid | awk -v w="$width" '{printf("%0" w "d\n", $0)}' )

  cat *.sub_group_${idx} | xargs > in.t
  nohup ./step1.ae_maker_forHEA.sh < in.t &

  sleep 3s
done



