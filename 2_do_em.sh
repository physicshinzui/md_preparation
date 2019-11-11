#!/bin/bash
set -Ceu

cat << EOF
Usage
    bash $0 [TOP file] [PDB file]

Note 1:
    You must specify a path to a directory including cosgene binary file
    before executing.

Note 2:
    CAP boundary has not been applicable yet.
    Only PBC can be performed.

EOF

TOP=$1
PDB=$2
BIN=../../myPresto/bin

cellx=$(grep CELL   ../prepTopAndInitialPDB/setwat.info | awk '{print $5}') 
celly=$(grep CELL   ../prepTopAndInitialPDB/setwat.info | awk '{print $6}') 
cellz=$(grep CELL   ../prepTopAndInitialPDB/setwat.info | awk '{print $7}') 
centx=$(grep CENTER ../prepTopAndInitialPDB/setwat.info | awk '{print $5}')
centy=$(grep CENTER ../prepTopAndInitialPDB/setwat.info | awk '{print $6}')
centz=$(grep CENTER ../prepTopAndInitialPDB/setwat.info | awk '{print $7}')

cat templates/em_pmf.inp | sed \
    -e "s!#{TOPOLOGY}!$1!g"   \
    -e "s!#{PDB}!$2!g"        \
    -e "s!#{CENTX}!${cellx}!g"   \
    -e "s!#{CENTY}!${celly}!g"   \
    -e "s!#{CENTZ}!${cellz}!g"   \
    -e "s!#{CELLX}!${centx}!g"   \
    -e "s!#{CELLY}!${centy}!g"   \
    -e "s!#{CELLZ}!${centz}!g" > em.inp


export PATH=$BIN:$PATH
cosgene < em.inp #> em.out
