#!/bin/bash
######################################################################
#Script Name  :   Disk_Cleaner X
#Description  :   Its Main Stream Project To Handle Space Issues
#Author       :   Alvin Lazar C
#Email        :   alvin.la@endurance.com(alvinlaz96@yahoo.com)
######################################################################

clear;


#--Activate output via email by setting "sendmail" to 1 and uncomment "email"--#
sendmail=0
#email=user@yourdomain.com

progress()
{
pid=$! # Process Id of the previous running command
spin='-\|/'

i=0
while kill -0 $pid 2>/dev/null
do
  i=$(( (i+1) %4 ))
  printf "\r  ${spin:$i:1}"
  sleep .1
done
}

output=/tmp/wp_outdated.txt
tempf1=/tmp/search_wp
tempf2=/tmp/temp_output
conf=/usr/local/apache/conf/httpd.conf

rm -f $output
rm -f $tempf1
rm -f $tempf2

read -e -p "Enter the directory path to scan (Eg: /home, /home/*/public_html): "  dir

wp_latest=$( curl -k -s "https://api.wordpress.org/core/version-check/1.6/" | awk -F'"' {'print $10'} | cut -d"-" -f2 | cut  -c -5 )
echo "WordPress latest Version is $wp_latest"
find $dir -type f -iwholename "*/wp-includes/version.php" -exec grep -H "\$wp_version =" {} >> $tempf1 \; &
echo  "Search in progress, this may take several minutes"
progress
echo ""

echo "Website URL | Username | Full Path | Version"  >> $tempf2
echo "----------------- | -------- | --------- | -------" >> $tempf2
for j in $( sed 's/ //g' $tempf1 )
do
path=$( echo  "$j" | awk -F"wp-includes" {'print $1'} | sed 's/.$//' )
nf=$( echo $path | grep -o "/" | wc -l )
ver=$( echo "$j" | cut -d\' -f2 )
user=$( echo "$path" | cut -d"/" -f3 )
lastf=""

        if [ "$(printf "$wp_latest\n$ver" | sort -V | head -n1)" == "$ver" ] && [ "$ver" != "$wp_latest" ] ; then
                ct=0
                path_org=$path
                while [ $nf -gt 2 ] ;do
                        if  grep -q -B2 $path $conf ;then
                        dom=$( grep  -B2 $path $conf | head -n1 | awk  {'print $2'} )
                        echo  "$dom$lastf | $user | $path_org | $ver" >>  $tempf2
                        break
                        else
                        (( ct++ ))
                        lastf=/$( echo "$path_org" | rev | cut -d"/"  -f1-$ct | rev )
                        path=$( echo "$path" | rev | cut -d"/" -f2- | rev )
                        (( nf-- ))
                        fi
                done
        else
        sleep 1
        fi
done
echo ""
if  sed '3q;d' $tempf2 | grep -E -q "*" ; then
cat $tempf2 | column -s '|' -o '|' -t > $output
echo "Search completed. Find the Output file at: $output "

#Send output via email
 if [ $sendmail -eq 1 ];then
echo "Please find the attachement" | mail -s "WordPress Outdated installations" -a $output $email
echo "Output has been sent to $email"
 else
 sleep 1
 fi

else
echo "No outdated Wordpress installation found"
fi



##########

unset h,v,t,x,e,w,homr,homrx,varr,tmpr,varrx,hn,k;

#Function dsh print dashes.
dsh () { 

echo -e "\n##########################################\n";

};

waiter () {

  p=0;

  while kill -0 $pi;  
  
  do

    printf "." sleep 1;

    sleep 2;

    p=$(($p+1));

    if [ $p -eq 5 ];

      then

        echo -e "[OK]";
        exit 0;unset p,pi;

    fi;

  done
    
};

homr () { 

if [ "$hn" == NULL ];

  then
  
    echo -e "\nOuch.. You Missed Home_Number. Running Normal Mode "; sleep 2s; 
      
    echo -e "\n\nAll_Homes\tReport`hostname`\t`date +%d-%m-%Y`\n\n Clearing Error Logs\r `ls -A /var/cpanel/users |xargs -n1 -I{}  sudo du -sh  /home/{}/public_html/error_log &> /dev/null;`" &&
    
    pi=`pgrep -f xargs` &&
    
    waiter $pi;
    
    fi; }

elif [ "$dir" == "v" ];

  then

    echo -e "\nVAR\n";

    i=1;
    
else

    echo -e "\n\e[1;41m \e[0m\n\tGood Bye...";

    i=1;

fi;

};

homrx () {  }
varr () {  }
tmpr () {  }
varrx () {  }

clear &&
read -rep $'Enter the Disk Partion To scan (Eg: /home, /var, /tmp, /)\n\nAvailable Options (h,v,t,x) Extended Option for home(e) var(w):' dir

if [ "$dir" == "h" ];

  then
    
    hn=NULL
    
    echo -e "\nEnter Home Number (A for All) : ";
    
    read -r hn;
    
    homr $hn

elif [ "$dir" == "v" ];

  then

    echo -e "\nDetailed Report Stored In /ramdisk/mreports.txt\n";

    i=1;

elif [ "$dir" == "t" ];

  then

    read -rep $'\nEnter required mail:' mid; 

    echo -e "\n`sleep 2s`Email Successfully Sent to `cat /ramdisk/mreports.txt |mail -s "Malware Report" $mid >/dev/null`$mid\n";

    i=1;

elif [ "$dir" == "x" ];

  then

    echo -e "\n\e[1;42m  \e[0m\n";

    i=1;

elif [ "$dir" == "x" ];

  then

    echo -e "\n\e[1;42m \e[0m\n";

    i=1;
    
 else

    echo -e "\n\e[1;41m \e[0m\n\tGood Bye...";

    i=1;

fi;





#echo -e "\n\e[1;33m`k=$(((RANDOM%50)));curl -sk https://raw.githubusercontent.com/alvinlaz96/SysAdmin-Scripts-Linux/master/quotes 2>/dev/null |head -$k|tail -1`\e[0m\n"

echo -e "\n\e[1;33m`k=$(((RANDOM%50)));curl -sk http://hgfix.net/paste/view/raw/92cfa34e 2>/dev/null |head -$k|tail -1`\e[0m\n"

exit 0
