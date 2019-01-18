#!/bin/sh -xv
Now=$(date --date="last Sat" +%Y-%m-%d)
aws s3 ls --region 'us-east-1' 's3://bucket-name/daily/www/' | grep $Now >> www.txt
folder_n=$(awk '{print $2}' www.txt)
dfolder=$Now/
if [[ "$folder_n" == "$dfolder" ]];
   then
   aws s3 mv --region us-east-1 "s3://bucket-name/daily/www/$Now" "s3://bucket-name/weekly/www/$Now" --recursive
   rm www.txt
   aws s3 rm --region us-east-1 s3://bucket-name/daily/www/$Now/
   else
   echo "Folder is not moved from bucket $Now"
fi

#Email Notification
if [ "$?" = "0" ]; then
        echo " Weekly Backup Process was Successful." | mail -s " Weekly Backup Status Successful" helloworld@abc.com
else
         echo " Weekly Backup Process Failed." | mailx -s "Weekly Backup Status Failed" helloworld@abc.com
        exit 1
fi
