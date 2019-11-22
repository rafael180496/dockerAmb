#Ocupar ubuntu para ambiente isgl en contendor
#antes crear red
#sudo docker network create isglred
#sudo docker run -it --network isglred isgld:latest sh
#sudo docker run -it --network host isgld:latest sh
FROM debian
LABEL maintainer="rafael180496@gmail.com"
#Utilidades
RUN apt-get update 
RUN DEBIAN_FRONTEND=noninteractive apt-get install -y --no-install-recommends apt-utils

#dependencia de la imagen
RUN apt-get install vim -y && \
    apt-get install curl -y && \
    apt-get install wget -y && \
    apt-get install gzip -y && \
    apt-get install unzip -y && \
    apt-get install zip -y && \
    apt-get install p7zip-full -y && \
    apt-get install inotify-tools -y && \
    apt-get install software-properties-common -y && \
    apt-get install libaio1 -y && \
    apt-get install alien -y 
#intalacion de rpm
RUN apt-get install rpm -y
#intalar git
RUN apt-get install git -y

RUN mkdir auxprogram && \
    cd auxprogram && \
    git clone https://github.com/rafael180496/dockerglash.git

#INTALACION DE  ORACLE ORACLE
RUN cd  /auxprogram/dockerglash && \
    7z e jdkclient.7z.001 
RUN cd  /auxprogram/dockerglash && \
    rm -R jdkclient.7z.0* 
RUN cd  /auxprogram/dockerglash && \
    alien -i *.rpm
    
RUN cd  /auxprogram/dockerglash && \
    rm *.rpm && \
    rm -R Comprimer && \
    rm README.md && \
    mkdir -p "/usr/lib/oracle/12.1/client64/network/admin"

ENV  ORACLE_HOME /usr/lib/oracle/12.1/client64 
ENV  LD_LIBRARY_PATH /usr/lib/oracle/12.1/client64/lib:$LD_LIBRARY_PATH 
ENV  TNS_ADMIN /usr/lib/oracle/12.1/client64/network/admin
ENV  PATH $PATH:$ORACLE_HOME/bin
 
#AGREGAR AL PATH
RUN  mkdir -p "/usr/lib/jvm" && \
     cd /usr/lib/jvm && \
     tar -xvzf /auxprogram/dockerglash/jdk-8u221-linux-x64.tar.gz

ENV J2SDKDIR /usr/lib/jvm/jdk1.8.0_221
ENV J2REDIR /usr/lib/jvm/jdk1.8.0_221/jre
ENV JAVA_HOME /usr/lib/jvm/jdk1.8.0_221
ENV DERBY_HOME /usr/lib/jvm/jdk1.8.0_221/db
ENV PATH $PATH:$JAVA_HOME/bin

RUN  update-alternatives --install "/usr/bin/java" "java" "/usr/lib/jvm/jdk1.8.0_221/bin/java" 0 && \
     update-alternatives --install "/usr/bin/javac" "javac" "/usr/lib/jvm/jdk1.8.0_221/bin/javac" 0 && \
     update-alternatives --set java /usr/lib/jvm/jdk1.8.0_221/bin/java && \
     update-alternatives --set javac /usr/lib/jvm/jdk1.8.0_221/bin/javac

RUN rm -R  /auxprogram
#INTALACION DE glassfish4
RUN         curl -L -o /tmp/glassfish-4.1.zip http://download.java.net/glassfish/4.1/release/glassfish-4.1.zip && \
            unzip /tmp/glassfish-4.1.zip -d /usr/local && \
            rm -f /tmp/glassfish-4.1.zip

EXPOSE 8080 4848 8181

ENV GLASSFISH_HOME /usr/local/glassfish4
ENV PATH $PATH:$GLASSFISH_HOME/bin

ENV ADMIN_USER admin
ENV ADMIN_PASSWORD admin
RUN echo 'AS_ADMIN_PASSWORD=\n\
AS_ADMIN_NEWPASSWORD='$ADMIN_PASSWORD'\n\
EOF\n'\
>> /opt/tmpfile

RUN echo 'AS_ADMIN_PASSWORD='$ADMIN_PASSWORD'\n\
EOF\n'\
>> /opt/pwdfile

RUN \
 asadmin start-domain && \
 asadmin --user $ADMIN_USER --passwordfile=/opt/tmpfile change-admin-password && \
 asadmin --user $ADMIN_USER --passwordfile=/opt/pwdfile enable-secure-admin && \
 asadmin restart-domain

#variables isglc
ENV SMFDESCARGA /app/data/iSGL/webservices/data_smf/recibido/
ENV SMFASIGNACION /app/data/iSGL/webservices/data_smf/asignaciones/
ENV CONFIG_PATH_ESPECIFICAS /app/data/iSGL/batch_process/isgl/programas/config_files/config_isgl_descarga_smf.xml
ENV ISGL_BATCH_PROGRAM /app/data/iSGL/batch_process/isgl/programas/ISGL_BATCH.jar
ENV CONFIG_PATH_DESCARGA_SGC /app/data/iSGL/batch_process/isgl/programas/config_files/config_isgl_descarga_sgc.xml
ENV CONFIG_PATH_SMF_ISGL /app/data/iSGL/batch_process/isgl/programas/config_files/config_isgl_carga_smf.xml

#depuracion de la imagen
RUN  apt-get remove --purge unzip -y && \
     apt-get remove --purge p7zip-full -y && \    
     apt-get remove --purge alien -y && \
     apt-get remove --purge rpm -y && \
     apt-get remove --purge git -y

RUN  apt-get autoremove -y

#configuracion ssh

RUN apt-get install openssh-server -y
RUN apt-get install sudo -y

USER root
RUN mkdir -p "/app/data/iSGL"
ENV  SSH_MASTER_USER master
ENV  SSH_MASTER_PASS abc123

COPY configssh/ssh_config /etc/ssh/ssh_config
COPY configssh/sshd_config /etc/ssh/sshd_config
COPY configssh/user.sh /usr/local/bin/user.sh
RUN chmod +x /usr/local/bin/user.sh
RUN /usr/local/bin/user.sh
 
COPY configssh/entrypoint.sh /usr/local/bin/entrypoint.sh
RUN chmod +x /usr/local/bin/entrypoint.sh

RUN chmod -R 777 /app/data/iSGL

WORKDIR /app/data/iSGL

ENTRYPOINT ["/usr/local/bin/entrypoint.sh"]
 
CMD tail -f /dev/null
#carpeta de trabajo

# comandos de inicio de sesion


#CMD asadmin start-domain --verbose
#/usr/local/glassfish4/glassfish/domains war volume
#/usr/lib/oracle/12.1/client64/network/admin volume dir
#/app/data/iSGL volume dir
#asadmin --host localhost --port 4848 enable-secure-admin