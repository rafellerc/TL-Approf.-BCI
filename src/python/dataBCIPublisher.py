#!/usr/bin/env python
# license removed for brevity
import rospy
from std_msgs.msg import String

def dataBCIPublisherNode():
    pub = rospy.Publisher('dataBCI', float32, queue_size=100)
    rospy.init_node('dataBCIPublisherNode', anonymous=True)
    rate = rospy.Rate(256) # 10hz
    while not rospy.is_shutdown():
        hello_str = "hello world %s" % rospy.get_time()
        rospy.loginfo(hello_str)
        pub.publish(hello_str)
        rate.sleep()

if __name__ == '__main__':
    try:
        talker()
    except rospy.ROSInterruptException:
        pass
