# build the input for QE using ASE

from ase import Atom, Atoms
from ase.cell import Cell
from ase.io import espresso
from ase.build import bulk

#cell=[1,1,1]
cell= bulk('Si', crystalstructure='diamond', a=10.263101844).cell
positions = []
positions.append(Atom('Si',[0.0000,0.0000,0.0000])) # Angstroms


atoms = Atoms(positions, cell=cell)

pseudopotentials = {}
pseudopotentials['Si'] = 'Si.pz-vbc.UPF'


inp_data = {}

#control
inp_data['calculation'] = 'scf'
inp_data['restart_mode'] = 'from_scratch'
inp_data['prefix'] = 'silicon'
inp_data['outdir'] = './'
inp_data['pseudo_dir'] = '/home/paolo/project_labqsm/pseudopotentials'
inp_data['verbosity'] = 'high'
inp_data['wf_collect'] = True
inp_data['outdir'] = './SCRATCH'
inp_data['ecutwfc'] =  40.0

#system
#inp_data['ibrav'] = 2


#electrons
inp_data['mixing_mode'] = 'plain'
inp_data['mixing_beta'] = 0.7
inp_data['conv_thr'] =  1.0e-8

kpts = (4, 4, 4)



with open('pw.in','w') as fd : 
   espresso.write_espresso_in(fd,atoms,pseudopotentials=pseudopotentials,input_data=inp_data, kpts=kpts)