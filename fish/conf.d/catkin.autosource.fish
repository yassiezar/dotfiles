# Auto-source for catkin when you cd into the working directory. Also sets the CMAKE_PREFIX variable to include various self-compiled libraries for building
function catkinSource --on-variable PWD
    status --is-command-substitution; and return
    if test -e ".catkin_workspace"; or test -e ".catkin_tools"
        bass source devel/setup.bash
	set CMAKE_PREFIX_PATH $CMAKE_PREFIX_PATH /home/jaycee/src/pytorch/pytorch_install /home/jaycee/src/vision/vision_install /home/jaycee/src/opencv/opencv_install /home/jaycee/src/frugally-deep/fdeep_install /home/jaycee/src/FunctionalPlus/fplus_install
        echo "Configured the folder as a workspace"
    end
end
