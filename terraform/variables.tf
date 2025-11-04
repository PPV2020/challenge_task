variable "region" { 
    type = string 
    default = "us-east-1"
}

variable "aws_profile" {
    type = string
    default = "default"
}

variable "project" {
    type = string
    default = "prex-challenge"
}

variable "vpc_cidr" {
    type = string
    default = "10.0.0.0/16"
}

variable "az_count" {
    type = number
    default = 2
}

variable "eks_version" {
    type = string
    default = "1.29"
}