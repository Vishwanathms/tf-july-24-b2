provider "aws" {
  #alias = "dev"
  region  = "us-east-1"
  profile = "specnet-tf-aug-vms"
}

data "aws_vpc" "myvpc" {
  filter {
    name = "tag:Name"
    values = ["default"]
  }
}



# Create a key pair
resource "tls_private_key" "example_key" {
  algorithm = "RSA"
  rsa_bits  = 4096
}

resource "aws_key_pair" "generated_key" {
  key_name   = "key-26-aug"
  public_key = tls_private_key.example_key.public_key_openssh
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

resource "aws_ebs_volume" "example" {
  availability_zone = aws_instance.example_instance.availability_zone
  size              = 1 # Size in GiB
  tags = {
    Name = "example-ebs-volume"
  }
}

resource "aws_volume_attachment" "example" {
  device_name = "/dev/sdf" # Device name for the volume attachment,  value sdf-sdp
  volume_id   = aws_ebs_volume.example.id
  instance_id = aws_instance.example_instance.id

  # Set to true to force-detach on instance termination (optional)
  force_detach = true
}


resource "aws_security_group" "sg" {
  for_each = var.security_groups

  name        = each.value["name"]
  description = each.value["description"]
  #vpc_id      = "vpc-02cb444184d7b66e2"
  vpc_id      = data.aws_vpc.myvpc.id
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

resource "null_resource" "installonec2" {

  triggers = {
    always_run = "${timestamp()}" 
  }

  provisioner "remote-exec" {
    inline = [ 
      "echo -e 'n\np\n1\n\n\nw' | sudo fdisk /dev/xvdf",
      "sudo mkfs -t ext4 /dev/xvdf1",
      "sudo mkdir -p /mnt/ed01",
      "sudo mount /dev/xvdf1 /mnt/ed01",
      "sudo chmod 777 /mnt/ed01",
      "sudo echo 'test file1' >> /mnt/ed01/file1.txt"
     
     ]
  }
  
  connection {
    host = aws_instance.example_instance.public_ip
    user = "ec2-user"
    #private_key = file("./key1.pem")
    private_key = file(local_file.private_key.filename)
    #password = 
    type = "ssh"     
  }

  depends_on = [ aws_volume_attachment.example, local_file.private_key ]
  
}

resource "null_resource" "local" {

  provisioner "local-exec" {
    command = "echo 'Sample file testing' > ./file2.txt"
  }

}

resource "null_resource" "file-transfer" {

  provisioner "file" {
    source = "./file2.txt"
    destination = "/home/ec2-user/file2.txt"
  }

  connection {
    host = aws_instance.example_instance.public_ip
    user = "ec2-user"
    #private_key = file("./key1.pem")
    private_key = file(local_file.private_key.filename)
    #password = 
    type = "ssh"     
  }
  depends_on = [ null_resource.local ]
}

# Save the private key to a local file
resource "local_file" "private_key" {
  content  = tls_private_key.example_key.private_key_pem
  filename = "${path.module}/key-26-aug.pem"
}

output "private_key_path" {
  value = "${path.module}/key-26-aug.pem"
}

output "public_key" {
  value = tls_private_key.example_key.public_key_openssh
}

output "instance_public_ip" {
  value = aws_instance.example_instance.public_ip
}