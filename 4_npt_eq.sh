#!/bin/bash
set -Ceu

cat << EOF
Usage:
    bash $0 [tpl.file] [initial pdb file] [temperature]

#Remainder
    - This script uses psygene-G.
    - this aims to equilibrate a system in short time md.
    - can be used in TSUBAME via qsub command.
    - shake can not be applied whilst controling puressure in psygene.
    so, you do not have to specify a shake file.

#Note
    If you use TSUBAME3.0, you may encounter a problem about shared library for cuda.
    You then must specify an appropriate cuda version via 'module load cuda/[version]'.
EOF

cellx=$(grep CELL   ./setwat.info | awk '{print $5}')
celly=$(grep CELL   ./setwat.info | awk '{print $6}')
cellz=$(grep CELL   ./setwat.info | awk '{print $7}')
centx=$(grep CENTER ./setwat.info | awk '{print $5}')
centy=$(grep CENTER ./setwat.info | awk '{print $6}')
centz=$(grep CENTER ./setwat.info | awk '{print $7}')

cat templates/npt_eq.inp | sed \
    -e "s!#{TOPOLOGY}!$1!g"   \
    -e "s!#{PDB}!$2!g"        \
    -e "s!#{SHK}!$3!g"        \
    -e "s!#{TEMP}!$4!g"        \
    -e "s!#{RAND}!${RANDOM}!g"        \
    -e "s!#{CENTX}!${centx}!g"   \
    -e "s!#{CENTY}!${centy}!g"   \
    -e "s!#{CENTZ}!${centz}!g"   \
    -e "s!#{CELLX}!${cellx}!g"   \
    -e "s!#{CELLY}!${celly}!g"   \
    -e "s!#{CELLZ}!${cellz}!g" > npt_eq.inp

read -p "is TSUBAME?[t/f]: " isTsubame
if [ $isTsubame == 't' ]; then 
    qsub -v INP="npt_eq.inp" -v OUT="npt_eq.out" ./templates/submit_toTSUBAME.sh
elif [ $isTsubame == 'f' ]; then
    $psygene < npt_eq.inp > npt_eq.out
else
    echo "Stop: You must specify t or f."
    exit
fi
