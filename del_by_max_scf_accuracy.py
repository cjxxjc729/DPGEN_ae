#!/public1/home/sch0149/deepmd-kit/bin/python

import numpy as np
M=np.loadtxt('id_max_value.txt',dtype='str')
M1=M[:,1].astype('float')
idx=np.where(M1 > 0.03)[0]

dirs=M[idx,0]

np.savetxt('dirs_to_del.txt',dirs,fmt='%s')

