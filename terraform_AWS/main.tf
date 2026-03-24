provider "aws" {
  region = "ap-south-1"
}

resource "aws_vpc" "vpc" {
    cidr_block = var.cidr_block
    tags = {
        Name = var.vpc_name
    }  
}

resource "aws_subnet" "public" {
    vpc_id = aws_vpc.vpc.id
    cidr_block = var.public_subnet_cidr
    availability_zone = var.public_subnet_az
    map_public_ip_on_launch = true
    tags = {
        Name = var.public_subnet_name
    }
}

resource "aws_subnet" "private1"{
    vpc_id = aws_vpc.vpc.id
    cidr_block = var.private_subnet1_cidr
    availability_zone = var.private1_subnet_az
    tags = {
        Name = var.private1_subnet_name
    }
}

resource "aws_subnet" "private2"{
    vpc_id = aws_vpc.vpc.id
    cidr_block = var.private_subnet2_cidr
    availability_zone = var.private2_subnet_az
    tags = {
        Name = var.private2_subnet_name
    }
}

resource "aws_internet_gateway" "igw" {
    vpc_id = aws_vpc.vpc.id
    tags = {
        Name = var.igw_name
    }
}

resource "aws_route_table" "rt" {
  vpc_id = aws_vpc.vpc.id

  route {
    cidr_block = "0.0.0.0/0"
    gateway_id = aws_internet_gateway.igw.id
  }


  tags = {
    Name = var.route_table_name
  }
}

resource "aws_route_table_association" "a" {
  subnet_id      = aws_subnet.public.id
  route_table_id = aws_route_table.rt.id
}

resource "aws_security_group" "web_sg" {
  vpc_id = aws_vpc.vpc.id
  name   = var.security_group_name

  ingress {
    from_port   = 22
    to_port     = 22
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }


  ingress {
    from_port   = 80
    to_port     = 80
    protocol    = "tcp"
    cidr_blocks = ["0.0.0.0/0"]
  }

  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
  }

  tags = {
    Name = "allow-ssh-http"
  }
}

resource "aws_security_group" "rds_sg" {
  vpc_id = aws_vpc.vpc.id
  name   = var.rds_security_group_name

  ingress {
    from_port   = 3306
    to_port     = 3306
    protocol    = "tcp"
    security_groups = [aws_security_group.web_sg.id]
}
  
  egress {
    from_port   = 0
    to_port     = 0
    protocol    = "-1"
    cidr_blocks = ["0.0.0.0/0"]
}
}

resource "aws_db_subnet_group" "rds_subnet_group" {
  name       = var.rds-subnet-group
  subnet_ids = [aws_subnet.private1.id,aws_subnet.private2.id]

  tags = {
    Name = "RDS Subnet Group"
  }
}


resource "aws_db_instance" "rds_mysql" {
  identifier              = "epicbook-db"
  allocated_storage       = 20
  engine                  = "mysql"
  engine_version          = "8.0"
  instance_class          = "db.t3.micro"
  username                = var.rds_username
  password                = var.rds_password
  db_subnet_group_name    = aws_db_subnet_group.rds_subnet_group.name
  vpc_security_group_ids  = [aws_security_group.rds_sg.id]
  skip_final_snapshot     = true
  publicly_accessible     = false
}

resource "aws_instance" "public_vm" {
  ami                         = var.ami 
  instance_type               = var.instance_type
  subnet_id                   = aws_subnet.public.id
  vpc_security_group_ids      = [aws_security_group.web_sg.id]
  associate_public_ip_address = true
  key_name                    = var.keypair_name

  tags = {
    Name = "shubham-public-vm"
  }
}


