terraform {
  required_providers {
    libvirt = {
      source  = "dmacvicar/libvirt"
      version = ">= 0.8.1"
    }
    random = {
      source  = "hashicorp/random"
      version = ">= 3.6.3"
    }
    tls = {
      source  = "hashicorp/tls"
      version = ">= 4.0.6"
    }
    talos = {
      source  = "siderolabs/talos"
      version = ">= 0.7.0"
    }
  }
}

provider "libvirt" {
  uri = "qemu:///system"
}
