/*
 * Walker.cpp
 *
 *  Created on: March, 2017
 *      Author: Carlos Manuel Sequí Sánchez
 */

#include "Walker.h"
#include "geometry_msgs/Twist.h"
#include <stdlib.h>
#include <iostream>
#include<time.h>

Walker::Walker(float dist)
{
    keepMoving = true;
    rightTurning = false;
    leftTurning = false;
    this->dist = dist;

    // Advertise a new publisher for the robot's velocity command topic
    commandPub = node.advertise<geometry_msgs::Twist>("/cmd_vel_mux/input/teleop", 10);

    // Subscribe to the simulated robot's laser scan topic
    laserSub = node.subscribe("scan", 1, &Walker::scanCallback, this);
}

// Send a velocity command
void Walker::moveForward() {
    geometry_msgs::Twist msg; // The default constructor will set all commands to 0
    msg.linear.x = FORWARD_SPEED;
    commandPub.publish(msg);
}

void Walker::turning()
{
    srand(time(NULL));
    randTurningValue=5+rand()%(20);
    float side;

    //decidimos hacia donde girar
    if(rightTurning)
    {
        side = -ANGULAR_SPEED;
        rightTurning = false;
        //ROS_INFO("GIRAMOS A DERECHA\n");
    }
    else
    {
        side = ANGULAR_SPEED;
        leftTurning = false;
       // ROS_INFO("GIRAMOS A IZQUIERDA\n");
    }

    geometry_msgs::Twist msg; // The default constructor will set all commands to 0
    msg.angular.z = side * randTurningValue;
    commandPub.publish(msg);         
    
}


void Walker::ChooseTurningSide(const sensor_msgs::LaserScan::ConstPtr& scan, int minIndex, int maxIndex)
{
    int leftSideObstacles = 0;
    int rightSideObstacles = 0;


    //comprobamos la cantidad de obstaculos en el lado izquierdo y derecho
    for (int currIndex = minIndex + 1; currIndex <= maxIndex; currIndex++) 
    {
       // cout << "NUMMMM:" << currIndex << "\n";
        if (scan->ranges[currIndex] < dist) 
        {
            if(currIndex <= maxIndex/2)
                 rightSideObstacles++;
            else
                 leftSideObstacles++;
        }
    }

    //ROS_INFO("Numero de obstaculos por la izquierda: %i \n", leftSideObstacles);
    //ROS_INFO("Numero de obstaculos por la derecha: %i \n", rightSideObstacles);

    //realizamos la elección de lado a donde girar.
    if(leftSideObstacles <= rightSideObstacles)
    {
        leftTurning = true;
    }
    else
    {
        rightTurning = true;
    }

}


// Process the incoming laser scan message
void Walker::scanCallback(const sensor_msgs::LaserScan::ConstPtr& scan)
{
	bool isObstacleInFront = false;

    // Find the closest range between the defined minimum and maximum angles
    int minIndex = ceil((MIN_SCAN_ANGLE - scan->angle_min) / scan->angle_increment);
    int maxIndex = floor((MAX_SCAN_ANGLE - scan->angle_min) / scan->angle_increment);

    for (int currIndex = minIndex + 1; currIndex <= maxIndex && !isObstacleInFront; currIndex++) 
    {
        if (scan->ranges[currIndex] < dist)
        {
        	isObstacleInFront = true;
        }
    }

    if (isObstacleInFront) {

        //ROS_INFO("OBSTACULO EN FRENTE!");
        keepMoving = false;

        //elegimos el lado hacia donde guirar
        ChooseTurningSide(scan, minIndex, maxIndex);
        
    }
    else
    {
       // ROS_INFO("NO HAY OBSTACULO, SEGUIMOS");
        keepMoving = true;
        rightTurning = false;
        leftTurning = false;
    }
}

void Walker::startMoving()
{
    ros::Rate rate(10);
    ROS_INFO("Start moving");

    // Keep spinning loop until user presses Ctrl+C or the robot got too close to an obstacle
    while (ros::ok()) {
        if(keepMoving)
        {
            moveForward();
        }
        else
        {
            //giramos hacia el lado que hayamos elegido previamente
            turning();
        }
        
        ros::spinOnce(); // Need to call this function often to allow ROS to process incoming messages
        rate.sleep();
    }
}


