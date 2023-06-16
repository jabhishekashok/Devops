Docker Day 4 topics
-----------------------

### 1.	Create an alpine container in interactive mode and install python

* run the Alpine container in interactive mode with /bin/sh as `docker container run -it -P alpine /bin/sh`

* update & upgrade apk as below

```
apk update
apk upgrade --available
```

* install python3 using apk `apk add --update python3`

![output](./images/Capture1.PNG)

* check the python version 

![output](./images/Capture2.PNG)


### 2.	Create a ubuntu container with sleep 1d and then login using exec and install python

* deploy docker container for ubuntu

* connect to the container using exec command & install python from [Ref](https://www.digitalocean.com/community/tutorials/how-to-install-python-3-and-set-up-a-programming-environment-on-an-ubuntu-20-04-server)

* following the steps, below is the output while installation

![output](./images/Capture3.PNG)

* when checking the python3 version 

![output](./images/Capture4.PNG)

### 3.	Create a postgres container with username panoramic and password as trekking. Try logging in and show the databases (query for psql):

* command to deploy container `docker container run -it -e POSTGRES_PASSWORD=trekking -e POSTGRES_USER=panoramic -e POSTGRES_DB=employees postgres`
* once deployed, in iteractive mode, `psql -h  172.17.0.2 employees panoramic` 

### 4.	Try to create a docker file which runs php info page, use ARG and ENV wherever appropriate on 1. Apache, 2. nginx

* Create dockerfile for Apache2 & NGINX usinf UBUNTU images
* Check if the default pages are loading when we access the IP Addresses.
* after confirmation, write a file info.php with below content

```
<?php
phpinfo();
?>
```

* And try accessing the file name from browser



