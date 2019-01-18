#!/bin/bash -xv
#Author Ravi Jyothi
NOW=$(date +"%F")
FNOW=$(date +"%Y-%b-%d-%a-%H-%M")
#Instance=$(curl http://169.254.169.254/latest/meta-data/instance-id)
# Store backup path
BACKUP="/data/backups/daily/www/$NOW"

# make sure backup directory exists
[ ! -d $BACKUP ] && mkdir -p ${BACKUP}

# Backup websever dirs
cd /data/www/

mkdir -p ${BACKUP}/$(hostname)/application
fname=`ls | xargs`
for i in `echo $fname`
do
        tar -cvjf ${BACKUP}/$(hostname)/application/$i-$(date +"%Y-%b-%d-%a-%H-%M").tar.bz2 $i --exclude '.git'
done

# Backup /etc dirs for config files.
cd /etc
mkdir ${BACKUP}/$(hostname)/etc
tar -cvjf ${BACKUP}/$(hostname)/etc/etc-$(date +"%Y-%b-%d-%a-%H-%M").tar.bz2 /etc

# Backup MySQL
mkdir -p ${BACKUP}/$(hostname)/mysqldb
MYSQLDUMP="mysqldump"
MYSQLUSER="username"
MYSQLPASSWORD="your_password"
$MYSQLDUMP  -u ${MYSQLUSER} --password=${MYSQLPASSWORD} --all-databases | gzip -9 > ${BACKUP}/$(hostname)/mysqldb/$(date +"%Y-%b-%d-%a-%H-%M")-all-databases.sql.gz

# Backup Postgres database
mkdir -p ${BACKUP}/$(hostname)/postgresdb
sudo -u postgres pg_dump databasename > ${BACKUP}/$(hostname)/postgresdb/$(date +"%Y-%b-%d-%H-%M")_database_name.bak

# Backup Mongodump
mkdir -p ${BACKUP}/$(hostname)/mongodb
mongodump --archive=${BACKUP}/$(hostname)/mongodb/$(date +"%Y-%b-%d-%H-%M")_all_databases.gz --gzip

#Email Notification
if [ "$?" = "0" ]; then
        echo "Backup Process was Successful." | mail -s "Backup Status Successful" helloworld@abc.com
else
         echo "Backup Process Failed." | mailx -s "Backup Status Failed" helloworld@abc.com
        exit 1
fi
