#!/usr/bin/env bash

pull_source() {
    local tmpDir=~/temp/lqs
    if [ -d "$tmpDir" ]; then
        echo "exist $tmpDir"
        cd $tmpDir
        if [ "$1" ]; then
            echo "pulling file from repository => $1"
            git checkout "$1"
            git pull origin "$1"
        else 
            echo "pulling file from repository => master"
            git pull origin master
        fi
    else 
        echo "not exist $tmpDir"
        mkdir ~/temp
        cd ~/temp
        if [ "$1" ]; then
            echo "clone file from repository => $1"
            git clone -b "$1" https://github.com/gaonsoflt/lqs.git
        else 
            echo "clone file from repository => master"
            git clone https://github.com/gaonsoflt/lqs.git
        fi
        cd lqs
    fi
}

pull_source "$BRANCH"

###############################
# create db.properties file
###############################
db_file=~/temp/lqs/src/main/resources/egovframework/property/db.properties
tmp_db_file=~/temp/db.properties

# backup db.properties
mv $db_file $tmp_db_file

# gen db.properties
echo "# postgres" > $db_file
echo "Globals.DbType=postgresql" >> $db_file
echo "db.driver=org.postgresql.Driver" >> $db_file
echo "db.url=jdbc:postgresql://$DB_PORT_5432_TCP_ADDR:$DB_PORT_5432_TCP_PORT/$DB_ENV_POSTGRES_DB" >> $db_file
echo "db.username=$DB_ENV_POSTGRES_USER" >> $db_file
echo "db.password=$DB_ENV_POSTGRES_PASSWORD" >> $db_file

echo "create db.properties file"
cat $db_file

# compile
mvn clean compile war:war

# deploy .war
cp target/lqs.war "$CATALINA_HOME"/webapps/.

# restore db.properties
mv $tmp_db_file $db_file

exec catalina.sh run
