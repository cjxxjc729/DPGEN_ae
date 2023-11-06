#!/public1/home/sch0149/deepmd-kit/bin/python

import numpy as np
M=np.loadtxt('U_max_std_e_by_iters.txt')

M_ritao=[]
for i in range(len(M)):
  if sum(M[i])!=0:
    ratio=M[i]/sum(M[i])
    M_ritao=np.append(M_ritao,ratio)
M_ritao=M_ritao.reshape(-1,3)
np.savetxt("error_ratio_by_iters.txt",M_ritao,fmt='%.3f')

