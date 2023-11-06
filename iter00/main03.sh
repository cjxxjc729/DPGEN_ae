#!/bin/bash
#
cp 02.site_mark/04.cif_make/*cif ./03.labelling
cp 02.site_mark/04.cif_make/*_ae_std.txt ./03.labelling

cd 03.labelling

ls -1 | grep cif |xargs > in.t
nohup ./step1.ae_maker_forHEA.sh < in.t &

while [ ! -f all_jobs_are_done ]
do
echo "--step1.ae_maker_forHEA.sh no done yet, wait"
sleep 1m


done

