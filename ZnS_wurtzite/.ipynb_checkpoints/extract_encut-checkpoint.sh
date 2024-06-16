#! /bin/bash

#Extracts data from file with different cutoff energies both stretched and unstretched. Coupled to the main code ecut.sh 


filedir=/home/paolo/project_labqsm/ZnS_zincblende/cutoff_conv

k=8
ecut="40 50 60 70 80 100 120"
#filelist=$filedir/scf_nk8_*.out
#echo "Ecut[Ry],   Etot[Ry],  convergence time" >> energy_ecut.txt
for ec in $ecut
do
 file=$filedir/scf_nk8_ecut${ec}.out 
 filediff=$filedir/scf_nk8_stretch2_ecut${ec}.out
 # selects the penultimum field counted by awk
 etot=`grep '!' $file | awk '{print $(NF-1)}'`
 #extracts the total energy from the stretched input files
 etot_stretch=`grep '!' $filediff | awk '{print $(NF-1)}'`
 conv_time=`grep 'PWSCF  ' $file | awk '{print $(NF-3)}'`
 echo $ec, $etot, $etot_stretch, $conv_time >> $filedir/energy_ecut.txt
done
exit 0
