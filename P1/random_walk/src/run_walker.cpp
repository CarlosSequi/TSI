/*
 * run_walker.cpp
 *
 *  Created on: March, 2017
 *      Author: Carlos Manuel Sequí Sánchez
 */

#include "Walker.h"

int main(int argc, char **argv) {
    // Initiate new ROS node named "walker"
    ros::init(argc, argv, "walker");

    float dist = atof(argv[1]);

    // Create new stopper object
    Walker walker(dist);

    // Start the movement
    walker.startMoving();

    return 0;
};



