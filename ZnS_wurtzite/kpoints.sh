#!/bin/bash

#This code perform different runs in order to converge absolute energy with respect to k points sampling
#Main code based on ex.2 LABQSM Max

bindir=/home/paolo/q-e-qe-7.2/bin

jobdir=/home/paolo/project_labqsm/ZnS_wurtzite
filedir=$jobdir/scf_nk_file



k_list="4 6 8 12"

for k in $k_list
do
 
  label="nk${k}"
  
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
    celldm(1) = 7.2187532764
    celldm(3) = 1.638743455559611
    nat = 4, 
    ntyp = 2,
    ecutwfc =  60.0
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
 $k $k $k   0 0 0 

EOF
 #running over different possibilities
 echo "Running $label"
 $bindir/pw.x < $filein > $fileout
done
 
