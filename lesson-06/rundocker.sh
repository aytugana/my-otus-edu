#!/bin/bash

docker run -d --rm --name myrepo -p 8080:80 -v /root/rpmbuild/RPMS/x86_64:/var/www/html -v /vagrant/default.conf:/etc/nginx/conf.d/default.conf nginx
curl http://localhost:8080/
echo -e "\nHOMEWORK 6 IS TOTALLY DONE !!!\n"
