import numpy as np
from filtre import filtre


class Envelope_extractor(object):

    def __init__(self, G=0.56, delta_f=0.46, alpha=0.9, windowSize=36):
        '''Initializes the extractor with the optimal parameters
        '''
        fc = [7.5 11 13.5]
        a1 = -2 * np.sqrt(1 - (2 * np.pi * G * delta_f) / fe) * np.cos(2 * np.pi * fc / fe)
        a2 = 1 - (2 * np.pi * G * delta_f) / fe
        b0 = (2 * np.pi * G * delta_f / fe) * np.sin(2 * np.pi * fc / fe)

    def get_envelope(X):
        """Gets the envelope of the signal by filtering it using the filter coefficients,
        then getting the smoothed power using the alpha and finally filtering on 7Hz (find out the coeficients)
        """
        # TODO Everything
