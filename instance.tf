

resource "aws_instance" "example" {

  ami                    = data.aws_ami.ubuntu.id
  instance_type          = var.instance_type
  subnet_id              = module.vpc.public_subnets[0] # Use the public subnets from the VPC module
  vpc_security_group_ids = [aws_security_group.allow_ssh.id]
  tags = {
    Name = "example"
  }
}
resource "aws_security_group" "allow_ssh" {
  name        = "allow_ssh"
  description = "Allow SSH inbound traffic and all outbound traffic"
  vpc_id      = module.vpc.vpc_id


  ingress {
    from_port        = 22
    to_port          = 22
    protocol         = "tcp"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  egress {
    from_port        = 0
    to_port          = 0
    protocol         = "-1"
    cidr_blocks      = ["0.0.0.0/0"]
    ipv6_cidr_blocks = ["::/0"]
  }

  tags = {
    Name = "allow_ssh"
  }
}


