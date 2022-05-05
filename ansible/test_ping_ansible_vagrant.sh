#!/bin/bash

ansible -i ../.vagrant/provisioners/ansible/inventory/vagrant_ansible_inventory -m ping all
