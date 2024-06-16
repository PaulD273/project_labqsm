#!/bin/bash

#This script creates and runs the input files of silicon with a stretched lattice parameter for different
#cutoff energies


bindir=/home/paolo/q-e-qe-7.2/bin

jobdir=/home/paolo/project_labqsm/ZnS_wurtzite
filedir=$jobdir/cutoff_conv

#alat0=7.2187532764 with a 2% displacement
alat=7.363128341928
#Percentage of stretch applied to the lattice param
stretch=2


ecut="40 50 60 70"


for ec in $ecut
do
  ecrho=$(($ec*4))

  label="nk${k}_stretch${stretch}_ecut${ec}"
  
  filein=$filedir/scf_${label}.in
  fileout=$filedir/scf_${label}.out

# generate output file

  cat > $filein <<EOF
  	
&CONTROL
    prefix='zns_w',
    calculation = 'scf'
    restart_mode='from_scratch',
    pseudo_dir = '/home/paolo/project_labqsm/pseudopotentials'
    outdir = './SCRATCH'
 /
 &SYSTEM
    ibrav = 4, 
    celldm(1) = $alat
    celldm(3) = 1.638743455559611
    nat = 4, 
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
 Zn   65.38   Zn_ONCV_PBE-1.2.upf
 S    32.06   S_ONCV_PBE-1.2.upf
ATOMIC_POSITIONS (alat)
 Zn  0.000000000  0.000000000  0.000000000
 S   0.000000000  0.000000000  0.372372893
 Zn  0.000000000  0.577350269  0.500000000
 S   0.000000000  0.577350269  0.872372893
K_POINTS {automatic}
 6 6 6   0 0 0 

EOF
 #running
 echo "Running $label"
 $bindir/pw.x < $filein > $fileout
done
 

