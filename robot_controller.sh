#!/bin/bash

source /opt/ros/noetic/setup.bash
source ~/catkin_ws/devel/setup.bash

roscore &
echo "activate roscore"
sleep 60s

roslaunch alice_manager alice_manager_test.launch &
echo "activate auto process"
sleep 10s

rostopic pub /base_module/pose std_msgs/String "data: 'base_pose'" &
echo "send base"
sleep 10s

rostopic pub /robotis/enable_ctrl_module std_msgs/String "data: 'none'" &
echo "none"
sleep 10s

rostopic pub /robotis/enable_ctrl_module std_msgs/String "data: 'walking_module'" &
echo "walk"
sleep 10s

rostopic pub /heroehs/alice_foot_step_generator/dsp std_msgs/Float64 "data: 0.15" &
rostopic pub /heroehs/alice_foot_step_generator/foot_z_swap std_msgs/Float64 "data: 0.055" &
rostopic pub /heroehs/alice_foot_step_generator/body_z_swap std_msgs/Float64 "data: 0.02" &
rostopic pub /heroehs/alice_foot_step_generator/y_zmp_convergence std_msgs/Float64 "data: -0.01" &
echo "send walk param"
sleep 10s

rostopic pub /heroehs/alice_foot_step_generator/walking_command_gui alice_footstep_msgs/FootStepCommand "{command: 'forward', step_num: 100, step_time: 17.00, step_length: 0.18, side_step_length: 0.1, step_angle_rad: 0.05}" &
echo "send walk cmd"
