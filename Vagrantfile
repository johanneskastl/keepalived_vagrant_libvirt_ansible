# -*- mode: ruby -*-
# vi: set ft=ruby :

Vagrant.configure("2") do |config|

  ###################################################################################
  # define number of keepalived nodes
  K = 2

  # provision W VMs as nodes
  (1..K).each do |i|

    # name the VMs
    config.vm.define "keepalived#{i}" do |node|

      # which image to use
      node.vm.box = "opensuse/Leap-15.3.x86_64"
      ### to use SLES15 SP3: uncomment this and comment the previous line
      ### node.vm.box = "SLE15-SP3"
      ### node.vm.box_check_update = false

      # sizing of the VMs
      node.vm.provider "libvirt" do |lv|
        lv.random_hostname = false
        lv.memory = 2048
        lv.cpus = 2
      end

      # set the hostname
      node.vm.hostname = "keepalived#{i}"

      # if this is the last machine
      if i == K

        #################################################
        # only target one node to not run ansible twice
        # but do not limit this to this node (set ansible.limit to all)
        node.vm.provision "ansible" do |ansible|
          ansible.compatibility_mode = "2.0"
          ansible.limit = "all"
          ansible.groups = {
            "keepalived_nodes"  => [ "keepalived1", "keepalived2" ],
          }
          ansible.playbook = "ansible/playbook-vagrant.yml"

        end # node.vm.provision
      end # if-condition last machine
    end # config.vm.define nodes
  end # each-loop over all VMs
end
