terraform {
  required_providers {
    aws = {
      source  = "hashicorp/aws"
      version = "4.18.0"
    }
  }
}
provider "aws" {
  shared_config_files      = ["/Users/ankitshukla/.aws/config"]
  shared_credentials_files = ["/Users/ankitshukla/.aws/credentials"]
  #profile                  = "customprofile"
}

resource "aws_vpc" demovpc {
  #vpc_id= aws_vpc.demovpc.id
  cidr_block = var.vpc_cidr
  enable_dns_support = var.dnsSupport
  enable_dns_hostnames = var.dnsHostNames
  tags = {
    "Name" = "VPCTEST"
  }

} 
resource "aws_subnet" public1 {
    vpc_id= aws_vpc.demovpc.id
    cidr_block = var.pubsubnet1
    availability_zone = "ap-south-1a"
    tags = {
    "Name" = "public1"
  }
      
  }
resource "aws_subnet" public2 {
    vpc_id= aws_vpc.demovpc.id
    cidr_block = var.pubsubnet2
    availability_zone = "ap-south-1b"
    tags = {
    "Name" = "public2"
  }
      
  }
resource "aws_subnet" private1 {
     vpc_id = aws_vpc.demovpc.id
     cidr_block = var.prisubnet1
     availability_zone = "ap-south-1a"
     tags = {
    "Name" = "private2"
  }
} 
resource "aws_subnet" private2 {
     vpc_id = aws_vpc.demovpc.id
     cidr_block = var.prisubnet2
     availability_zone = "ap-south-1b"
     tags = {
    "Name" = "private2"
  }
}   
resource "aws_route_table" "RTPublic" {
  vpc_id = aws_vpc.demovpc.id
  tags = {
    "Name" = "PublicRT"
  }
  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igwnew.id
  }

}
resource "aws_route_table_association" "RTPublic" {
  subnet_id = aws_subnet.public1.id
  route_table_id = aws_route_table.RTPublic.id
}
resource "aws_route_table" "RTPrivate" {
  vpc_id = aws_vpc.demovpc.id
  tags = {
    "Name" = "RTPrivate"
  }
  route {
    cidr_block= "0.0.0.0/0"
    nat_gateway_id= aws_nat_gateway.ngw.id

  }
}
resource "aws_route_table_association" "RTPrivate" {
  subnet_id = aws_subnet.private1.id
  route_table_id = aws_route_table.RTPrivate.id
}
resource "aws_internet_gateway" "igwnew" {
  tags = {
    "Name" = "IGWTEST"
  }
}
resource "aws_internet_gateway_attachment" "igwnew" {
      internet_gateway_id= aws_internet_gateway.igwnew.id
      vpc_id=aws_vpc.demovpc.id
}
resource "aws_eip" "nat_gatewayeip" {
  vpc = true
}

resource "aws_nat_gateway" "ngw" {
      allocation_id= aws_eip.nat_gatewayeip.id
      subnet_id= aws_subnet.public1.id
      tags = {
    "Name" = "NG"
  }
   
}