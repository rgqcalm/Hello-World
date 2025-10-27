##### step create the virtual machine


### create the vpc 
resource "aws_vpc" "myvpc" {
  cidr_block = "10.0.0.0/16"
  tags       = { Name = "myvpc" }
}

### creation of subnet 
resource "aws_subnet" "mysubnet" {
  vpc_id            = aws_vpc.myvpc.id
  cidr_block        = "10.0.1.0/24"
  availability_zone = "us-east-1a"
  tags              = { Name = "Main" }
}

#### creation of ig 
resource "aws_internet_gateway" "myig" {
  vpc_id = aws_vpc.myvpc.id
  tags   = { Name = "MyIg" }
}

### creation of route table 
resource "aws_route_table" "myrt" {
  vpc_id = aws_vpc.myvpc.id
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.myig.id
  }
  route {
    ipv6_cidr_block = "::/0"
    gateway_id      = aws_internet_gateway.myig.id
  }
  tags = { Name = "MYRT" }
}

### subnet assoication 
resource "aws_route_table_association" "a" {
  subnet_id      = aws_subnet.mysubnet.id
  route_table_id = aws_route_table.myrt.id
}
#### step create the key pair 
resource "aws_key_pair" "demokpp" {
  key_name   = "dempkpp"
  public_key = file("${path.module}/id_rsa.pub")
}

#### step create the security group 
resource "aws_security_group" "demosg" {
  vpc_id      = aws_vpc.myvpc.id
  name        = "websgtest"
  description = "provide the sg"
  dynamic "ingress" {
    for_each = [22, 3389, 80]
    iterator = port

    content {
      from_port   = port.value
      to_port     = port.value
      description = "port 22 enable"
      protocol    = "tcp"
      cidr_blocks = ["0.0.0.0/0"]
    }
  }
  egress {
    from_port   = "0"
    to_port     = "0"
    description = "port all enable"
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }
}

resource "aws_eip" "myeip" {
  instance   = aws_instance.web.id
  depends_on = [aws_internet_gateway.myig]
}


##### step create the virtual machine 
resource "aws_instance" "web" {
  ami                    = "ami-0360c520857e3138f"
  key_name               = aws_key_pair.demokpp.key_name
  vpc_security_group_ids = ["${aws_security_group.demosg.id}"]
  instance_type          = "t3.micro"
  user_data              = file("${path.module}/script.sh")
  subnet_id              = aws_subnet.mysubnet.id
  availability_zone      = "us-east-1a"
  tags                   = { Name = "NewVMRJOct25" }
}

