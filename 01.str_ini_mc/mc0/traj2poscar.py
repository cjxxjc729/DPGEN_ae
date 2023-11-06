#!/project/chenyongtin/tools/deepmd-kit-1.2.0/bin/python
import numpy as np

#box=np.genfromtxt(open("box.t","rb"),delimiter=" ")
cor=np.genfromtxt(open("cor.t","rb"),delimiter=" ")

cor=np.array(cor)
#cor_ceter=[np.mean(cor[:,2]),np.mean(cor[:,3]),np.mean(cor[:,4])]
#box=[[np.mean(cor[:,2])-9,np.mean(cor[:,2])+9],[np.mean(cor[:,3])-9,np.mean(cor[:,3])+9],[np.mean(cor[:,4])-9,np.mean(cor[:,4])+9]]
box=np.genfromtxt(open("box.t","rb"),delimiter=" ")
box=np.array(box)
#print(box)
index=np.lexsort((cor[:,1],))
cor=cor[index]
xregion=np.where(np.logical_and(cor[:,2] >= box[0,0], cor[:,2] <= box[0,1]))
cor=cor[xregion]
yregion=np.where(np.logical_and(cor[:,3] >= box[1,0], cor[:,3] <= box[1,1]))
cor=cor[yregion]
zregion=np.where(np.logical_and(cor[:,4] >= box[2,0], cor[:,4] <= box[2,1]))
cor=cor[zregion]


for line in range(cor.shape[0]):
  cor[line,2]=(cor[line,2]-box[0,0])/(box[0,1]-box[0,0])
  cor[line,3]=(cor[line,3]-box[1,0])/(box[1,1]-box[1,0])
  cor[line,4]=(cor[line,4]-box[2,0])/(box[2,1]-box[2,0])

res=np.where(np.logical_and(cor[:,1] >= 0.99, cor[:,1] <= 1.01))
res=np.mat(res)
n1=res.shape[1]
res=np.where(np.logical_and(cor[:,1] >= 1.99, cor[:,1] <= 2.01))
res=np.mat(res)
n2=res.shape[1]

res=np.where(np.logical_and(cor[:,1] >= 2.99, cor[:,1] <= 3.01))
res=np.mat(res)
n3=res.shape[1]

res=np.where(np.logical_and(cor[:,1] >= 3.99, cor[:,1] <= 4.01))
res=np.mat(res)
n4=res.shape[1]
res=np.where(np.logical_and(cor[:,1] >= 4.99, cor[:,1] <= 5.01))
res=np.mat(res)
n5=res.shape[1]
res=np.where(np.logical_and(cor[:,1] >= 5.99, cor[:,1] <= 6.01))
res=np.mat(res)
n6=res.shape[1]
res=np.where(np.logical_and(cor[:,1] >= 6.99, cor[:,1] <= 7.01))
res=np.mat(res)
n7=res.shape[1]
res=np.where(np.logical_and(cor[:,1] >= 7.99, cor[:,1] <= 8.01))
res=np.mat(res)
n8=res.shape[1]

lattice=[box[0,1]-box[0,0],0,0],[0,box[1,1]-box[1,0],0],[0,0,box[2,1]-box[2,0]]

Natm=[[n1,n2,n3,n4,n5,n6,n7,n8]]
filename = 'POSCAR.t'
with open(filename, 'w') as file_object:
    file_object.write("poscar by py and sh\n")
    file_object.write("1\n")
    np.savetxt(file_object,lattice,fmt='%7.2f',delimiter=' ')
    file_object.write("Au Co Cu Fe Ni Pd Pt Sn\n")
    np.savetxt(file_object,Natm,fmt='%d',delimiter=' ')
    file_object.write("Direct\n")
    np.savetxt(file_object,cor[:,2:5],fmt='%7.8f',delimiter=' ')
