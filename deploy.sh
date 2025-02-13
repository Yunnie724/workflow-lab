#!/usr/bin/env bash

REPOSITORY=/home/ec2-user/cicdproject
cd $REPOSITORY

APP_NAME=cicdproject
JAR_NAME=$(ls $REPOSITORY/build/libs/*.jar | tail -n 1)
JAR_PATH=$REPOSITORY/build/libs/$JAR_NAME

CURRENT_PID=$(pgrep -fl java | grep $APP_NAME | awk '{print $1}')

if [ -z "$CURRENT_PID" ]
then
  echo "> 실행 중인 애플리케이션 없음."
else
  echo "> 기존 애플리케이션 종료: $CURRENT_PID"
  kill -15 $CURRENT_PID
  sleep 5
fi

echo "> 새 애플리케이션 배포: $JAR_PATH"
nohup java -jar $JAR_PATH > /dev/null 2>&1 &