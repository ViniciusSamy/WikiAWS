variable "region" {
  description = "Region in AWS"
  type        = string
  default     = "us-east-1"
}


#------------NETWORK------------#
variable "network_prefix" {
  description = "Prefix used in Name tag of VPCs, Subnets and Gateways"
  type        = string
  default     = "wiki"
}

variable "cidr" {
  description = "CIDR block of VPC"
  type        = map(any)
  default = {
    "vpc" : "192.168.0.0/16",
    "public_subnets" : "192.168.0.0/16",
    "private_subnets" : "192.168.0.0/16"
  }
}

variable "available_zones" {
  description = "AZ in AWS environment"
  type        = list(any)
  default     = ["a", "b", "c", "d", "f"]
}

#------------RDS------------#

variable "db_name" {
  description = "Name for RDS database "
  type        = string
  default     = "wikidb"
}

variable "db_user" {
  description = "Username of RDS database "
  type        = string
  sensitive   = true
}

variable "db_password" {
  description = "Pass of RDS database "
  type        = string
  sensitive   = true
}

#------------EC2-WIKI------------#
variable "wiki_pubkey" {
  description = "Public Key pair to access Wiki's EC2."
  type        = string
  sensitive   = true
}

variable "wiki_ami" {
  description = "AMI of Wiki's EC2."
  type        = string
  default     = "ami-053b0d53c279acc90"
}

variable "wiki_instance_type" {
  description = "Instance type of Wiki's EC2."
  type        = string
  default     = "t2.micro"
}

variable "wiki_port" {
  description = "Port that wiki will be run"
  type        = string
  default     = "3000"
}

