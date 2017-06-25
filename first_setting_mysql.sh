#!/bin/bash

# Change Python2 => Python3
# CHK_PY_VER=`python --version | awk '{print $2}' | cut -d'.' -f1`
# if [[ ! $CHK_PY_VER = '3' ]]; then
#     sudo mv /usr/bin/python /usr/bin/python2
    
#     sudo ln -s /usr/bin/python3 /usr/bin/python
#     if [ $? -ne 0 ]; then
#         echo "can not create symbolic link of python3"
#         exit 1
#     else
#         echo "create symbolic link of python3"
#         python --version
#         echo "Change Python2 => Python3 Complete!"
#     fi
    
#     # Djangoの最新安定板をinstall
#     sudo pip3 install Django -U
#     if [ $? -eq 0 ]; then
#         django-admin --version
#     fi
    
#     # Mysqlclient
#     sudo pip3 install mysqlclient -U
#     if [ $? -ne 0 ]; then
#         exit 1
#     fi
# fi

# Create Mysql Database
CHK_USER_NAME=`echo $MYSQL_USERNAME`
if [[ ! $CHK_USER_NAME = '' ]]; then
    exit 1
fi

mysql-ctl restart
if [ $? -ne 0 ]; then
    echo "can not restart mysql server"
    exit 1
fi

PROFILE="$HOME/.bashrc"

# setting database user
while :
do
    echo -n "setting database_user> "
    read DB_USER
    
    DB_USER=`echo $DB_USER | tr -d ' '`
    
    if [[ ! $DB_USER = '' ]]; then
        break
    fi
done

# setting database password
while :
do
    echo -n "setting database_password> "
    read DB_PASSWORD
    
    DB_PASSWORD=`echo $DB_PASSWORD | tr -d ' '`
    
    if [[ ! $DB_PASSWORD = '' ]]; then
        break
    fi
done

mysql-ctl cli <<EOSQL
    GRANT ALL PRIVILEGES ON *.* TO '$DB_USER'@localhost IDENTIFIED BY '$DB_PASSWORD' WITH GRANT OPTION;
    FLUSH PRIVILEGES;
EOSQL

if [ $? -eq 0 ]; then
    echo "export MYSQL_USERNAME=$DB_USER" >> $PROFILE
    echo "export MYSQL_PASSWORD=$DB_PASSWORD" >> $PROFILE
    echo 'export TZ=JST-9' >> $PROFILE
    echo "Complete!"
    exec bash -l
fi