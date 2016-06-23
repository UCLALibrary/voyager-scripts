#!/bin/sh

# Get voyager environment, for vars and for cron
. `echo $HOME | sed "s/$LOGNAME/voyager/"`/.profile.local

LC_CTYPE=en_US.UTF-8
export LC_CTYPE

JAVA=${BIN}/java
DIR=/usr/local/java

if [ ! -x ${JAVA} ]
then
   exit 1
fi
if [ ! -s ${DIR}/amazon.jar ]
then
   exit 1
fi

${JAVA} -jar ${DIR}/amazon.jar

