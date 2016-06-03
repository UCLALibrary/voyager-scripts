#!/bin/sh

LC_CTYPE=en_US.UTF-8
export LC_CTYPE

JAVA=/usr/local/bin/java
DIR=/opt/local/java

if [ ! -x ${JAVA} ]
then
   exit 1
fi
if [ ! -s ${DIR}/amazon.jar ]
then
   exit 1
fi

${JAVA} -jar ${DIR}/amazon.jar

