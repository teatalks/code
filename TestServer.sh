sudo apt-get -y update && sudo apt-get -y upgrade

# java/tomcat and postgressSQL installation

echo "Updating Java..."
sudo apt-get -y install default-jdk 
echo "Installing tomcat8..."
sudo apt-get -y install tomcat8 
sudo apt-get -y install tomcat8-docs tomcat8-examples tomcat8-admin

#bash to admin-user in tomcat
#----------------------------
sed -i 's+</tomcat-users>+  <role rolename="admin-script"/>+gI' /var/lib/tomcat8/conf/tomcat-users.xml
echo '  <role rolename="manager"/>'  >> /var/lib/tomcat8/conf/tomcat-users.xml
echo '  <role rolename="manager-gui"/>'  >> /var/lib/tomcat8/conf/tomcat-users.xml
echo '  <role rolename="manager-script"/>'  >> /var/lib/tomcat8/conf/tomcat-users.xml
echo '  <role rolename="manager-jmx"/>'  >> /var/lib/tomcat8/conf/tomcat-users.xml
echo '  <role rolename="manager-status"/>'  >> /var/lib/tomcat8/conf/tomcat-users.xml
echo '  <user username="tomcat" password="tomcat" roles="admin, manager,admin-script,manager-script,manager-jmx,manager-status,manager-gui,admingui"/>'  >> /var/lib/tomcat8/conf/tomcat-users.xml
echo "</tomcat-users>"  >> /var/lib/tomcat8/conf/tomcat-users.xml

#bash to restart tomcat
#----------------------
echo "Restart tomcat8..."
sudo systemctl restart tomcat8 
sleep 5

#echo "Tomcat8 Status..."
#sudo systemctl status tomcat8
# PostgressSQL installation

# Section 1 - Variable Creation

# $rfolder is the install directory for PostgreSQL
rfolder='/postgres'
# $dfolder is the root directory for various types of read-only data files
dfolder='/postgres/data'
# $sysuser is the system user for running PostgreSQL
sysuser='postgres'
# $scripts directory
scripts="/home/$USER/scripts"
# $sqlscript is the sql script for creating the PSQL user and creating a database.
sqlscript="$scripts/initial-table.sql"
# $logfile is the log file for this installation.
logfile='psqlinstall-log'

# Section 2 - Package Installation

# This for-loop will pull all packages from the package array and install them using apt-get
echo "Installing PostgreSQL dependencies"
sudo apt-get install ${packages[@]} -y >> $logfile

# Section 3 - Create required directories
echo "Creating folders $dfolder..."
sudo mkdir -p $dfolder >> $logfile
sudo mkdir -p $scripts >> $logfile

# Section 4 - Create system user

#echo "Creating system user '$sysuser'"
#sudo adduser --system $sysuser >> $logfile

# Section 5 - Installing  PSQL

echo "installing PostgreSQL"
sudo apt-get -y install postgresql postgresql-contrib 
echo "host    all             all             0.0.0.0/0               md5" >> /etc/postgresql/10/main/pg_hba.conf
sed -i 's+localhost+*+gI' /etc/postgresql/10/main/postgresql.conf
sed -i 's+#listen_addresses+listen_addresses+gI' /etc/postgresql/10/main/postgresql.conf

#listen_addresses = 'localhost'
# Section 7 - Start PSQL

echo "Wait for PostgreSQL to finish starting up..."
sleep 5

# Section 8 - initial-table.sql script is ran

# The initial-table.sql script is downloaded and ran to create the user, database, and populate the database.
#echo "Downloading SQL script"
#wget -P $scripts https://raw.githubusercontent.com/devopsbc01/Scripts/master/initial-table.sql

#echo "Running script"
#$rfolder/bin/psql -U postgres -f $sqlscript

#sudo -u postgres psql -f $sqlscript

echo "Restarting postgres DB"
sudo /etc/init.d/postgresql restart
echo "Hello Guys!: Your Infrastructure is ready to deploy Mars Communication"

