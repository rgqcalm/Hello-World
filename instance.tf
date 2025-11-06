
##### step create the virtual machine
resource "aws_instance" "web" {
  ami                         = "ami-043cc489b5239c3de"
  key_name                    = aws_key_pair.demokpp.key_name
  vpc_security_group_ids      = ["${aws_security_group.demosg.id}"]
  instance_type               = "t3.micro"
  associate_public_ip_address = true
  ####  user_data                   = file("${path.module}/install_iis.ps1")
  user_data = <<-EOF
              <powershell>
              Install-WindowsFeature -Name Web-Server -IncludeManagementTools
              </powershell>
              EOF
  tags = {
    Name = "NewVMWindowsNov01"
  }
}
