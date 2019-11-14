# How to use

Hiya, 
I execute some scripts to get an equilibriated structure to be used for production runs.

## 1_make_system.sh
To make a tolology file and a pdb file via tplgeneX, 
and other programs, such as setwater and add_ion in myPresto tools

## 2_do_em.sh
To perform energy minimisation (dubbed em here) by using the topology and the pdb file.

## 3_nvt_eq.sh
To perform a NVT simulation from the minimised structure.
You need to set temperature before the execution.
This run equilibriates velocities.

## 4_npt_eq.sh
To perform a NPT run from the equilibrated structure.
You will see convergence of pressure and box size.

##Notes
- 1_make_system.sh would work for any environment. 
- 2_do_em.sh, 3_nvt_eq.sh, and 4_npt_eq.sh just work on TSUBAME3.0.
