#!/bin/bash
echo "To install NGINX on your Machine, Press 1 : "
read input
if [ $input == 1 ];
then
echo "Installing NGINX ..."
echo "Checking your OS"
echo "Fetching... :)"
if [ `cat /etc/os-release | grep ^NAME | grep Ubuntu`=='Ubuntu' ] || [ `cat /etc/os-release | grep ^NAME | grep Debian`=='Debian' ];
then
	sudo apt update
	sudo apt install nginx
elif [`cat /etc/os-release | grep ^NAME | grep Red`=='Red' ] || [ `cat /etc/os-release | grep ^NAME | grep CentOS`=='CentOS' ] || [ `cat /etc/os-release | grep ^NAME | grep Fedora`=='Fedora' ];
then
	sudo yum install epel-release
	sudo yum update
	sudo yum install nginx
else
	sudo pacman -Syu
	sudo pacman -S nginx
fi
fi
if [ $input == 1 ];
then
	echo "Installation Completed. Enjoy Nginx ;)"
else
	echo "Not Installed."
fi

