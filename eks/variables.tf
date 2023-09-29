# eks variables

variable "cluster_name" {}
variable "role_arn" {}
variable "cluster_version" {}
variable "private_app_subnet_az1_id" {}
variable "private_app_subnet_az2_id" {}
variable "sec" {}

#node group variables
variable "node_group_name" {}
variable "node_role_arn" {}
variable "capacity_type" {}
variable "ami_type" {}
variable "instance_types" {}
variable "desired_size" {}
variable "max_size" {}
variable "min_size" {}
variable "max_unavailable" {}

