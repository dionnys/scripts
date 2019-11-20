 #!/bin/bash


dir="/root/scripts"
ftp_user="user"
ftp_passwd="password"
ftp_server="hosts"
hora=`date +%k`
fecha=`date +%d-%m-%Y`


############################################################################################

function Transferencia () {
ftp -n $ftp_server << END_SCRIPT
quote user $ftp_user
quote pass $ftp_passwd
mkdir $fecha
cd $fecha
mkdir $hora
cd $hora
lcd $dir/tmp
put $file
bye
END_SCRIPT
}

############################################################################################



rm -vf  $dir/tmp/mysql*



for db in $(cat $dir/db.txt)

       do

                file="mysql-$db-$(date +%d-%m-%Y-%R).gz"

                mysqldump $db |gzip > $dir/tmp/$file

      		echo "Transfiriendo archivo $file"

	        Transferencia


      done
