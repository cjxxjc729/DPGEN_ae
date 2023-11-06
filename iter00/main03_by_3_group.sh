#!/bin/bash
#
cp 02.site_mark/04.cif_make/*cif ./03.labelling
cp 02.site_mark/04.cif_make/*_ae_std.txt ./03.labelling

ngroup=3

cd 03.labelling

ls -1 | grep ".cif$" > cif_list_tot.txt
seperate_list_to_serveral_sublists.sh << EOF
cif_list_tot.txt
${ngroup}
EOF

for gid in `seq 1 ${ngroup}`
do

  cat *.sub_group_${gid} | xargs > in.t
  nohup ./step1.ae_maker_forHEA.sh < in.t &

  sleep 3s
done



