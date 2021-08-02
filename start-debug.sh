#!/bin/bash

if [ -z "$RED5_HOME" ]; then 
  export RED5_HOME=.; 
fi

export JAVA_OPTS="-Xdebug -Xrunjdwp:transport=dt_socket,address=0.0.0.0:8787,server=y,suspend=n $JAVA_OPTS"

# Start Red5
exec $RED5_HOME/start.sh
