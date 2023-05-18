FROM alpine/git AS gitclone
RUN cd / && git clone https://github.com/wakaleo/game-of-life.git

FROM maven:3-amazoncorretto-8 AS builder
COPY --from=gitclone /game-of-life /game-of-life
RUN cd /game-of-life && mvn package 

FROM tomcat:9-jdk8
LABEL author="abhi" organization="qt"
COPY --from=builder /game-of-life/gameoflife-web/target/*.war /usr/local/tomcat/webapps/gameoflife.war
RUN apt update && apt install unzip -y && unzip /game-of-life/gameoflife-web/target/*.war
EXPOSE 8080