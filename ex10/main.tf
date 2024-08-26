provider "aws" {
  #alias = "dev"
  region  = "us-east-1"
  profile = "aws-b1-d1"
}


# Create a key pair
resource "tls_private_key" "example_key" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "aws_key_pair" "generated_key" {
  key_name   = "key1"
  public_key = tls_private_key.example_key.public_key_openssh
}

resource "aws_key_pair" "generated_key2" {
  key_name   = "key2"
  public_key = "ssh-rsa AAAAB3NzaC1yc2EAAAADAQABAAABgQDPXnCMxKETYtAGriigIJ4fULx53hw4Ahej2H3FQ9Afze4B0vMy/ODxBYCM4juvNrXp/q49A38zxfCc0EPF9FK7ucLt9w4f2rMdGUBtU9LjGoA1vjfJltiTG+8F1ltL710GbldH7TiGVsbj2fH3lz+OPXVduqDR5tzHB/7DbLx6QtpFNDZo1BLUVPgC1AF9HHbQ7suguXhT9yFhN1zai026N2yVoBpE6Z6qxffKWcxFKpW7hD14fH/8a0pB5U8fiH30ApTpFvlATPJiDOe2st45jyVBbWJ4L51ahuMrbaWMVJ3nzbldhqCA5/ZqCfQeWpI2mNFWwoAVYlwOhKhq5eEkc6KOgFfRbe4a2O0n8WfO0Z3hOLP818p4VY/+7kimSRJrERbNk8TRmpqQDd87CGf1hNEEx+lOA91bytkdTX8V/xuYCQHkv++8BJjovgYHR+PnXopzZP5p80Ffv974MpnG97+1EmoRwxocDCNeyVDQ0jxw1VLDxsg2CLxZQCN2LMk= admin@DESKTOP-O7MI7ID"
}

# Create an EC2 instance
resource "aws_instance" "example_instance" {
  ami           = "ami-0ae8f15ae66fe8cda" # Replace with your desired AMI
  instance_type = "t2.micro"

  key_name = aws_key_pair.generated_key.key_name
  #security_groups = [aws_security_group.sg["sg1"].name, aws_security_group.sg["sg2"].name]

    # Use vpc_security_group_ids instead of security_groups
  vpc_security_group_ids = [
    aws_security_group.sg["sg1"].id,
    aws_security_group.sg["sg2"].id
  ]
  tags = {
    Name = "ExampleInstance"
  }
}


resource "aws_security_group" "sg" {
  for_each = var.security_groups

  name        = each.value["name"]
  description = each.value["description"]
  vpc_id      = "vpc-0953e0114c7d0c5c1"

  dynamic "ingress" {
    for_each = each.value["ingress"]
    content {
      from_port   = ingress.value[0]
      to_port     = ingress.value[1]
      protocol    = ingress.value[2]
      cidr_blocks = ingress.value[3]
    }
  }

  dynamic "egress" {
    for_each = each.value["egress"]
    content {
      from_port   = egress.value[0]
      to_port     = egress.value[1]
      protocol    = egress.value[2]
      cidr_blocks = egress.value[3]
    }
  }

  tags = {
    Name = each.value["name"]
  }
}

# Save the private key to a local file
resource "local_file" "private_key" {
  content  = tls_private_key.example_key.private_key_pem
  filename = "${path.module}/key1.pem"
}

output "private_key_path" {
  value = "${path.module}/key1.pem"
}

output "public_key" {
  value = tls_private_key.example_key.public_key_openssh
}

output "instance_public_ip" {
  value = aws_instance.example_instance.public_ip
}