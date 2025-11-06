#### step create the security group
resource "aws_security_group" "demosg" {
  name        = "demosg"
  description = "provide the sg"
  ingress {
    from_port   = "22"
    to_port     = "22"
    description = "port 22 enable"
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  ingress {
    from_port   = "80"
    to_port     = "80"
    description = "port 22 enable"
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  ingress {
    from_port   = "3389"
    to_port     = "3389"
    description = "port 22 enable"
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }
  egress {
    from_port   = "0"
    to_port     = "0"
    description = "port all enable"
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}