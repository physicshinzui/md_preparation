#!/bin/bash
set -Ceu

cat << EOF

This working directory has finally returned the following information that will be passed to the mcmd directory:
--------
EOF

centx=$(grep CENTER ./setwat.info | awk '{print $5}')
centy=$(grep CENTER ./setwat.info | awk '{print $6}')
centz=$(grep CENTER ./setwat.info | awk '{print $7}')
cellx=$(grep X-AXIS npt_eq.out_test | tail -n1 | awk '{print $3}')
celly=$(grep X-AXIS npt_eq.out_test | tail -n1 | awk '{print $6}') 
cellz=$(grep X-AXIS npt_eq.out_test | tail -n1 | awk '{print $9}')

echo 'Topology       : ' $(ls $(pwd)/*tpl)
echo 'NPT snapshot   : ' $(ls $(pwd)/npt_eq.pdb)
echo 'Shake          : ' $(ls $(pwd)/*.shk)
echo 'center         : ' [$centx, $centy, $centz]
echo 'boudnary       : ' [$cellx, $celly, $cellz]
