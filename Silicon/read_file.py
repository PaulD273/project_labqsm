import numpy as np
import csv

def read_file(en_file):
    '''This function takes in a csv file, combs through it, stores its elements in a list which is eventually converted to a numpy array of floats'''
    data = []
    with open(en_file,'r') as file : 
        csv_reader = csv.reader(file, delimiter=',')
        for row in csv_reader:
            data.append(row)
            
        f=np.asarray(data, dtype='f8')
        
    return f