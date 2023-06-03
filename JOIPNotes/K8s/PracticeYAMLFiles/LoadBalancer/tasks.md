1. Nginx rs with label app: web-server, os: nginx
2. websrv-svc load balancer pointing web-server
observe the ip address page if its loading nginx page
3. apache2 rs with label app: web-server, os: apache
4. delete nginx-rs 
observe the ip address page if its loading apache page
