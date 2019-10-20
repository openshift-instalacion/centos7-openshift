#!/bin/bash

mkdir -p /etc/origin/master/
touch /etc/origin/master/htpasswd
## variables predeterminadas
## para su usabilidad

## clonar openshift-ansible 3.11

[ ! -d openshift-ansible ] && git clone https://github.com/openshift/openshift-ansible.git -b release-3.11 --depth=1

## levantamiento del OKD
## usando el inventory.ini
ansible-playbook -i inventory.ini openshift-ansible/playbooks/prerequisites.yml
ansible-playbook -i inventory.ini openshift-ansible/playbooks/deploy_cluster.yml

#Creacion del usuario y Contraseña 
#con htpasswd
htpasswd -b /etc/origin/master/htpasswd admin admin123

## creaciones de roles para el usuario, admin
oc adm policy add-cluster-role-to-user cluster-admin admin
