#!/bin/bash

name="myotus10"

docker build -t $name:latest -<<EOF
FROM alpine:latest
LABEL Description="Моё домашнее задание по docker"
RUN apk add --no-cache nginx && \
    sed -i 's@user nginx;@user nginx;\npid /var/run/nginx.pid;\ndaemon off;@g' /etc/nginx/nginx.conf && \
    sed -i 's/return 404/return 200 "Hello docker world! $name works fine!"/g' /etc/nginx/conf.d/default.conf
ENTRYPOINT ["nginx"]
EXPOSE 80
EOF

#docker run -d --name $name-run -p 8088:80 --rm $name:latest
#echo -e "\n\nTesting nginx: \n"
#curl http://localhost:8088/
#echo -e "\n\nRemoving $name crap:"

#docker stop $name-run
#docker container prune -f
#docker rmi -f $name
docker images ls -a
docker container ls

