# Use an official ROS image with Ubuntu as the base
FROM osrf/ros:melodic-desktop-full

# Set environment variables
ENV DEBIAN_FRONTEND=noninteractive
ENV A_ROS_DIR=catkin_ws

# Install necessary packages and dependencies
RUN apt-get update && apt-get install -y \
    git \
    build-essential \
    cmake \
    libpcl-dev \
    libeigen3-dev \
    && rm -rf /var/lib/apt/lists/*

# Set up a catkin workspace
RUN mkdir -p ~/$A_ROS_DIR/src

# Clone the LIKO repository and livox_ros_driver
RUN cd ~/$A_ROS_DIR/src && \
    git clone --recursive https://github.com/ICRA-2024/Mr-Zqr_LIKO.git && \
    cd Mr-Zqr_LIKO && git submodule update --init

# Clone livox_ros_driver
RUN cd ~/$A_ROS_DIR/src && \
    git clone https://github.com/Livox-SDK/livox_ros_driver.git

# Build the workspace, using bash explicitly
RUN /bin/bash -c "source /opt/ros/melodic/setup.bash && \
    cd ~/$A_ROS_DIR && \
    catkin_make"

# Source the workspace in the container
RUN echo "source ~/$A_ROS_DIR/devel/setup.bash" >> ~/.bashrc

# Define the entry point
CMD ["bash"]

