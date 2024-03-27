#!/bin/bash

# V1.0

TODAY=`date +"%d-%b-%y"`

# FULL PATH WITH BAR AT END
BKPNAME="PROFILE"
SOURCEDIR="/dados/samba/"
DESTDIR="/backup/bkp/"
LOGFILE="/var/log/bkpprofile.log"

# BKP FUNCTION
runbkp()
{
  echo "Backup started at `date`" >> $LOGFILE

  rsync -avz $SOURCEDIR $DESTDIR$BKPNAME"$TODAY" 2>> $LOGFILE

  if [ $? -eq 0 ]
  then
    echo "Backup -$BKPNAME finished at `date`" >> $LOGFILE
  else
    echo "^^^ Backup -$BKPNAME ERROR at `date`" >> $LOGFILE
  fi
}

# CLEAR BKP FUNCTION
clearbkp()
{
  # COUNT BY DAY
  APAGA=`date -d "-4 day" +"%d-%b-%y"`
  RMDIR=/backup/bkp/

  rm -r "$RMDIR$BKPNAME$APAGA" 2>>$LOGFILE

  if [ $? -eq 0 ]
  then
    echo "Directory -$RMDIR$BKPNAME$APAGA removed at `date`" >> $LOGFILE
  else
    echo "^^^ Clear backup -$BKPNAME ERROR at `date`" >> $LOGFILE
  fi


}

# RUN CLEARBKP AND RUNBKP
clearbkp
runbkp
