#!/bin/bash
home_dir=$(pwd)

mkdir 04.cif_make

thr_conv_lb=0.1
thr_conv_hb=0.3
#cd 03.str_validation/output01.lmp
#get_all_e_model_devi.sh > get_all_model_devi.sh.out
#get_all_model_devi.sh > get_all_model_devi.sh.out
nfile=$(cat 03.str_validation/max_std_e.txt | wc -l)

for i in `seq 1 $nfile`
do
max_dev=$(cat 03.str_validation/max_std_e.txt  | head -$i | tail -1 | awk -F ' ' '{print $2}' | awk '{printf("%f",$0)}')
echo $max_dev
test_value_lb=$(echo "1*${thr_conv_lb}-1*${max_dev}" | bc -l)
test_value_hb=$(echo "1*${max_dev}-1*${thr_conv_hb}" | bc -l)

echo $test_value_lb > test_value_lb.t
echo $test_value_hb > test_value_hb.t
if grep -q "-" test_value_lb.t
then
if grep -q "-" test_value_hb.t
then
data_file=$(cat 03.str_validation/max_std_e.txt| head -$i | tail -1 | awk -F ' ' '{print $1}')
ae_std_file=$(echo $data_file | sed "s/\.data/_ae_std.txt/g")
cp 03.str_validation/${data_file} 04.cif_make
cp 03.str_validation/${ae_std_file} 04.cif_make
fi
fi

done

rm -rf test_value_hb.t  test_value_lb.t
cd $home_dir
cd 04.cif_make

get_elelist_from_inpujason.py ../../01.learning_sets_in/000/input.json > all_data_to_cif.sh.in.t 
#echo "Cu Fe Ni Ru W" > all_data_to_cif.sh.in.t
all_data_to_cif.sh < all_data_to_cif.sh.in.t
#all_ciftopwin_for_asecif

#./add_Pt_base.sh

#rm -rf *cif *data
