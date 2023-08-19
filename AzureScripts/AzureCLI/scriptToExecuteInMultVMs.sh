--------- Script to connect to Servers and install packages -------------------
#!/bin/bash
# Name: Run_file.sh
# Description: This script connects to the given servers from hosts file and runs given command for instlaltion
# author: Tarun K
# date: 20th july 2023
# version: 1.0
#. $HOME/.bash_profile
export TT=`date '+%Y%m%d%H%M%S'`
#export User="tarun.k@gmail.com"
#export DBA=$1
export LOGDIR=$HOME/exelog
export LOGFILE=$LOGDIR/run_file_$TT.lst
export SCRIPTS="sudo apt update; sudo apt install apache2 php libapache2-mod-php -y;sudo -i; echo \"<?php phpinfo(); ?>\" > /var/www/html/info.php; exit"
echo "checking for dir existing" >>$LOGFILE
if [[ ! -d $LOGDIR ]];
then
echo "dir misisng, creating dir " >>$LOGFILE
mkdir $LOGDIR
else
echo ? >>$LOGFILE
fi
echo "checking for hosts file" >>$LOGFILE
if [[ -f /etc/hosts ]];
then
echo "hosts file exists.." >>$LOGFILE
else
echo "/etc/hosts missing..... " >>$LOGFILE
#echo "/etc/hosts file misisng while executing script Run_file.sh" |mailx -s "/etc/hosts file misisng while executing script Run_file.sh" $DBA
exit;
fi
# fetching host names
cat /etc/hosts |grep -v localhost |grep -v ^\# |grep -v ip6* | grep -v meta* |awk '{ print $2 }' | while read hostname
do
echo $hostname
status=$(ssh -o BatchMode=yes -o ConnectTimeout=25 tarun@$hostname echo ok 2>&1)
if [[ $status == ok ]] ;
then
echo "connectivity good to $hostname and running script" >>$LOGFILE
ssh -l tarun $hostname "$SCRIPTS"
else
  echo "ssh is not working between you and server. Exiting...."  >>${LOGFILE}
fi
done