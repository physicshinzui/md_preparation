#!/bin/bash
set -Ceu

function set_env() {
    BIN_PATH=$1
    DB_PATH=$2
    export TPL_DB_PATH=${DB_PATH} 
    export PATH=${BIN_PATH}:$PATH
}

cat << EOF
Usage
    bash [input (*.pdb)] [file name of force field parameter (*.tpl)]   

EOF

DB=../../myPresto/cosgene_pack180227/src/tplgeneX180118/tplgeneX/DB
PRESTO_BIN=../../myPresto/bin/
echo "setting paths to binary files and force fields params..."
set_env $PRESTO_BIN $DB

inputPDBName=$1
name=$(basename $inputPDBName)
inputSuffix=${name%.*}
echo '-- List of force field files --'
ls $DB
read -p 'Select Force field file from the list: ' ffParamFileName

echo "(1) Adding hydorgen (the topology file generated is not used as the input for simulations)"
tplgeneX -ipdb ${inputPDBName} \
         -db ${ffParamFileName} \
         -ss \
         -opdb out${inputSuffix}.pdb \
         -otpl out${inputSuffix}.tpl  > addH.out
         #-term \

echo "(2) Adding water molecules"
read -p "boundary type? Spherical(S)/Cubic(C)) :" boundaryType
[ $boundaryType == "S" ] && mergin="-10.0" 
[ $boundaryType == "C" ] && mergin="-10.0 -10.0 -10.0"
setwater << EOS > setwater.log 
out${inputSuffix}.pdb 
N                           ; Do you use crystal water file (Y or N)
water.pdb                   
${boundaryType}             ; cell type (sphere="S", ellipsoid="E", cube="C", parallelepiped="P")
${mergin}                   ; Input length (X,Y,Z) (positive:cellsize, negative :mergin)
C                           ; sphere="S", ellipsoid="E", cube="C", parallelepiped="P"
1.0                         ; Input center of water (mass center="C", 3D-coordinate="D")
1.0                         ; density of water [g/cm^3]
3                           ; Input water model(TIP3P="3", TIP4P="4")
N                           ; Do you use precise model (Y or N)
setwat.info                 
N                           ; Do you use membrane (Y or N)
EOS

echo "    *Merging the water molecule pdb into pdb..."
cat out${inputSuffix}.pdb water.pdb > out${inputSuffix}_w_wat.pdb 
rm water.pdb

echo "(3) Adding ions to the previous merged pdb..."
add_ion << EOS > add_ion.log
out${inputSuffix}_w_wat.pdb
out${inputSuffix}_w_wat_ion.pdb
3        ; 1:direct inp, 2:minimum , 3 : density
0.00277  ; ion mol / water mol
Y        ; Do you want to replace all water?(Y/N) 
6.0      ; Exclusion distance
0.2      ; probability of replacing water by ion(value=0.0-1.0: 0.2 is recommended
EOS

echo "(4) Generating the final topology and PDB to be used in simulations..."
tplgeneX -ipdb out${inputSuffix}_w_wat_ion.pdb \
         -db ${ffParamFileName} \
         -opdb system_${inputSuffix}.pdb \
         -otpl system_${inputSuffix}.tpl  > top.out


echo "(5) Generating a shake file based on the topology file..."
mkshkl << EOS > shk.log
1
system_${inputSuffix}.tpl
system_${inputSuffix}.shk
EOS
