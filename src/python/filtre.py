import numpy as np
from scipy.signal import lfilter

def filtre(X,G,delta_f,fe,fc):
    a1 = -2*np.sqrt(1-(2*np.pi*G*delta_f)/fe)*np.cos(2*np.pi*fc/fe)
    a2 = 1-(2*np.pi*G*delta_f)/fe;
    b0 = (2*np.pi*G*delta_f/fe)*np.sin(2*np.pi*fc/fe);
    b0 = np.array([b0])
    A = np.array([ 1, a1, a2 ]);
    # print('size A = {} \nsize B = {} \nsize X = {}'.format(A.shape,b0.shape,X.shape))
    return lfilter(b0,A,X);
