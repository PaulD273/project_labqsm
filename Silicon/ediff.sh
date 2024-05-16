#!/bin/bash

#This script creates and runs the input files of silicon with a stretched lattice parameter for different
#cutoff energies


bindir=/home/paolo/q-e-qe-7.2/bin

jobdir=/home/paolo/project_labqsm/Silicon
filedir=$jobdir/cutoff_conv

#alat0=10.263101844 with a 2% displacement
alat=10.46836388088
#Percentage of stretch applied to the lattice param
stretch=2
k=8

ecut="40 50 60 80 100 120"


for ec in $ecut
do
  ecrho=$(($ec*4))

  label="nk${k}_stretch${stretch}_ecut${ec}"
  
  filein=$filedir/scf_${label}.in
  fileout=$filedir/scf_${label}.out

# generate output file

  cat > $filein <<EOF
  	
  &CONTROL
    prefix='silicon',
    calculation = 'scf'
    restart_mode='from_scratch',
    pseudo_dir = '/home/paolo/project_labqsm/pseudopotentials'
    outdir = './SCRATCH'
 /
 &SYSTEM
    ibrav = 2, 
    celldm(1) =$alat
    nat = 2, 
    ntyp = 1,
    ecutwfc =  $ec
    ecutrho = $ecrho
 /
 &ELECTRONS
    mixing_mode = 'plain'
    mixing_beta = 0.7
    conv_thr =  1.0d-8
 /
 ATOMIC_SPECIES
  Si   28.085   Si.pz-vbc.UPF
 ATOMIC_POSITIONS (alat)
  Si 0.00 0.00 0.00
  Si 0.25 0.25 0.25
 K_POINTS {automatic}
  $k $k $k   0 0 0 

EOF
 #running
 echo "Running $label"
 $bindir/pw.x < $filein > $fileout
done
 

