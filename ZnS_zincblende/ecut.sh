#!/bin/bash

#This script creates and runs the input files of silicon for different cutoff energies

bindir=/home/paolo/q-e-qe-7.2/bin

jobdir=/home/paolo/project_labqsm/ZnS_zincblende

filedir=$jobdir/cutoff_conv

alat=10.242314858
k=8

ecut="40 50 60 70 80 100 120"


for ec in $ecut
do
  ecrho=$(($ec*4))

  label="nk${k}_ecut${ec}"
  
  filein=$filedir/scf_${label}.in
  fileout=$filedir/scf_${label}.out

# generate output file

  cat > $filein <<EOF
  	
  &CONTROL
    prefix='zns',
    calculation = 'scf'
    restart_mode='from_scratch',
    pseudo_dir = '/home/paolo/project_labqsm/pseudopotentials'
    outdir = './SCRATCH'
 /
 &SYSTEM
    ibrav = 2, 
    celldm(1) = 10.242314858
    nat = 2, 
    ntyp = 2,
    ecutwfc =  $ec
    ecutrho = $ecrho
 /
 &ELECTRONS
    mixing_mode = 'plain'
    mixing_beta = 0.7
    conv_thr =  1.0d-8
 /
ATOMIC_SPECIES
 Zn   65.38   Zn.pz-hgh.UPF
 S    32.06   S.pz-hgh.UPF
ATOMIC_POSITIONS (alat)
 Zn 0.00 0.00 0.00
 S  0.25 0.25 0.25
K_POINTS {automatic}
 8 8 8   0 0 0 

EOF
 #running
 echo "Running $label"
 $bindir/pw.x < $filein > $fileout
done
 

