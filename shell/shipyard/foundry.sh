#!/bin/sh

SHIPYARD_STARTING=$true

#SHIPYARD Starts 5 containers in order: redis, router, lb, db
#inform user we are waiting for shipyard to be complete

echo "shipyard containers (redis, router, lb, db, shipyard) starting this will take a few minutes..."; 

while $SHIPYARD_STARTING; do	
	STARTING_STATUS=$(docker ps | grep shipyard/redis);
	if [ "$STARTING_STATUS" ];then
		echo "shipyard redis up and running moving on to router"
		break;
	else
		echo "shipyard redis starting..."; 
		sleep 15s; 
	fi
done

while $SHIPYARD_STARTING; do	
	STARTING_STATUS=$(docker ps | grep shipyard/router);
	if [ "$STARTING_STATUS" ];then
		echo "shipyard router up and running moving on to lb"
		break;
	else
		echo "shipyard router starting..."; 
		sleep 15s; 
	fi
done

while $SHIPYARD_STARTING; do	
	STARTING_STATUS=$(docker ps | grep shipyard/lb);
	if [ "$STARTING_STATUS" ];then
		echo "shipyard lb up and running moving on to db"
		break;
	else
		echo "shipyard lb starting..."; 
		sleep 15s; 
	fi
done

while $SHIPYARD_STARTING; do	
	STARTING_STATUS=$(docker ps | grep shipyard/db);
	if [ "$STARTING_STATUS" ];then
		echo "shipyard db up and running moving on to app"
		break;
	else
		echo "shipyard db starting..."; 
		sleep 15s; 
	fi
done

while $SHIPYARD_STARTING; do	
	STARTING_STATUS=$(docker ps | grep shipyard/shipyard);
	if [ "$STARTING_STATUS" ];then
		echo "shipyard up and available"
		break;
	else
		echo "shipyard app starting..."; 
		sleep 15s; 
	fi
done
