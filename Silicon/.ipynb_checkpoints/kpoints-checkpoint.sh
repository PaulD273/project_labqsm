#!/bin/bash

#This code perform different runs in order to converge absolute energy with respect to k points sampling
#Main code based on ex.2 LABQSM Max

bindir=/home/paolo/q-e-qe-7.2/bin

jobdir=/home/paolo/LABQSM/diamond
filedir=$jobdir/scf_nk_file


alat=6.7402778
ecutwfc=40

k_list="2 4 6 8 12 16"

for k in $k_list
do
 
  label="nk${k}"
  
  filein=$filedir/scf_${label}.in
  fileout=$filedir/scf_${label}.out

# generate output file

  cat > $filein <<EOF
  	
  &CONTROL
    prefix='diamond',
    calculation = 'scf'
    restart_mode='from_scratch',
    pseudo_dir = '/home/paolo/LABQSM/pseudo/'
    outdir = './SCRATCH'
  /
  &SYSTEM
    ibrav = 2,
    celldm(1) = $alat
    nat = 2,
    ntyp = 1,
    ecutwfc =  $ecutwfc
  /
  &ELECTRONS
    mixing_mode = 'plain'
    mixing_beta = 0.7
    conv_thr =  1.0d-8
  /
  ATOMIC_SPECIES
   C   12.011   C.pz-vbc.UPF
  ATOMIC_POSITIONS (alat)
   C 0.00 0.00 0.00
   C 0.25 0.25 0.25
  K_POINTS {automatic}
   $k $k $k   0 0 0

EOF
 #running over different possibilities
 echo "Running $label"
 $bindir/pw.x < $filein > $fileout
done
 

