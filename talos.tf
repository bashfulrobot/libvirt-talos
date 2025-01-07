# https://github.com/0xC9C3/protalos/blob/9aa6c9c79898c5ee399842e1a65ca398dd02c2ee/talos.tf#L113
resource "talos_machine_secrets" "this" {
  talos_version = "v${var.talos_version}"
}

data "talos_machine_configuration" "controlplane" {
  cluster_name       = var.cluster_name
  cluster_endpoint   = var.cluster_endpoint
  machine_type       = "controlplane"
  machine_secrets    = talos_machine_secrets.this.machine_secrets
  talos_version      = "v${var.talos_version}"
  kubernetes_version = var.kubernetes_version
}

data "talos_machine_configuration" "worker" {
  cluster_name       = var.cluster_name
  cluster_endpoint   = var.cluster_endpoint
  machine_type       = "worker"
  machine_secrets    = talos_machine_secrets.this.machine_secrets
  talos_version      = "v${var.talos_version}"
  kubernetes_version = var.kubernetes_version
}

resource "talos_machine_configuration_apply" "controlplane" {
  for_each                    = local.controller_nodes_map
  client_configuration        = talos_machine_secrets.this.client_configuration
  machine_configuration_input = data.talos_machine_configuration.controlplane.machine_configuration
  node                        = each.value.address
  config_patches = [
    yamlencode(local.common_machine_config),
    var.cilium_enable ? yamlencode(local.cilium_machine_config) : null
  ]
  # config_patches = [
  #   # yamlencode(var.cilium_enable ? local.cilium_machine_config : local.common_machine_config),
  #   # file("${path.module}/files/cp-scheduling.yaml"),
  # ]
}

resource "talos_machine_configuration_apply" "worker" {
  for_each                    = local.worker_nodes_map
  client_configuration        = talos_machine_secrets.this.client_configuration
  machine_configuration_input = data.talos_machine_configuration.worker.machine_configuration
  node                        = each.value.address
  config_patches = [
    yamlencode(local.common_machine_config),
    var.cilium_enable ? yamlencode(local.cilium_machine_config) : null
  ]
}

resource "talos_machine_bootstrap" "this" {
  client_configuration = talos_machine_secrets.this.client_configuration
  node                 = local.controller_nodes[0].address
}

data "talos_client_configuration" "this" {
  cluster_name         = var.cluster_name
  client_configuration = talos_machine_secrets.this.client_configuration
  endpoints            = [for node in values(local.controller_nodes_map) : node.address]
}

resource "talos_cluster_kubeconfig" "this" {
  client_configuration = talos_machine_secrets.this.client_configuration
  endpoint             = local.controller_nodes[0].address
  node                 = local.controller_nodes[0].address
}

module "cilium" {
  source = "./modules/cilium"
  count  = var.cilium_enable ? 1 : 0
  kvm_subnet = var.kvm_subnet
  kvm_cidr = var.kvm_cidr
  cilium_version = var.cilium_version
  kubernetes_version = var.kubernetes_version
  cilium_lb_first_ip = var.cilium_lb_first_ip
  cilium_lb_last_ip = var.cilium_lb_last_ip

  depends_on = [ talos_machine_bootstrap.this ]
}