#! /bin/bash

#Script used to extract data from the files relative to the main code kpoints.sh, relative to ex.2

filedir=/home/paolo/project_labqsm/gallium_arsenide/scf_nk_file
nklist="4 6 8 12"
#echo "  Etot[Ry] ,   # of k points,  convergence time" >> $filedir/energy_nk.txt

for k in $nklist
do
  label="nk${k}"
# selects the penultimum field counted by awk
  etot=`grep '!' $filedir/scf_${label}.out | awk '{print $(NF-1)}'`
  num_k_p=`grep 'number of k points' $filedir/scf_${label}.out | awk '{print $(NF)}'`
  #num_k_p=$k
  conv_time=`grep 'PWSCF  ' $filedir/scf_${label}.out | awk '{print $(NF-3)}'`
  echo $etot, $num_k_p, $conv_time >> $filedir/energy_nk.txt
done
exit 0
