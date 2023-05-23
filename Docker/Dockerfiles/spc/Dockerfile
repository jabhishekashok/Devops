FROM amazoncorretto:11
RUN mkdir spc
WORKDIR /spc
ADD https://referenceapplicationskhaja.s3.us-west-2.amazonaws.com/spring-petclinic-2.4.2.jar /spc/spring-petclinic-2.4.2.jar
EXPOSE 8080
RUN ls
CMD ["java", "-jar", "spring-petclinic-2.4.2.jar"]

#2nd way

FROM amazoncorretto:11
ADD https://referenceapplicationskhaja.s3.us-west-2.amazonaws.com/spring-petclinic-2.4.2.jar /spring-petclinic-2.4.2.jar
EXPOSE 8080
RUN ls
CMD ["java", "-jar", "spring-petclinic-2.4.2.jar"]
