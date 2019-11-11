#!/bin/bash

echo "do you really want to delete the following files?:"
echo "-----------------------------------------------------"
ls *log out${inputSuffix}* system* setwat.info Original_aminoacid_No.dat top.out addH.out  em.inp  fort.30
echo "-----------------------------------------------------"
read -p "If so, Enter" 
rm *log out${inputSuffix}* system* setwat.info Original_aminoacid_No.dat top.out addH.out  em.inp  fort.30

