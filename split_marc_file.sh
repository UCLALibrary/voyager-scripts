#!/bin/sh
# Splits a file of MARC records into files of up to N records each, with output names
#  based on input filename, but with .mrc extension.
# Example: If foo.dat contains 65 records, this command
#   split_marc_file.sh foo.dat 30
# will result in
#   foo.001.mrc (30 records)
#   foo.002.mrc (30 records)
#   foo.003.mrc (5 records)
# The input file will not be changed.

if [ -n "$2" ]; then
  FILENAME=$1
  NUMBER=$2
else
  echo Usage: $0 marcfile records_per_file
  exit 1
fi

# Get voyager environment, for vars and for cron
. `echo $HOME | sed "s/$LOGNAME/voyager/"`/.profile.local

# Split filename into basename and extension
# Hoops needed for EXT since can't use basename command unless extension is known...
EXT=`echo ${FILENAME} | awk -F. '{if (NF>1) {print $NF}}'`
BASENAME=`basename ${FILENAME} .${EXT}`
#echo $FILENAME == $BASENAME $EXT

# Binary marcsplit program splits into file.001, file.002 etc.
$BIN/marcsplit -s ${NUMBER} ${FILENAME} ${BASENAME}

# Now rename file.001 -> file.001.mrc, etc.
for CHUNK in ${BASENAME}.[0-9][0-9][0-9]; do
  if [ -f ${CHUNK} ]; then
    mv ${CHUNK} ${CHUNK}.mrc
  fi
done

