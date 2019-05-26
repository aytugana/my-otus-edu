#!/bin/bash

yumdownloader --source mc --destdir /root
rpm -i /root/mc-4.8.7-11.el7.src.rpm
patch /root/rpmbuild/SPECS/mc.spec < /vagrant/my_mc_spec.patch
yum-builddep -y /root/rpmbuild/SPECS/mc.spec
cp /vagrant/darkfar.patch /root/rpmbuild/SOURCES/
rpmbuild -bb /root/rpmbuild/SPECS/mc.spec
createrepo /root/rpmbuild/RPMS/x86_64
echo "RPM --- DONE !!!"
