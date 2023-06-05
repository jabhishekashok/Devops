FROM ubuntu:20.04
RUN apt update -y
RUN apt install openjdk-8-jdk -y
RUN apt update -y && apt install systemctl -y
RUN groupadd tomcat && useradd -s /bin/false -g tomcat -d /opt/tomcat tomcat
ARG HOME_DIR=/opt/tomcat
WORKDIR /opt/tomcat
ADD https://archive.apache.org/dist/tomcat/tomcat-7/v7.0.109/bin/apache-tomcat-7.0.109.tar.gz ${HOME_DIR}/apache-tomcat-7.0.109.tar.gz
RUN tar -xvzf apache-tomcat-7.0.109.tar.gz -C /opt/tomcat/ --strip-components=1
WORKDIR /opt/tomcat
RUN chgrp -R tomcat /opt/tomcat && chmod -R g+r conf && chmod g+x conf && chown -R tomcat webapps/ work/ temp/ logs/
COPY tomcat.service /etc/systemd/system/tomcat.service
RUN systemctl daemon-reload
EXPOSE 8080
WORKDIR /var/lib/OpenMRS
RUN chown -R tomcat:tomcat /var/lib/OpenMRS
ADD https://sourceforge.net/projects/openmrs/files/releases/OpenMRS_Platform_2.5.0/openmrs.war openmrs.war
RUN cp openmrs.war /opt/tomcat/webapps/
RUN chown -R tomcat:tomcat /opt/tomcat/webapps/openmrs.war
#RUN apt update && apt install unzip -y && unzip /opt/tomcat/webapps/openmrs.war
CMD ["systemctl","start","tomcat"]
