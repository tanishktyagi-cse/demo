#!/bin/bash
echo "To install NGINX on your Machine, Press y/n : "
read input
if [ $input == y ];
then
echo "Installing NGINX ..."
echo "Checking your OS"
echo "Fetching... :)"

if [ `uname -a | grep Ubuntu`=='Ubuntu' ] || [`uname -a | grep Debian`=='Debian'];
then
	sudo apt update
	sudo apt install nginx
elif [ `uname -a | grep Red`=='Red' ] || [`uname -a | grep Fedora`=='Fedora' ] || [`uname -a | grep CentOs`=='CentOs' ];
then
	sudo yum install epel-release
	sudo yum update
	sudo yum install nginx
else
	sudo pacman -Syu
	sudo pacman -S nginx
fi
fi
if [ $input ==y ];
then
	echo "Installation Completed. Enjoy Nginx ;)"
else
	echo "Not Installed."
fi

