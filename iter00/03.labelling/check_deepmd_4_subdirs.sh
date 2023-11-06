#!/bin/bash
home_dir=$(pwd)
home_dir=$(pwd)

find ./ -name deepmd > deepmd_loc.list.t


nfile=$(cat deepmd_loc.list.t | wc -l)

n_bad=0

rm -rf bad_deepmd.t
for i in `seq 1 $nfile`
do
  floder=$(cat deepmd_loc.list.t | head -$i | tail -1)
  if [ ! -d ${floder} ] || [ ! -d ${floder}/set.000 ]
  then
    echo "cant't find ${floder} "
    n_bad=$(echo "$n_bad+1" | bc -l )
    echo $floder >>  bad_deepmd.t
  fi

  if grep -q "\-1" ${floder}/type.raw
  then
    echo "type.raw error"
    n_bad=$(echo "$n_bad+1" | bc -l )
    echo $floder >>  bad_deepmd.t
  fi
  echo "$i in total $nfile"

done

if [ $n_bad -eq 0 ]
then
  echo "all good"
else
  echo "not all good. find $n_bad bad sys: "
  cat bad_deepmd.t
  read -p "delete them all? " y_or_n
  if [ $y_or_n == yes ]
  then
    fids=$(cat bad_deepmd.t | xargs)
    echo "rm -rf $fids"
    rm -rf $fids
  fi
fi

rm -rf deepmd_loc.list.t
