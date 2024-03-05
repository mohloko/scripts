#!/bin/bash

TODAY=`date +"%d-%b-%y"`

# FULL PATH WITH BAR AT END
SOURCEDIR="/home/cleber/testedir/"
DESTDIR="/home/cleber/"

# BKP FUNCTION
runbkp()
{
  echo "Backup started at `date`" >> /var/log/bkp.log

  rsync -avz $SOURCEDIR $DESTDIR"$TODAY"

  if [ $? -eq 0 ]
  then
    echo "Backup finished at `date`" >> /var/log/bkp.log
  else
    echo "Backup ERROR at `date`" >> /var/log/bkp.log
  fi
}

# CLEAR BKP FUNCTION
clearbkp()
{
  # COUNT BY DAY
  APAGA=`date -d "-4 day" +"%d-%b-%y"`
  RMDIR=/backup/

  rm -rf $RMDIR$APAGA

  if [ $? -eq 0 ]
  then
    echo "Directory $RMDIR$APAGA removed at `date`" >> /var/log/bkp.log
  else
    echo "Clear backup ERROR at `date`" >> /var/log/bkp.log
  fi


}

# RUN CLEARBKP AND RUNBKP
clearbkp
runbkp
