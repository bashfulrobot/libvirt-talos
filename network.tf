resource "libvirt_network" "kvm_network" {
  name      = var.cluster_name
  autostart = true
  mode      = var.kvm_network_type
  domain    = "${var.cluster_name}.local"
  addresses = ["${var.kvm_subnet}.0/${var.kvm_cidr}"]
  dns {
    enabled    = true
    local_only = false
  }
  dhcp {
    enabled = true
  }

}
