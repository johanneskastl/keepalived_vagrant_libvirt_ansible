# keepalived_vagrant_libvirt_ansible

This Vagrant setup creates all that you need to start playing with [keepalived](https://www.keepalived.org/). This means we have two VMs running keepalived and nginx.

Default OS is openSUSE Leap 15.3, but that can be changed in the Vagrantfile. Please beware, this might break the ansible provisioning which was only tested with openSUSE Leap 15.3.

## Vagrant

1. You need vagrant obviously. And ansible. And git...
2. Fetch the box, per default this is `opensuse/Leap-15.3.x86_64`, using `vagrant box add opensuse/Leap-15.3.x86_64`.
3. Make sure the git submodules are fully working by issuing `git submodule init && git submodule update`
4. Run `vagrant up`
5. Do something with keepalived...
6. Party!

## Disabling the Ansible provisioning

In case you do not want Ansible to install keepalived (because you want to install it yourself), just comment out the following lines in the `Vagrantfile`:
```
        node.vm.provision "ansible" do |ansible|
          ansible.compatibility_mode = "2.0"
          ansible.limit = "all"
          ansible.groups = {
            "keepalived_nodes"  => [ "keepalived1", "keepalived2", "keepalived3" ],
          }
          ansible.playbook = "ansible/playbook-vagrant.yml"

        end # node.vm.provision
```
