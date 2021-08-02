#!/bin/bash

usage() {
  echo "Usage:"
  echo "$0 -n APPLICATION_NAME [-p INSTALLATION_PATH] [-w true|false] [-c true|false]"
  echo "Options:"
  echo "-n:  Name of the application that you want to have. It's mandatory"
  echo "-p: (Optional) Path is the install location of Ant Media Server which is /usr/local/antmedia by default."
  echo "-w: (Optional) The flag to deploy application as war file. Default value is false"
  echo "-c: (Optional) The flag to deploy application in cluster mode. Default value is false"
  echo "-m:  Mongo DB host. If it's a cluster, it's mandatory. Otherwise optional"
  echo "-u:  Mongo DB user. If it's a cluster, it's mandatory. Otherwise optional"
  echo "-s:  Mongo DB password. If it's a cluster, it's mandatory. Otherwise optional"
  echo "-h: print this usage"
  echo " "
  echo "Example: "
  echo "$0 -n live -w"
  echo " "
  echo "If you have any question, send e-mail to contact@antmedia.io"
}

ERROR_MESSAGE="Error: App is not created. Please check the error in the terminal and take a look at the instructions below"

AMS_DIR=/usr/local/antmedia
AS_WAR=false
IS_CLUSTER=false

while getopts 'n:p:w:h:c:m:u:s:' option
do
  case "${option}" in
    n) APP_NAME=${OPTARG};;
    p) AMS_DIR=${OPTARG};;
    w) AS_WAR=${OPTARG};;
    c) IS_CLUSTER=${OPTARG};;
    m) MONGO_HOST=${OPTARG};;
    u) MONGO_USER=${OPTARG};;
    s) MONGO_PASS=${OPTARG};;
    h) usage 
       exit 1;;
   esac
done

check_result() {
  OUT=$?
      if [ $OUT -ne 0 ]; then
          echo -e $ERROR_MESSAGE
          usage
          exit $OUT
    fi
}

if [ -z "$APP_NAME" ]; then
  APP_NAME=$1

  if [ ! -z "$2" ]; then
    AMS_DIR=$2
  fi
fi

if [[ -z "$APP_NAME" ]]; then
    echo "Error: Missing parameter APPLICATON_NAME. Check instructions below"
    usage
    exit 1
fi

if [[ "$IS_CLUSTER" == "true" ]]; then
    if [[ -z "$MONGO_HOST" ]]; then
       echo "Please set mongodb host, username and password for cluster mode. "
       usage
       exit 1
    fi
fi

case $AMS_DIR in
  /*) AMS_DIR=$AMS_DIR;;
  *)  AMS_DIR=$PWD/$AMS_DIR;;
esac

APP_NAME_LOWER=$(echo $APP_NAME | awk '{print tolower($0)}')
APP_DIR=$AMS_DIR/webapps/$APP_NAME
RED5_PROPERTIES_FILE=$APP_DIR/WEB-INF/red5-web.properties
WEB_XML_FILE=$APP_DIR/WEB-INF/web.xml

mkdir $APP_DIR
check_result

echo $AMS_DIR
cp $AMS_DIR/StreamApp*.war $APP_DIR
check_result

cd $APP_DIR
check_result

jar -xf StreamApp*.war
check_result

rm StreamApp*.war
check_result

OS_NAME=`uname`

if [[ "$OS_NAME" == 'Darwin' ]]; then
  SED_COMPATIBILITY='.bak'
fi

sed -i $SED_COMPATIBILITY 's^webapp.dbName=.*^webapp.dbName='$APP_NAME_LOWER'.db^' $RED5_PROPERTIES_FILE
check_result
sed -i $SED_COMPATIBILITY 's^webapp.contextPath=.*^webapp.contextPath=/'$APP_NAME'^' $RED5_PROPERTIES_FILE
check_result
sed -i $SED_COMPATIBILITY 's^db.app.name=.*^db.app.name='$APP_NAME'^' $RED5_PROPERTIES_FILE
check_result
sed -i $SED_COMPATIBILITY 's^db.name=.*^db.name='$APP_NAME_LOWER'^' $RED5_PROPERTIES_FILE
check_result
sed -i $SED_COMPATIBILITY 's^<display-name>StreamApp^<display-name>'$APP_NAME'^' $WEB_XML_FILE
check_result
sed -i $SED_COMPATIBILITY 's^<param-value>/StreamApp^<param-value>/'$APP_NAME'^' $WEB_XML_FILE
check_result

if [[ "$IS_CLUSTER" == "true" ]]; then
    echo "Cluster mode"
	sed -i $SED_COMPATIBILITY 's/db.type=.*/db.type='mongodb'/' $RED5_PROPERTIES_FILE
    sed -i $SED_COMPATIBILITY 's#db.host=.*#db.host='$MONGO_HOST'#' $RED5_PROPERTIES_FILE  
    sed -i $SED_COMPATIBILITY 's/db.user=.*/db.user='$MONGO_USER'/' $RED5_PROPERTIES_FILE
    sed -i $SED_COMPATIBILITY 's/db.password=.*/db.password='$MONGO_PASS'/' $RED5_PROPERTIES_FILE
else 
    echo "Not cluster mode."    
fi


if [[ $AS_WAR == "true" ]]; then
  echo "Application will deployed as war" 
  jar -cvf $AMS_DIR/webapps/$APP_NAME.war -C $APP_DIR .  
  rm -r $APP_DIR
else
  echo "Application is deployed as directory."
fi

chown -R antmedia:antmedia $APP_DIR

echo "$APP_NAME is created."
