# install httpd
read -p "install apache?[y/n]" input
    case $input in
        [yY]*)
        yum install httpd -y
        systemctl enable httpd
        systemctl start httpd
        ;;
esac

# install php
read -p "install php?[y/n]" input

case $input in
    [yY]*)
        echo "pleaase input the version of php that you want to install"
        read -p "simple: install php5.5 that input 55:" version
        yum -y install epel-release
        rpm -Uvh https://mirror.webtatic.com/yum/el7/webtatic-release.rpm
        yum -y install php${version}w php${version}w-cli php${version}w-common php${version}w-gd php${version}w-ldap php${version}w-mbstring php${version}w-mcrypt php${version}w-mysqlnd php${version}w-pdo
        ;;
esac

# install mysql80
read -p "install mysql?[y/n]" input

case $input in
    [yY]*)
        # read -p "please enter your password for MySQL" password

        rm -rf /var/lib/mysql
        cd /opt
        wget https://dev.mysql.com/get/mysql80-community-release-el7-3.noarch.rpm
        yum install ./mysql80-community-release-el7-3.noarch.rpm
        yum install mysql-community-server -y
        echo "the password of root@localhost"
        systemctl start mysqld
        systemctl enable mysqld
        # systemctl stop mysqld
        grep "root@localhost:.*" /var/log/mysqld.log -o
        ;;
    [nN]*)
        echo "will not install mysql."
        ;;
esac
