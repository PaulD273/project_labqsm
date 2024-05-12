#! /bin/bash

#Script that extract data from file with different cutoff energies. Coupled to the main code encut.sh 
#Based on ex.3 LABQSM Max

filedir=/home/paolo/LABQSM/diamond/scf_ecut_file

k=8
ecut="20 40 60 80 100 120 140 160 180 200"
#filelist=$filedir/scf_nk8_*.out
echo "Ecut[Ry],   Etot[Ry] ,   # of k points,  convergence time" >> energy_ecut.txt
for ec in $ecut
do
 file=$filedir/scf_nk8_ecut${ec}.out 
 # selects the penultimum field counted by awk
 etot=`grep '!' $file | awk '{print $(NF-1)}'`
 num_k_p=`grep 'number of k points' $file | awk '{print $(NF)}'`
 conv_time=`grep 'PWSCF  ' $file | awk '{print $(NF-3)}'`
 echo $ec, $etot, $num_k_p, $conv_time >> energy_ecut.txt
done
exit 0
