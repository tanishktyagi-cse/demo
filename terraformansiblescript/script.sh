#!/bin/bash

echo "Changing Directory to Terraform/EC2 Directory"
cd /home/tanishq/terraform
sleep 2
echo "Files Updated! Ready to Initialize Terraform"
terraform init
echo "See the Changes"
terraform plan
sleep 2
terraform apply -auto-approve
echo "Configuration File will be open Shortly"
sleep 5

echo "IP-Address Stored in Variable in Back-End"
ubuntu_instance_1_ip=$(terraform output -raw instance_ip_addr)
#ubuntu_instance_2_ip=$(terraform output -raw instance_ip_addr_1)
#aws_linux_instance_ip=$(terraform output -raw instance_ip_addr_2)
echo "Performing Ansible Tasks now press 1 to continuee..."
read resp
if [ $resp == 1 ];
then
	cd ansible
	echo "Change Dir to Ansible now creating inventory file"
	cat > inventory << EOF
[ubuntu]
ubuntu_instance_1 ansible_host=$ubuntu_instance_1_ip
#ubuntu_instance_2 ansible_host=$ubuntu_instance_2_ip
#[aws_linux]
#aws_linux_instance ansible_host=$aws_linux_instance_ip
EOF
	echo "Working on Playbook"
	sleep 2
	echo "Running Playbook with the inventory"
	ansible-playbook playbook.yml -i inventory
fi
if [ $resp == 1 ];
then
	echo "Task Completed!"
fi

echo "Destroying all the Changes now , I hope you don't mind Press 1 to Destroy"
read resp1
if [ $resp1 == 1 ];
then
	cd ..
	terraform destroy -auto-approve
fi
