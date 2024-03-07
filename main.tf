provider "aws" { 
  region = var.region
}


# Generate SSH key pair
resource "tls_private_key" "example_ssh_key" {
  algorithm = "RSA"
  rsa_bits  = 2048
}

# Save the public key to a local file
resource "local_file" "public_key" {
  filename = "${path.module}/public_key.pem"
  content  = tls_private_key.example_ssh_key.public_key_openssh
}

resource "aws_instance" "example" {
  ami         = var.ami-os 
  instance_type = "t2.micro"              
  key_name      = var.key     
  
 
  tags = {
    Name = "example-instance"
  }
}
