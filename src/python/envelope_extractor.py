import numpy as np
#from filtre import filtre


class Envelope_extractor(object):


    def __init__(self, G=0.56, delta_f=0.46, alpha=0.9, bufferSize=36, fe = 256):
        '''Initializes the extractor with the optimal parameters
        '''
        self.fcent = [7.5, 11, 13.5]  #The central frequencies of the flashing lights
        self.a1 = [-2 * np.sqrt(1 - (2 * np.pi * G * delta_f) / fe) * np.cos(2 * np.pi * fc / fe) for fc in self.fcent]
        self.a2 = 1 - (2 * np.pi * G * delta_f) / fe  #Equal for the 3 frequencies
        self.b0 = [(2 * np.pi * G * delta_f / fe) * np.sin(2 * np.pi * fc / fe) for fc in self.fcent]
        self.N = bufferSize #Stores the bufferSize in a variable N
        self.buffer_y = np.zeros([3,bufferSize])    #Array that stores all the values
                                        #of y for a patch of time of size bufferSize
        self.buffer_z = np.zeros([3,bufferSize])

    def filter(self, x, n):
        """This function filters one sample at a time, given that the sample was taken at position n
        where n is the relative position in the buffer of size bufferSize. The function also registers
        the state of the y buffer accordingly (in the nth position), so this function should always be used
        in forward order
        """
        #TODO Think if its a good idea to change directly the buffer
        self.buffer_y[:,n] = ([self.b0[i]*x - self.a1[i]*self.buffer_y[i,(n-1)%self.N] - self.a2*self.buffer_y[i,(n-1)%self.N] for i in [0,1,2]])
        return self.buffer_y[:,n]

    def smooth(self):
        pass


    def get_envelope(self,X):
        """Gets the envelope of the signal by filtering it using the filter coefficients,
        then getting the smoothed power using the alpha and finally filtering on 7Hz (find out the coeficients)
        """
        # TODO Everything
        pass
