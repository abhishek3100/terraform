# Change variables as per your need

variable "project_id" {
  default = "YOUR_PROJECT_ID"
  type    = string
}

variable "region" {
  default = "us-central1"
  type    = string
}

variable "zone" {
  default = "us-central1-c"
  type    = string
}

variable "image" {
  default = "ubuntu-os-cloud/ubuntu-2004-lts"
  type    = string
}

variable "machine_type_elasticsearch" {
  default = "n1-standard-2"
  type    = string
}

variable "machine_type_jenkins" {
  default = "n1-standard-2"
  type    = string
}

variable "size" {
  default = "100"
  type    = number
}

variable "vm_instance_1" {
  default = "tf-elasticsearch"
  type    = string
}

variable "vm_instance_2" {
  default = "tf-jenkins-server"
  type    = string
}