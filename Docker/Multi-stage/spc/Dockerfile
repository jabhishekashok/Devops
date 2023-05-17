FROM alpine/git AS gitclone
RUN cd / && git clone https://github.com/spring-projects/spring-petclinic.git && \
    pwd && ls /spring-petclinic

FROM maven:3-amazoncorretto-17 AS builder
COPY --from=gitclone /spring-petclinic /spring-petclinic
RUN ls /spring-petclinic 
RUN cd /spring-petclinic && mvn package
RUN ls /spring-petclinic


FROM amazoncorretto:17-alpine-jdk
LABEL auth='Abhishek'
ARG HOME_DIR=/spc
RUN mkdir ${HOME_DIR}
WORKDIR ${HOME_DIR}
COPY --from=builder /spring-petclinic/target/spring-p*.jar ${HOME_DIR}/spring-petclinic-2.4.2.jar
RUN ls ${HOME_DIR}
EXPOSE 8080
CMD ["java","-jar","spring-petclinic-2.4.2.jar"]

