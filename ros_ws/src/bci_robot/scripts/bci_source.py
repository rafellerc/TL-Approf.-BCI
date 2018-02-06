#!/usr/bin/env python
# license removed for brevity
import rospy
# from geometry_msgs.msg import Twist
from std_msgs.msg import Float64
import numpy as np

def bci_source():
    #TODO set default file and default mode as argument when initializing
    print("Initializing /bci_source")
    print("""This node feeds a 256 Hz stream of samples from the BCI measurements,
    to a topic called dataBCI. The current version simulates the real-time acquisition
    of the signal by reading a text file containing real measurements. Please, type the
    full path of the file:
    (Ex: '/home/user/TL-Approf.-BCI/obj/herve001.txt')
    """)

    #SECTION USED FOR TESTING------------------
    # file_path = input()
    file_path = '/home/rafael/dev/sir/TL-Approf.-BCI/obj/herve002_labeled.txt'
    Labeled = True
    #UNCOMMENT THE FIRST ONE AND COMMENT THE SECOND AFTERWARDS-------------------------

    X = np.loadtxt(file_path)
    #Checks if the measures are taken in two different locations, if so, it averages them
    if len(X.shape)==2 and not Labeled:
        X = (X[:,0]+X[:,1])/2
    elif Labeled:
        lab = X[:,1]
        X = X[:,0]

    pub = rospy.Publisher('dataBCI', Float64, queue_size=10) #Try other queue_sizes
    rospy.init_node('bci_source', anonymous=True)
    rate = rospy.Rate(256)
    sample = Float64()
    index = 0;
    Xmax = X.shape[0]

    #Variable that indicates that the program is starting (We thought about doing a countdown
    #or trying to do a handshake with the listener node, to guarantee they are synchronized)
    begin = True

    while not rospy.is_shutdown() and index != Xmax-1:
        #reads and publishes sample for sample at 256 Hz
        sample.data = X[index]
        index+=1
        if Labeled:
            print(get_command(lab[index]))
        # print(sample)
        pub.publish(sample)
        rate.sleep()

    print("Finished publishing the data from file")

def get_command(num):
    if num == 0:
        return 'Stop'
    elif num == 1:
        return 'Forward'
    elif num == 2:
        return 'Right'
    elif num == 3:
        return 'Left'
    else:
        return "your code sucks"

if __name__ == '__main__':
    try:
        bci_source()
    except rospy.ROSInterruptException:
        pass
