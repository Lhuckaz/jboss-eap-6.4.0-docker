# Originally from: http://blog.couchbase.com/2015/december/jboss-eap7-nosql-javaee-docker

# Use latest jboss/base-jdk:7 image as the base
FROM jboss/base-jdk:7

# Set the JBOSS_VERSION env variable
ENV JBOSS_VERSION 6.4.0
ENV JBOSS_HOME /opt/jboss/jboss-eap-6.4/

ADD jboss-eap-6.4.0.zip /jboss-eap-6.4.0.zip

USER root
RUN echo '%jboss ALL=(ALL) ALL' >> /etc/sudoers
RUN echo 'jboss ALL=(ALL) NOPASSWD:/run.sh' >> /etc/sudoers
RUN chpasswd <<<"jboss:jboss"

# Add the JBoss distribution to /opt, and make jboss the owner of the extracted zip content
# Make sure the distribution is available from a well-known place
RUN yum -y install openssh-server openssh-clients epel-release && \
    yum -y install pwgen && \
    yum -y install sudo && \
    yum -y install firewalld firewall-config

RUN rm -f /etc/ssh/ssh_host_ecdsa_key /etc/ssh/ssh_host_rsa_key && \
    ssh-keygen -q -N "" -t dsa -f /etc/ssh/ssh_host_ecdsa_key && \
    ssh-keygen -q -N "" -t rsa -f /etc/ssh/ssh_host_rsa_key && \
    sed -i "s/#UsePrivilegeSeparation.*/UsePrivilegeSeparation no/g" /etc/ssh/sshd_config && \
    sed -i "s/UsePAM.*/UsePAM yes/g" /etc/ssh/sshd_config

RUN cd / \
    && unzip jboss-eap-$JBOSS_VERSION.zip -d /opt/jboss/

ADD set_root_pw.sh /set_root_pw.sh
ADD run.sh /run.sh
ADD start.sh /start.sh
RUN touch /pass_root
RUN chmod +x /*.sh
RUN chown jboss:jboss /*.sh
RUN chown jboss:jboss /pass_root
RUN chown -R jboss:jboss /opt/jboss

RUN localedef -i zh_TW -c -f UTF-8 zh_TW.UTF-8

ENV AUTHORIZED_KEYS **None**

USER jboss

# Ensure signals are forwarded to the JVM process correctly for graceful shutdown
ENV LAUNCH_JBOSS_IN_BACKGROUND true

# Expose the ports we're interested in
# http://stackoverflow.com/a/32213512/1098564
EXPOSE 8080 9990 4447 9999 22

# Set the default command to run on boot
# This will boot JBoss EAP in the standalone mode and bind to all interface

CMD sh /start.sh