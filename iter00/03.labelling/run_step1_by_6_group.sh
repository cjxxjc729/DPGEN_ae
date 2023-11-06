#!/bin/bash
#
cp ../02.site_mark/04.cif_make/*cif ./
cp ../02.site_mark/04.cif_make/*_ae_std.txt ./

ngroup=6


ls -1 | grep ".cif$" > cif_list_tot.txt
seperate_list_to_serveral_sublists.sh << EOF
cif_list_tot.txt
${ngroup}
EOF

width=2

for gid in `seq 1 ${ngroup}`
do

  idx=$(echo $gid | awk -v w="$width" '{printf("%0" w "d\n", $0)}' )

  cat *.sub_group_${idx} | xargs > in_${dix}.t
  hpc_sub "./step1.ae_maker_forHEA.sh < in_${dix}.t"

  sleep 3s
done



