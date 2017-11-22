import numpy as np
import matplotlib.pyplot as plt
import os
import sys

PATH_TO_ROOT = os.path.dirname(os.path.dirname(os.path.dirname(os.path.realpath(__file__))))
sys.path.append(PATH_TO_ROOT)

src_folder = os.path.join(PATH_TO_ROOT,'src','python')
sys.path.insert(0, src_folder)

from filtre import filtre

herve_001_file = os.path.join(PATH_TO_ROOT,'obj',"herve001_labeled.txt")

X = np.loadtxt(herve_001_file)

# Definition of the parameters
fe = 256.   #Sampling frequency
fc_1 = 7.5 #Frequency of each source
fc_2 = 11.
fc_3 = 13.5
delta_f = 0.33 #Parameter of the filter bank. Optimal value = 0.33
G = 0.56  #Parameter of the filter bank. Optimal value = 0.56
len_X = X.shape[0]
T = np.linspace(0,(1/fe)*len_X,num=len_X,endpoint=False)

# Gets the indices of each command
idx_0 = np.array([i for i in range(len_X) if X[i,1]==0])
idx_1 = np.array([i for i in range(len_X) if X[i,1]==1])
idx_2 = np.array([i for i in range(len_X) if X[i,1]==2])
idx_3 = np.array([i for i in range(len_X) if X[i,1]==3])

Y1 = filtre(X[:,0],G,delta_f,fe,fc_1);
Y2 = filtre(X[:,0],G,delta_f,fe,fc_2);
Y3 = filtre(X[:,0],G,delta_f,fe,fc_3);

# windowSize = 36;
# b = (1/windowSize)*ones(1,windowSize);
# a = 1;

plt.plot(T[idx_0],Y1[idx_0],'r',T[idx_1],Y1[idx_1],'b',T[idx_2],Y1[idx_2],'y',T[idx_3],Y1[idx_3],'k');

plt.grid(True)
plt.show()
