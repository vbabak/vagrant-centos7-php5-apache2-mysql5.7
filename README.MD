Vagrant setup: PHP5 + Apache2 + MySQL5.7 on Centos7 box
==========

Setup demo php5 project using Vagrant with Centos-7.
All required software will be installed automatically:
php5,
apache2,
mysql5.7.


## Setup

```
vagrant plugin install vagrant-vbguest
vagrant up

# if there is error /sbin/mount.vboxsf: mounting failed with the error: No such device
# make next steps:
# 1. get into the box
vagrant ssh
# 2. run yum install
sudo yum -y install kernel kernel-devel
# 3. exit
exit
# 4. reload the box
vagrant reload
```

## Edit your local hosts file

```
sudo nano /etc/hosts
```

and add line

```
127.0.0.1 phptest
```

## That's it!

Open in your browser

```
http://phptest:8080
```
## Make modification

By default code inside ./phptest is running

### Change project configuration

#### Apache2 settings

```
Modify configs/apache
```

#### MySQL settings

```
Modify configs/mysql
```

#### PHP settings

```
Modify configs/php
```
