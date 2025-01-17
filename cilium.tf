module "cilium" {
  source             = "./modules/cilium"
  count              = var.cilium_cni ? 1 : 0
  kvm_subnet         = var.kvm_subnet
  kvm_cidr           = var.kvm_cidr
  cilium_version     = var.cilium_version
  kubernetes_version = var.kubernetes_version

  depends_on = [
    talos_machine_bootstrap.this,
    talos_cluster_kubeconfig.this,
    local_file.kubeconfig
  ]
}