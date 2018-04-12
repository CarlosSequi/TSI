/*
 * Walker.h
 *
 *  Created on: March, 2017
 *      Author: Carlos Manuel Sequí Sánchez
 */

#ifndef WANDER_BOT_SRC_WALKER_H_
#define WANDER_BOT_SRC_WALKER_H_
#include "ros/ros.h"
#include "sensor_msgs/LaserScan.h"

using namespace std;

class Walker {
public:
    // Tunable parameters
    const static double FORWARD_SPEED = 0.4;
    const static double ANGULAR_SPEED = 0.1;
    const static double MIN_SCAN_ANGLE = -30.0/180*M_PI;
    const static double MAX_SCAN_ANGLE = +30.0/180*M_PI;

    Walker(float dist);
    void startMoving();

private:
    ros::NodeHandle node;
    ros::Publisher commandPub; // Publisher to the robot's velocity command topic
    ros::Subscriber laserSub; // Subscriber to the robot's laser scan topic
    bool keepMoving; // Indicates whether the robot should continue moving
    bool rightTurning;
    bool leftTurning;
    int randTurningValue;
    float dist;


    void moveForward();
    void turning();
    void ChooseTurningSide(const sensor_msgs::LaserScan::ConstPtr& scan, int minIndex, int maxIndex);
    void scanCallback(const sensor_msgs::LaserScan::ConstPtr& scan);
};

#endif 
