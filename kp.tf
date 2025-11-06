#### step create the key pair
resource "aws_key_pair" "demokpp" {
  key_name   = "dempkpp"
  public_key = file("${path.module}/id_rsa.pub")
}


