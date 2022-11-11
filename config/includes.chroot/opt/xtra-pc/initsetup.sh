#!/bin/sh

FILE="/home/xpc/.initSetupComplete"
if [ ! -f $FILE ]; then
    sudo java -jar /opt/xtra-pc/SetXpcUserInitialPassword-1.0.jar
fi
