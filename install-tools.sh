#!/bin/bash

## variables predeterminadas
## para su usabilidad

# Instalar Actualizaciones 

yum update -y

# instalacion de  los siguientes paquetes base
#
yum install -y  wget git zile nano net-tools docker-1.13.1\
				bind-utils iptables-services \
				bridge-utils bash-completion \
				kexec-tools sos psacct openssl-devel \
				httpd-tools NetworkManager \
				python-cryptography python2-pip python-devel  python-passlib \
				java-1.8.0-openjdk-headless "@Development Tools"

# iniciar docker
systemctl enable --now docker

#instalacion de  epel
yum -y install epel-release

# Deshabilite el repositorio EPEL a nivel mundial para que no se use 
#accidentalmente durante los pasos posteriores de la instalación

sed -i -e "s/^enabled=1/enabled=0/" /etc/yum.repos.d/epel.repo

systemctl | grep "NetworkManager.*running" 
if [ $? -eq 1 ]; then
	systemctl start NetworkManager
	systemctl enable NetworkManager
fi

# instalar los paquetes para Ansible
yum -y --enablerepo=epel install pyOpenSSL

#curl -o ansible.rpm https://releases.ansible.com/ansible/rpm/release/epel-7-x86_64/ansible-2.6.5-1.el7.ans.noarch.rpm
#yum -y --enablerepo=epel install ansible.rpm
#yum -y --enablerepo=epel install https://releases.ansible.com/ansible/rpm/release/epel-7-x86_64/ansible-2.6.5-1.el7.ans.noarch.rpm
##
# instalacion de Ansible
yum -y --enablerepo=epel install https://releases.ansible.com/ansible/rpm/release/epel-7-x86_64/ansible-2.8.3-1.el7.ans.noarch.rpm
