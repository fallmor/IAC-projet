#!/bin/bash
## Install Ansible
sudo apt update && /
sudo apt install software-properties-common --yes && /
sudo apt-add-repository --update ppa:ansible/ansible --yes && /
sudo apt install ansible --yes && /
ansible --version
