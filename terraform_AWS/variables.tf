variable "cidr_block" {
  description = "cidr block address of vpc"
  default = "10.0.0.0/16"
}

variable "public_subnet_cidr" {
  description = "cidr block address of public subnet"
  default = "10.0.1.0/24"
}

variable "private_subnet1_cidr" {
  description = "cidr block address of private subnet 1"
  default = "10.0.2.0/24"
}

variable "private_subnet2_cidr" {
  description = "cidr block address of private subnet 2"
  default = "10.0.3.0/24"
}
variable "public_subnet_az" {
  description = "public subnet availability zone"
  default = "ap-south-1a"
}

variable "private1_subnet_az" {
    description = "private subnet 1 availability zone"
    default = "ap-south-1a"
}

variable "private2_subnet_az" {
  description = "private subnet 2 availability zone"
  default = "ap-south-1b"
}

variable "vpc_name" {
    description = "name of vpc"
    default = "my-vpc"
}

variable "public_subnet_name" {
    description = "name of public subnet"
    default = "public-subnet"
}

variable "private1_subnet_name" {
    description = "name of private subnet 1"
    default = "private-subnet1"
}

variable "private2_subnet_name" {
    description = "name of private subnet 2"
    default = "private-subnet2"
}

variable "igw_name" {
    description = "name of internet gateway"
    default = "shubham-igw"
}

variable "route_table_name" {
    description = "name of route table"
    default = "public-rt"
}

variable "security_group_name" {
    description = "name of the security group"
    default = "web-sg"
}

variable "rds_security_group_name" {
    description = "name of rds security group"
    default = "rds-sg"
}

variable "rds-subnet-group" {
    description = "name of rds subnet group"
    default = "rds-subnet-group"
}

variable "rds_username" {
    description = "username for rds instance"
    default = "admin"
}

variable "rds_password" {
    description = "password of the rds"
    default = "Shubham11"
}

variable "ami" {
    description = "ami id of machine"
    default = "ami-05d2d839d4f73aafb" # Ubuntu 24.04 LTS x86_64 in ap-south-1
  
}
variable "keypair_name" {
    description = "name of the key pair"
    default = "shubhamkeypair_ec2"
}

variable "instance_type" {
    description = "name of instance type"
    default = "t3.micro"
}