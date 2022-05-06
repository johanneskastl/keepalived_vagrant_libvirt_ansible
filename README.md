# keepalived_vagrant_libvirt_ansible

This Vagrant setup creates all that you need to start playing with [keepalived](https://www.keepalived.org/). This means we have two VMs running keepalived and nginx.

Default OS is openSUSE Leap 15.3, but that can be changed in the Vagrantfile. Changing this to SLES15 SP3 is pretty easy, see the instructions below.

Please beware, changing the operating system might break the ansible provisioning which was only tested with openSUSE Leap 15.3 and SLES15 SP3.

## Scenarios

There are two example scenarios that this Vagrant setup can ...ahem... set up for you:

- two nodes with webservers, where keepalived manages 1 virtual IP (with keepalived1 being the MASTER)
- two nodes with webservers, where keepalived manages 2 virtual IPs (where each node is MASTER for one IP and BACKUP for the other

By default, the setup creates the second scenario by using the playbook `playbook-vagrant-keepalived.yml`. If you want to use the scenario with only one virtual IP, you can either 

- manually run `ansible-playbook playbook-vagrant-keepalived-one_virtual_IP.yml` after `vagrant up` or
- change the `import_playbook` line in `playbook-vagrant.yml` to use the playbook `playbook-vagrant-keepalived-one_virtual_IP.yml`. Instructions on how to do that are included as comments in the `playbook-vagrant.yml` playbook.

## Vagrant

### Vagrant using openSUSE Leap 15.3

1. You need vagrant obviously. And ansible. And git...
2. Fetch the box, per default this is `opensuse/Leap-15.3.x86_64`, using `vagrant box add opensuse/Leap-15.3.x86_64`.
3. Make sure the git submodules are fully working by issuing `git submodule init && git submodule update`
4. Run `vagrant up`
5. Do something with keepalived...
6. Party!

### Vagrant using SLES15 SP3

You can try this setup on SLES15 SP3, but of course you need to have the proper registration keys for both a normal SLES server and for the HA extension (that is needed for keepalived).

1. You need vagrant obviously. And ansible. And git...
2. Fetch the box from [Suse](https://www.suse.com/download/sles/) by following the instructions on the page (TL;DR: download, `vagrant box add --name SLE15-SP3 SLE*Vagrant*.box`, done)
3. Make sure the git submodules are fully working by issuing `git submodule init && git submodule update`
4. Create a file `ansible/group_vars/all/SUSE_LICENSE_KEY.yml` containing a variable called `suse_license_key`, set to your SUSE SLES registration key. The file is ignored by git and will not get commited (unless you do something stupid...)
5. Add another variable `suse_ha_license_key` to the file `ansible/group_vars/all/SUSE_LICENSE_KEY.yml`, this time this is the registration code for the SUSE HA extension (which is needed for keepalived)
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
            "keepalived_nodes"  => [ "keepalived1", "keepalived2" ],
          }
          ansible.playbook = "ansible/playbook-vagrant.yml"

        end # node.vm.provision
```
