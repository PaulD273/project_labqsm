Each folder contains all computations performed for a given material. Pseudopotentials contains the pp files.

Every folder contains:
a .ipynb file giving an overall description of the computational procedure performed and describing the system
a list of bash scripts to extract the data from the output files
a scf calc to test the system
a list of sub folders:
    cutoff_conv: contains all files regarding the convergence process wrt the energy cutoff
    nscf: contains a scf calc with converged parameters and all files regarding the bands and dos calc and post processing, including the estimation of the energy gap in the bands.ipynb             file
    relax: contains the vc-relax computations
    scf_nk_file: contains all files regarding the convergence process wrt the k-point grid
    
