import numpy as np

def read_txt_file(en_file):
    '''This function takes in a txt file, combs through it, stores its elements in a list which is eventually converted to a numpy array of floats'''
    data = []
    with open(en_file,'r') as file : 
        for row in file:
            data.append(row)
            
        f=np.asarray(data, dtype='f8')
        
    return f