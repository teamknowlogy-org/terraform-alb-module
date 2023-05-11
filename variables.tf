variable "project" {
  description = "Project name"
  type        = string
}
variable "module" {
  description = "Project module"
  type        = string
}
variable "environment" {
  description = "Project environment"
  type        = string
}
variable "vpc_id" {
  description = "ID of the VPC"
  type        = string
}
variable "certificate_arn" {
  description = "The ACM Arn for the HTTPs listener"
  type        = string
}
variable "subnet_public_ids" {
  description = "List of the Public Subnet IDs."
  type        = list(any)
}

variable "route53_domain" {
  description = "Domain of ACM certificate"
  type = string 
} 