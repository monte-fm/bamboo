#!/bin/bash

# Start ssh and mysql services
service ssh start
service mysql start

# Download and install Bamboo
cd /opt && wget https://www.atlassian.com/software/bamboo/downloads/binary/atlassian-bamboo-5.14.0.2.tar.gz
tar -xvzf atlassian-bamboo-5.14.0.2.tar.gz
echo "bamboo.home=/opt/bamboo-home" > /opt/atlassian-bamboo-5.14.0.2/atlassian-bamboo/WEB-INF/classes/bamboo-init.properties
mv /root/mysql-connector-java-5.1.40-bin.jar /opt/atlassian-bamboo-5.14.0.2/lib

# Start Bamboo
bash /opt/atlassian-bamboo-5.14.0.2/bin/start-bamboo.sh
rm /opt/atlassian-bamboo-5.14.0.2.tar.gz

# Remove bamboo installation from next ssh connections
echo "#!/bin/bash" >  /root/autostart.sh
echo "service mysql start" >>  /root/autostart.sh
echo "service ssh start" >>  /root/autostart.sh
echo "bash /opt/atlassian-bamboo-5.14.0.2/bin/start-bamboo.sh" >> /root/autostart.sh