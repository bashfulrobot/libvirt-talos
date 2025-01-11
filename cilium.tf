module "cilium" {
  source             = "./modules/cilium"
  count              = var.cilium_cni ? 1 : 0
  kvm_subnet         = var.kvm_subnet
  kvm_cidr           = var.kvm_cidr
  cilium_version     = var.cilium_version
  kubernetes_version = var.kubernetes_version
  cilium_lb_first_ip = var.cilium_lb_first_ip
  cilium_lb_last_ip  = var.cilium_lb_last_ip

  depends_on = [talos_machine_bootstrap.this]
}