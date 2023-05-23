FROM tomcat:9-jdk8
LABEL author="Abhi" organization="qt" project="LIFE"
ADD https://referenceapplicationskhaja.s3.us-west-2.amazonaws.com/gameoflife.war /usr/local/tomcat/webapps/gameoflife.war
WORKDIR /webapps
RUN apt update && apt install unzip -y && unzip /usr/local/tomcat/webapps/gameoflife.war
EXPOSE 8080