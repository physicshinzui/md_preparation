# How to use

Hiya, 
I execute some scripts to get an equilibriated structure to be used for production runs.


## Outline
What the scripts do is as follows:

i.   1_make_system.sh: to make a tolology file and a pdb file via tplgeneX, 
     and other programs, such as setwater and add_ion in myPresto tools

ii.  2_do_em.sh: to perform energy minimisation (dubbed em here) by using the topology and the pdb file.

iii. 3_nvt_eq.sh: to perform a NVT simulation from the minimised structure.
     You need to set temperature before the execution.
     This run equilibriates velocities.

iv.  4_npt_eq.sh: to perform a NPT run from the equilibrated structure.
     You will see convergence of pressure and box size.

