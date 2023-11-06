#!/bin/bash
#SBATCH -p v6_384
#SBATCH -N 1
#SBATCH -n 1
export PATH=/public1/home/sch0149/deepmd/miniconda3/bin:$PATH
export OMP_NUM_THREADS=1 

./ini.sh
