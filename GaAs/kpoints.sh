#!/bin/bash

#This code perform different runs in order to converge absolute energy with respect to k points sampling
#Main code based on ex.2 LABQSM Max

bindir=/home/paolo/q-e-qe-7.2/bin

jobdir=/home/paolo/project_labqsm/GaAs
filedir=$jobdir/scf_nk_file


alat=10.682904472

k_list="4 6 8 12"

for k in $k_list
do
 
  label="nk${k}"
  
  filein=$filedir/scf_${label}.in
  fileout=$filedir/scf_${label}.out

# generate output file

  cat > $filein <<EOF
  	
  &CONTROL
    prefix='gallium_arsenide',
    calculation = 'scf'
    restart_mode='from_scratch',
    pseudo_dir = '/home/paolo/project_labqsm/pseudopotentials'
    outdir = './SCRATCH'
 /
 &SYSTEM
    ibrav = 2, 
    celldm(1) = $alat
    nat = 2, 
    ntyp = 2,
    ecutwfc =  33
    ecutrho = 330
 /
 &ELECTRONS
    mixing_mode = 'plain'
    mixing_beta = 0.7
    conv_thr =  1.0d-8
 /
ATOMIC_SPECIES
 Ga   69.723   Ga.pbe-dn-rrkjus_psl.0.2.UPF
 As   74.922   As.pbe-n-rrkjus_psl.0.2.UPF
ATOMIC_POSITIONS (alat)
 Ga 0.00 0.00 0.00
 As 0.25 0.25 0.25
K_POINTS {automatic}
 $k $k $k   0 0 0  

EOF
 #running over different possibilities
 echo "Running $label"
 $bindir/pw.x < $filein > $fileout
done
 

