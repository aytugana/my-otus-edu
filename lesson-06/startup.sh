#!/bin/bash

mkdir -p ~root/.ssh
cp ~vagrant/.ssh/auth* ~root/.ssh
yum -y install redhat-lsb-core wget rpmdevtools rpm-build createrepo yum-utils gcc
echo "STARTUP --- DONE !!!"
