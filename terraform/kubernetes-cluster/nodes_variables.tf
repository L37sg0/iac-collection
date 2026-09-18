variable "master_node_vmid" {
  type = number
}
variable "master_node_cores" {
  type = number
  default = 1
}
variable "master_node_memory" {
  type = number
  default = 1024
}
variable "master_node_ipconfig" {
  type = string
  sensitive = true
}
variable "master_node_disk_size" {
  type = string
  sensitive = true
  default = "10G"
}
variable "worker1_node_vmid" {
  type = number
}
variable "worker1_node_cores" {
  type = number
  default = 1
}
variable "worker1_node_memory" {
  type = number
  default = 1024
}
variable "worker1_node_ipconfig" {
  type = string
  sensitive = true
}
variable "worker1_node_disk_size" {
  type = string
  sensitive = true
  default = "10G"
}
variable "worker2_node_vmid" {
  type = number
}
variable "worker2_node_cores" {
  type = number
  default = 1
}
variable "worker2_node_memory" {
  type = number
  default = 1024
}
variable "worker2_node_ipconfig" {
  type = string
  sensitive = true
}
variable "worker2_node_disk_size" {
  type = string
  sensitive = true
  default = "10G"
}
variable "worker3_node_vmid" {
  type = number
}
variable "worker3_node_cores" {
  type = number
  default = 1
}
variable "worker3_node_memory" {
  type = number
  default = 1024
}
variable "worker3_node_ipconfig" {
  type = string
  sensitive = true
}
variable "worker3_node_disk_size" {
  type = string
  sensitive = true
  default = "10G"
}
variable "haproxy_node_vmid" {
  type = number
}
variable "haproxy_node_cores" {
  type = number
  default = 1
}
variable "haproxy_node_memory" {
  type = number
  default = 1024
}
variable "haproxy_node_ipconfig" {
  type = string
  sensitive = true
}
variable "haproxy_node_disk_size" {
  type = string
  sensitive = true
  default = "10G"
}
variable "project_ciuser" {
  type = string
  sensitive = true
  default = "admin"
}
variable "project_cipassword" {
  type = string
  sensitive = true
  default = "password"
}
variable "project_sshkeys" {
  type = string
  sensitive = true
}

variable "project_storage_name" {
  type = string
  sensitive = true
}