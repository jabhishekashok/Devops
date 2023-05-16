FROM alpine/git AS gitclone
RUN cd / && git clone https://github.com/spring-projects/spring-petclinic.git && \
    pwd && ls /spring-petclinic

FROM maven:3-amazoncorretto-17 as builder
COPY --from=gitclone /spring-petclinic /spring-petclinic
RUN ls /spring-petclinic 
RUN cd /spring-petclinic && mvn package


FROM amazoncorretto:17-alpine-jdk
LABEL auth='Abhishek'
ARG HOME_DIR= /spc
WORKDIR ${HOME_DIR}
COPY --from=builder /spring-petclinic/target/*.jar ${HOME_DIR}/spring-petclinic.jar
EXPOSE 8080
CMD ['java','-jar','spring-petclinic.jar']

