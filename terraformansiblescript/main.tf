resource "aws_instance" "ubuntu-1" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = "t2.micro"
  key_name      = "awskey1"
  vpc_security_group_ids = [aws_security_group.nginx.id]
  provisioner "remote-exec"{
  inline = ["SSH ubuntu-1"]
  connection {
    type = "ssh"
    user = "ubuntu"
    private_key = file("/home/tanishq/Downloads/awskey1.pem")
    host=aws_instance.ubuntu-1.public_ip
  }
}
}
resource "aws_instance" "ubuntu-2" {
  ami           = data.aws_ami.ubuntu.id
  instance_type = "t2.micro"
  key_name     = "awskey1"
  provisioner "remote-exec" {
  inline = ["SSH ubuntu-2"]
  connection {
    type = "ssh"
    user = "ubuntu"
    private_key = file("/home/tanishq/Downloads/awskey1.pem")
    host=aws_instance.ubuntu-2.public_ip
    }
  }
}
resource "aws_instance" "aws-linux" {
  ami           = data.aws_ami.aws_linux.id
  instance_type = "t2.micro"
  key_name   = "awskey1"
  provisioner "remote-exec" {
  inline = ["SSH aws-linux"]
  connection {
    type = "ssh"
    user = "ec2-user"
    private_key = file("/home/tanishq/Downloads/awskey1.pem")
    host=aws_instance.aws-linux.public_ip
    }
  }
}

resource "aws_security_group" "nginx" {
  name        = "allow_ssh"
  description = "Allow SSH inbound traffic"
  vpc_id      = aws_default_vpc.default.id

  ingress {
    description      = "ssh"
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }
  
  ingress {
    description      = "nginx"
    from_port        = 80
    to_port          = 80
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "Allow SSH"
  }
}
resource "aws_default_vpc" "default"{
  tags = {
    Name = "Default VPC"
  }
}

output "instance_ip_addr" {
  value = aws_instance.ubuntu-1.public_ip
}
