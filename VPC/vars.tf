variable "aws_region" {
   description = "we are defining aws region"
   type = string
   default = "ap-south-1"
   }
variable "vpc_cidr" {
   description = "vpc cidr"
   type= string
   default= "10.0.0.0/16"
}
variable "dnsSupport" {
    default = true
}
variable "dnsHostNames" {
   default = true
}
variable "pubsubnet1" {
   type= string
   default = "10.0.0.0/18"
}
variable "pubsubnet2" {
   type= string
   default = "10.0.64.0/18"
}
variable "prisubnet1" {
   type= string
   default = "10.0.128.0/18"

}
variable "prisubnet2" {
   type= string
   default = "10.0.192.0/18"

}