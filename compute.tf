resource "aws_key_pair" "my-vpc-key" {
    key_name = var.key-name
    public_key = file("/Users/ramprasad/.ssh/id_rsa.pub")
  
}

resource "aws_instance" "my-vpc-ins" {
    ami = var.ami
    instance_type = var.instance_type
    key_name = aws_key_pair.my-vpc-key.key_name
    subnet_id = aws_subnet.my-vpc-public-subnet.id
    security_groups = [ aws_security_group.my-vpc-sg.id ]

    provisioner "remote-exec" {
        inline = [ "sudo apt update" ]

        connection {
          type = "ssh"
          private_key = file("/Users/ramprasad/.ssh/id_rsa")
          host = self.public_ip
          user = "ubuntu"
        }
      
    }
  
}