OpenMRS
--------

### Link

`https://www.linuxcloudvps.com/blog/how-to-install-openmrs-on-ubuntu-20-04/`

* **All installations in root user** 

### Install Java

* apt-get update -y

* apt-get install openjdk-8-jdk -y

* java -version

### Install mysql

### Install tomcat

* groupadd tomcat

* useradd -s /bin/false -g tomcat -d /opt/tomcat tomcat

* wget https://archive.apache.org/dist/tomcat/tomcat-7/v7.0.109/bin/apache-tomcat-7.0.109.tar.gz 

* mkdir /opt/tomcat

* tar -xvzf apache-tomcat-7.0.109.tar.gz -C /opt/tomcat/ --strip-components=1

```bash
cd /opt/tomcat
chgrp -R tomcat /opt/tomcat
chmod -R g+r conf
chmod g+x conf
chown -R tomcat webapps/ work/ temp/ logs/
```

### configure tomcat

* vi  /etc/systemd/system/tomcat.service

```bash
[Unit]
Description=Apache Tomcat Web Application Container
After=network.target
[Service]
Type=forking
Environment=JAVA_HOME=/usr/lib/jvm/java-1.8.0-openjdk-amd64
Environment=CATALINA_PID=/opt/tomcat/temp/tomcat.pid
Environment=CATALINA_HOME=/opt/tomcat
Environment=CATALINA_BASE=/opt/tomcat
Environment=’CATALINA_OPTS=-Xms512M -Xmx1024M -server -XX:+UseParallelGC’
ExecStart=/opt/tomcat/bin/startup.sh
ExecStop=/opt/tomcat/bin/shutdown.sh
User=tomcat
Group=tomcat
UMask=0007
RestartSec=10
Restart=always
[Install]
WantedBy=multi-user.target
```

* save the file

* systemctl daemon-reload

* Next, start the Tomcat service with the following command: `systemctl start tomcat`

* You can now check the status of the Tomcat service with the following command:`systemctl status tomcat`


### install OpenMRS

* First, create a directory for OpenMRS and set proper ownership with the following command:

```bash
mkdir /var/lib/OpenMRS
chown -R tomcat:tomcat /var/lib/OpenMRS
```

* Next, download the latest version of OpenMRS using the following command:

`wget https://sourceforge.net/projects/openmrs/files/releases/OpenMRS_Platform_2.5.0/openmrs.war` 

* Once the download is completed, copy the downloaded file to the Tomcat webapps directory:

`cp openmrs.war /opt/tomcat/webapps/`

* Next, change the ownership of the openmrs.war file to tomcat:

`chown -R tomcat:tomcat /opt/tomcat/webapps/openmrs.war`


