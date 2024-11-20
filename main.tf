terraform {
  required_providers {
    aws = {
      source = "hashicorp/aws"
      version = "5.76.0"
    }
  }
}

provider "aws" {
  region = "ap-northeast-2"
}

data "aws_availability_zones" "available" {
  state = "available"
}

variable pjt_name {
  type        = string
  default     = "netid"
}

module "vpc" {
  source = "./vpc"
  pjt_name = var.pjt_name
  vpc_cidr_block = "10.0.0.0/16"
}

module "pub_sn_1" {
  source = "./subnet"
  pjt_name = var.pjt_name
  vpc_id = module.vpc.vpc_id
  sn_cidr_block = "10.0.1.0/24"
  az_name = data.aws_availability_zones.available.names[0]
}

module "pub_sn_2" {
  source = "./subnet"
  pjt_name = var.pjt_name
  vpc_id = module.vpc.vpc_id
  sn_cidr_block = "10.0.2.0/24"
  az_name = data.aws_availability_zones.available.names[2]
}

module "pub_rt" {
  source = "./route_table"
  pjt_name = var.pjt_name
  vpc_id = module.vpc.vpc_id
  igw_id = module.vpc.igw_id
  sn_ids = {
    sn1 = module.pub_sn_1.sn_id
    sn2 = module.pub_sn_2.sn_id
  }
}

