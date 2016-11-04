#!/bin/bash

# Start ssh and mysql services
service ssh start
service mysql start

# Start Bamboo server
bash /opt/atlassian-bamboo-5.14.0.2/bin/start-bamboo.sh

