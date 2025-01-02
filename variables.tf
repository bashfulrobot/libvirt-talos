# ---------- K8S Variables ----------

variable "cluster_name" {
  description = "The name of the K8s cluster"
  type        = string
  default     = "blackhole"
}

# ---------- Version Variables ----------

#  https://www.talos.dev/v1.9/introduction/support-matrix/
# https://kubernetes.io/releases/
# see https://github.com/siderolabs/talos/releases
variable "talos_version" {
  type = string
  # renovate: datasource=github-releases depName=siderolabs/talos
  default = "1.9.1"
  validation {
    condition     = can(regex("^\\d+(\\.\\d+)+", var.talos_version))
    error_message = "Must be a version number."
  }
}
# see https://github.com/siderolabs/kubelet/pkgs/container/kubelet
#  https://www.talos.dev/v1.9/introduction/support-matrix/
# https://kubernetes.io/releases/
# see https://github.com/siderolabs/talos/releases
variable "kubernetes_version" {
  type = string
  # renovate: datasource=github-releases depName=siderolabs/kubelet
  default = "1.31.3"
  validation {
    condition     = can(regex("^\\d+(\\.\\d+)+", var.kubernetes_version))
    error_message = "Must be a version number."
  }
}

# ---------- Host Variables ----------

# no default value for install disk so it must be set
# safety to avoid accidental overwrite
variable "install_disk" {
  description = "The disk to install Talos on"
  type        = string

}

### Control Plane Nodes

variable "cp_count" {
  description = "The number of control plane nodes"
  type        = number
  default     = 3
}

variable "cp_vcpus" {
  description = "The number of vCPUs for the control plane nodes"
  type        = number
  default     = 2
}

variable "cp_memory" {
  description = "The amount of memory for the control plane nodes"
  type        = number
  default     = 2048
}

variable "cp_disk_size" {
  description = "The size (GB) of the disk for the control plane nodes"
  type        = number
  default     = 20
}

variable "cp_suffix" {
  description = "The suffix for the control plane nodes hostnames"
  type        = string
  default     = "cp"
}

variable "cp_first_ip" {
  description = "The first IP address for the control plane nodes"
  type        = number
  default     = 10
}

### Worker Nodes

variable "wk_count" {
  description = "The number of worker nodes"
  type        = number
  default     = 2
}

variable "wk_vcpus" {
  description = "The number of vCPUs for the worker nodes"
  type        = number
  default     = 2
}

variable "wk_memory" {
  description = "The amount of memory for the worker nodes"
  type        = number
  default     = 2048
}

variable "wk_disk_size" {
  description = "The size (GB) of the disk for the worker nodes"
  type        = number
  default     = 20
}

variable "wk_suffix" {
  description = "The suffix for the worker nodes hostnames"
  type        = string
  default     = "wk"
}

variable "wk_first_ip" {
  description = "The first IP address for the worker nodes"
  type        = number
  default     = 20
}

# ---------- Network Variables ----------

variable "kvm_network_type" {
  description = "The network type for the KVM network (route, nat)"
  type        = string
  default     = "nat"
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

# ---------- Talos Variables ----------

variable "iso_path" {
  description = "The path to the Talos ISO"
  type        = string
  default     = "/var/lib/libvirt/images/metal-amd64.iso"
}

variable "cluster_vip" {
  description = "The virtual IP (VIP) address of the Kubernetes API server. Ensure it is synchronized with the 'cluster_endpoint' variable."
  type        = string
  default     = "192.168.1.79"
}

variable "cluster_endpoint" {
  description = "The virtual IP (VIP) endpoint of the Kubernetes API server. Ensure it is synchronized with the 'cluster_vip' variable."
  type        = string
  default     = "https://172.16.16.10:6443"
}

variable "config_patch_files" {
  description = "Path to talos config path files that applies to all nodes"
  type        = list(string)
  default     = []
}

variable "talos_factory_installer_base_url" {
  description = "talos factory image base url"
  default     = "factory.talos.dev/installer/"
}

variable "talos_factory_hash" {
  description = "talos factory hash"
  default     = "dc7b152cb3ea99b821fcb7340ce7168313ce393d663740b791c36f6e95fc8586"
}