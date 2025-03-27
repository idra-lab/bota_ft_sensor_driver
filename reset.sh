source install/setup.bash
ros2 service call /bus0/ft_sensor0/reset_wrench rokubimini_msgs/srv/ResetWrench "desired_wrench:
  force:
    x: 0.0
    y: 0.0
    z: 0.0
  torque:
    x: 0.0
    y: 0.0
    z: 0.0"