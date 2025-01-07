variable "cilium_version" {
  type    = string
  default = "1.16.5"
  validation {
    condition     = can(regex("^\\d+(\\.\\d+)+", var.cilium_version))
    error_message = "Must be a version number."
  }
}

variable "kubernetes_version" {
  type    = string
  default = "1.31.3"
  validation {
    condition     = can(regex("^\\d+(\\.\\d+)+", var.kubernetes_version))
    error_message = "Must be a version number."
  }
}

variable "cilium_enable" {
  description = "Enable Cilium"
  type        = bool
  default     = false
}

variable "cilium_lb_first_ip" {
  description = "The first IP address for the Cilium Load Balancer"
  type        = number
  default     = 100
}

variable "cilium_lb_last_ip" {
  description = "The last IP address for the Cilium Load Balancer"
  type        = number
  default     = 150
}

variable "kvm_subnet" {
  description = "The subnet for the KVM network"
  type        = string
  default     = "172.16.16"
}

variable "kvm_cidr" {
  description = "The CIDR for the KVM network"
  type        = number
  default     = 24
}

variable "kubePrism_port" {
  description = "The port for kubePrism"
  type        = number
  default     = 7445
}
