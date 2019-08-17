#!/usr/bin/env bash

yum install -y -q epel-release

yum -y -q install java-openjdk-devel java-openjdk
java -version

### Elasticsearch
cat <<EOF | tee /etc/yum.repos.d/elasticsearch.repo
[elasticsearch-7.x]
name=Elasticsearch repository for 7.x packages
baseurl=https://artifacts.elastic.co/packages/7.x/yum
gpgcheck=1
gpgkey=https://artifacts.elastic.co/GPG-KEY-elasticsearch
enabled=1
autorefresh=1
type=rpm-md
EOF

rpm --import https://artifacts.elastic.co/GPG-KEY-elasticsearch

yum -q clean all
yum -q makecache
yum -y -q install elasticsearch
sed -i 's/^-Xms.*$/-Xms512m/g' /etc/elasticsearch/jvm.options
sed -i 's/^-Xmx.*$/-Xmx512m/g' /etc/elasticsearch/jvm.options

### Kibana
yum -y -q install kibana
cat <<EOF | tee /etc/kibana/kibana.yml
server.host: "0.0.0.0"
server.name: "lesson14elk"
EOF

### Logstash
yum -y -q install logstash
sed -i 's/^-Xms.*$/-Xms512m/g' /etc/logstash/jvm.options
sed -i 's/^-Xmx.*$/-Xmx512m/g' /etc/logstash/jvm.options
cp /vagrant/logstash.conf /etc/logstash/conf.d/logstash.conf

# Run services
systemctl daemon-reload
systemctl enable --now elasticsearch
systemctl enable --now kibana
systemctl enable --now logstash
