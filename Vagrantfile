# -*- mode: ruby -*-
# vi: set ft=ruby :

# vagrant plugin install vagrant-vbguest
Vagrant.configure("2") do |config|
  
  config.vm.box = "bento/centos-7" # recommended by Hashicorp
  config.vm.box_check_update = true

  config.vm.network "forwarded_port", guest: 80, host: 8080
  config.vm.network "forwarded_port", guest: 3306, host: 3306

  # config.vm.network "private_network", ip: "192.168.33.10"

  # fix mesg: ttyname failed: Inappropriate ioctl for device
  config.ssh.shell = "bash -c 'BASH_ENV=/etc/profile exec bash'"

  config.vm.synced_folder "./", "/var/www/vagrant", id: "vagrant-root", owner: "vagrant", group: "vagrant", mount_options: ["dmode=777,fmode=777"]

  # restart services after files are mount to apply configuration
  config.vm.provision :shell, path: "./configs/bootstrap.sh", run: 'always'

  config.vm.provider "virtualbox" do |vb|
      vb.memory = "1024"
  	  vb.cpus = 2
  end

  config.vm.provision "shell", inline: <<-SHELL
    yum update -y
    yum install -y ca-certificates \
    nano \
    httpd \
    wget \
    curl \
    php \
    php-devel \
    php-pear \
    php-mbstring \
    php-gd \
    php-imap \
    php-intl \
    php-curl \
    php-mysql \
    php-xml \
    php-cli \
    php-readline \
    php-mcrypt \
    gcc \
    gcc-c++ \
    autoconf \
    automake \
    make \
    sendmail
    pecl install xdebug-2.4.1
    wget https://dev.mysql.com/get/mysql57-community-release-el7-9.noarch.rpm
    rpm -ivh mysql57-community-release-el7-9.noarch.rpm
    yum install -y mysql-server
    systemctl start mysqld
    # MY_TMP_ROOT_PWD=$(grep 'temporary password' /var/log/mysqld.log | grep -o '[:] \(.\+\)$' | grep -o '[^: ]\(.*\)')
    # MY_TMP_ROOT_PWD=$(grep -oP 'temporary password .*: \K(.*)' )
    MY_TMP_ROOT_PWD=$(cat /var/log/mysqld.log | egrep 'temporary password (.*)')
    stringarray=($MY_TMP_ROOT_PWD)
    MY_TMP_ROOT_PWD=$(echo ${stringarray[${#stringarray[@]}-1]})
    echo "mysql root temporary password: $MY_TMP_ROOT_PWD"
    # # MY_NEW_ROOT_PWD=$(openssl rand -base64 10)
    MY_NEW_ROOT_PWD='7gWACinkOayaHA=='
    mysqladmin -u root -p"$MY_TMP_ROOT_PWD" password "$MY_NEW_ROOT_PWD"
    # mysql -u root -p"$MY_NEW_ROOT_PWD" -e 'uninstall plugin validate_password;'
    mysql -u root -p"$MY_NEW_ROOT_PWD" -e "GRANT ALL privileges ON *.* TO 'root'@'%' IDENTIFIED BY '$MY_NEW_ROOT_PWD';"
    # mysql_secure_installation
    echo "mysql new root password: $MY_NEW_ROOT_PWD"
    ln -s /var/www/vagrant/configs/php/php.projects.ini /etc/php.d/php.projects.ini
    ln -s /var/www/vagrant/configs/mysql/mysql.projects.conf /etc/my.cnf.d/mysql.projects.conf
    ln -s /var/www/vagrant/configs/apache/apache.projects.conf /etc/httpd/conf.d/apache.projects.conf
    systemctl restart httpd
    systemctl restart mysqld
  SHELL
end
