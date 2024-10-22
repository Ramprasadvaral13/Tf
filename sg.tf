resource "aws_security_group" "my-vpc-sg" {
    vpc_id = aws_vpc.my-vpc.id
    name = "my-sg"
    description = "my-sg"

    ingress{
        cidr_blocks = [ "0.0.0.0/0" ]
        from_port = 22
        to_port = 22
        protocol = "tcp"
    }

    egress{
        cidr_blocks = [ "0.0.0.0/0" ]
        from_port = 0
        to_port = 0
        protocol = "-1"
    }
  
}