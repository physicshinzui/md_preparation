#!/bin/bash
#$ -cwd
#$ -l f_node=1
#$ -l h_rt=00:10:00
#$ -N nvt_eq

#export OMP_NUM_THREADS=8
source /etc/profile.d/modules.sh
#module load cuda
module load cuda/8.0.44
module load intel
module load intel-mpi

psygene=/gs/hs0/hp170020/siida/benckmark/psygene-G_v0933_170710/src/psygene-G_intel

mpirun -ppn 4 -n 8 ${psygene} < $INP > $OUT
#mpirun -ppn 4 -n 8 ${psygene} < md.inp > md.out
