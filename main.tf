provider "aws" {
  region = "us-east-1"

}

provider "aws" {
  region = "us-west-1"
  alias  = "west"

}

resource "aws_vpc" "my-vpc" {
  cidr_block = "10.2.0.0/16"
  provider   = aws.west
  

}

resource "aws_subnet" "my-subnet" {
  vpc_id     = aws_vpc.my-vpc.id
  provider   = aws.west
  cidr_block = "10.2.0.0/24"
}

resource "aws_instance" "my-ec2" {
  ami                         = "ami-047d7c33f6e7b4bc4"
  instance_type               = "t2.micro"
  subnet_id                   = aws_subnet.my-subnet.id
  associate_public_ip_address = false
  provider                    = aws.west
}
resource "aws_instance" "my-ec2-2" {
  ami                         = "ami-0ebfd941bbafe70c6"
  instance_type               = "t2.micro"
  associate_public_ip_address = false

}

output "vpc_id" {
  value = aws_vpc.my-vpc.id

}
output "vpc_arn" {
  value = aws_vpc.my-vpc.arn

}
output "private_ip" {
  value = aws_instance.my-ec2.private_ip

}