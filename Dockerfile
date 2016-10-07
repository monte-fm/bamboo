FROM      ubuntu:14.04
MAINTAINER Oleksandr Kutsenko    <olexander.kutsenko@gmail.com>

# install Software
RUN apt-get update && apt-get upgrade -y
RUN apt-get install -y software-properties-common python-software-properties \
    git git-core vim nano mc unzip wget htop tmux zip

# Install SSH service
RUN sudo apt-get install -y openssh-server openssh-client
RUN sudo mkdir /var/run/sshd
RUN echo 'root:root' | chpasswd
# change 'pass' to your secret password
RUN sed -i 's/PermitRootLogin without-password/PermitRootLogin yes/' /etc/ssh/sshd_config
# SSH login fix. Otherwise user is kicked off after login
RUN sed 's@session\s*required\s*pam_loginuid.so@session optional pam_loginuid.so@g' -i /etc/pam.d/sshd
ENV NOTVISIBLE "in users profile"
RUN echo "export VISIBLE=now" >> /etc/profile

# configs bash start
COPY configs/autostart.sh /root/autostart.sh
RUN  chmod +x /root/autostart.sh
COPY configs/bash.bashrc /etc/bash.bashrc
COPY configs/.bashrc /root/.bashrc

# Install locale
RUN locale-gen en_US.UTF-8
RUN dpkg-reconfigure locales

# Install Java 8
RUN apt-key adv --keyserver hkp://keyserver.ubuntu.com:80 --recv-keys EEA14886
RUN add-apt-repository -y ppa:webupd8team/java
RUN apt-get update
# Accept license non-iteractive
RUN echo oracle-java8-installer shared/accepted-oracle-license-v1-1 select true | sudo /usr/bin/debconf-set-selections
RUN apt-get install -y oracle-java8-installer \
                       oracle-java8-set-default
RUN echo "JAVA_HOME=/usr/lib/jvm/java-8-oracle" | sudo tee -a /etc/environment
RUN export JAVA_HOME=/usr/lib/jvm/java-8-oracle

# etcKeeper
RUN mkdir -p /root/etckeeper
COPY configs/etckeeper.sh /root/etckeeper.sh
COPY configs/files/etckeeper-hook.sh /root/etckeeper/etckeeper-hook.sh
RUN chmod +x /root/etckeeper/*.sh
RUN chmod +x /root/*.sh
RUN /root/etckeeper.sh

# Open ports: Web, SSH, Bamboo-agent
EXPOSE 8085 22 54663

VOLUME ["/opt/bamboo-home"]


CMD /bin/bash