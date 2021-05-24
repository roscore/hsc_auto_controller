#!/bin/bash

source /root/catkin_ws/devel/setup.bash
source /opt/ros/noetic/setup.bash

roslaunch alice_manager alice_manager_webots_test_3.launch

rostopic pub /base_module/pose std_msgs/String "data: 'base_pose'"
sleep 10s

rostopic pub /robotis/enable_ctrl_module std_msgs/String "data: 'none'"
sleep 5s

rostopic pub /robotis/enable_ctrl_module std_msgs/String "data: 'walking_module'"
sleep 5s

rostopic pub /heroehs/alice_foot_step_generator/dsp std_msgs/Float64 "data: '0.15'"
rostopic pub /heroehs/alice_foot_step_generator/foot_z_swap std_msgs/Float64 "data: '0.055'"
rostopic pub /heroehs/alice_foot_step_generator/body_z_swap std_msgs/Float64 "data: '0.02'"
rostopic pub /heroehs/alice_foot_step_generator/y_zmp_convergence std_msgs/Float64 "data: '-0.01'"
sleep 5s

rostopic pub /heroehs/alice_foot_step_generator/walking_command_gui alice_footstep_msgs/FootStepCommand "{command: 'forward', step_num: 100, step_time: 17.00, step_length: 0.18, side_step_length: 0.1, step_angle_rad: 0.05}"