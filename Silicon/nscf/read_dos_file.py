import numpy as np
import csv

def read_dos_file(input_file):
    data = []
    with open(input_file,'r') as file :
        csv_reader = csv.reader(file, delimiter=' ', skipinitialspace=True)
        #skip fisrst line
        next(csv_reader)
        #replaced_text = re.sub(find_str, replace_str, csv_reader)
        for row in csv_reader:
            if any(row):
                data.append(row)

    f=np.asarray(data, dtype='f8')
    return f
        
