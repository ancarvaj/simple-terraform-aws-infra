module "vpc" {
  source = "./aws_modules/vpc"
  cidr = var.vpc_cidr
}

module "igw" {
  source = "./aws_modules/internet_gateway"
  vpc_id = module.vpc.vpc_id
}

module "public_rt" {
  source = "./aws_modules/route_tables"
  vpc_id = module.vpc.vpc_id
  gateway_id = module.igw.igw_id
  cidr = "0.0.0.0/0"
}

module "public_subnet1" {
  source = "./aws_modules/subnets"
  vpc_id = module.vpc.vpc_id
  subnet_cidr = var.subnet1_cidr
  az = var.az1
}

module "private_subnet2" {
  source = "./aws_modules/subnets"
  vpc_id = module.vpc.vpc_id
  subnet_cidr = var.subnet2_cidr
  az = var.az2
}

module "public_rt_assiciation" {
  source = "./aws_modules/rt_association"
  subnet_id = module.public_subnet1.subnet_id
  rt_id = module.public_rt.rt_id
}

module "instance1" {
  source = "./aws_modules/ec2"
  ami = var.ami
  az = var.az1
  subnet_id = module.public_subnet1.subnet_id
  instance_type = var.instance_type
}

module "instance2" {
  source = "./aws_modules/ec2"
  ami = var.ami
  az = var.az2
  subnet_id = module.private_subnet2.subnet_id
  instance_type = var.instance_type
}