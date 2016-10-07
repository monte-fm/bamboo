#!/bin/bash
#Start ssh service
service ssh start

#Download and install Bamboo
cd /opt && wget https://www.atlassian.com/software/bamboo/downloads/binary/atlassian-bamboo-5.13.2.tar.gz
tar -xvzf atlassian-bamboo-5.13.2.tar.gz
echo "bamboo.home=/opt/bamboo-home" > /opt/atlassian-bamboo-5.13.2/atlassian-bamboo/WEB-INF/classes/bamboo-init.properties
#Start Bamboo
bash /opt/atlassian-bamboo-5.13.2/bin/start-bamboo.sh
rm /opt/atlassian-bamboo-5.13.2.tar.gz

#Remove bamboo installation from next ssh connections
echo "#!/bin/bash" >  /root/autostart.sh
echo "service ssh start" >>  /root/autostart.sh
echo "bash /opt/atlassian-bamboo-5.13.2/bin/start-bamboo.sh" >> /root/autostart.sh