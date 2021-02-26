sudo apt-get update
sudo apt-get install -y python-wstool python-rosdep ninja-build stow

mkdir catkin_ws_isolated
cd catkin_ws_isolated
wstool init src
wstool merge -t src https://raw.githubusercontent.com/cartographer-project/cartographer_ros/master/cartographer_ros.rosinstall
wstool update -t src

sudo rosdep init
rosdep update
rosdep install --from-paths src --ignore-src --rosdistro=melodic -y

src/cartographer/scripts/install_abseil.sh

sudo apt-get remove ros-melodic-abseil-cpp

catkin_make_isolated --install --use-ninja
