Kubernets installaton Steps :
-----------------------------------

### Install Docker in all VMs:

* Install docker on all 3 VMs


`curl -fsSL https://get.docker.com -o get-docker.sh`


`sh get-docker.sh`

* Add users to Docker group (default users for AWS - ubuntu/Azure -
azureuser)

`sudo usermod -aG docker azureuser` OR `sudo usermod -aG docker ubuntu`

* Turn off swap

`sudo swapoff -a`

* Exit and re-login

![Ref](./images/Capture1.PNG)

### 


