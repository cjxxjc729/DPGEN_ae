#!/bin/bash
home_dir=$(pwd)
signature=$0

echo "run mc"
./run_mc.sh >> /dev/null

echo "sleep 1m"
sleep 1m
holdon_wait_following_dir_done_V2.sh ./mc/seed1


echo "collect mc results"

./collect_mc_results.sh >> /dev/null


echo ""


