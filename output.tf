output "public_ip" {
  value = aws_instance.example.public_ip // Output the public IP of the instance

}

output "public_subnets" {
  value = module.vpc.public_subnets // Output the public subnet IDs from the VPC module
}