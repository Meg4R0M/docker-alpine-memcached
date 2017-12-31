#!/bin/sh

echo [`date`] Bootstrapping Memcached...

function clean_up {
    # Perform program exit housekeeping
    echo [`date`] Stopping the service...
    killall memcached
    exit
}

echo [`date`] Starting the service

trap clean_up SIGTERM

memcached

echo [`date`] Bootstrap finished