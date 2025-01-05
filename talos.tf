# https://github.com/0xC9C3/protalos/blob/9aa6c9c79898c5ee399842e1a65ca398dd02c2ee/talos.tf#L113
resource "talos_machine_secrets" "this" {
  talos_version = "v${var.talos_version}"
}

data "talos_machine_configuration" "controlplane" {
  depends_on         = [talos_machine_secrets.this]
  cluster_name       = var.cluster_name
  cluster_endpoint   = var.cluster_endpoint
  machine_type       = "controlplane"
  machine_secrets    = talos_machine_secrets.this.machine_secrets
  talos_version      = "v${var.talos_version}"
  kubernetes_version = var.kubernetes_version
}

data "talos_machine_configuration" "worker" {
  depends_on         = [talos_machine_secrets.this]
  cluster_name       = var.cluster_name
  cluster_endpoint   = var.cluster_endpoint
  machine_type       = "worker"
  machine_secrets    = talos_machine_secrets.this.machine_secrets
  talos_version      = "v${var.talos_version}"
  kubernetes_version = var.kubernetes_version
}

resource "talos_machine_configuration_apply" "controlplane" {
  depends_on                  = [data.talos_machine_configuration.controlplane]
  for_each                    = local.controller_nodes_map
  client_configuration        = talos_machine_secrets.this.client_configuration
  machine_configuration_input = data.talos_machine_configuration.controlplane.machine_configuration
  node                        = each.value.address
  config_patches = [
    yamlencode(var.cilium_enable ? local.cilium_machine_config : local.common_machine_config),
  ]
  # config_patches = [
  #   # yamlencode(var.cilium_enable ? local.cilium_machine_config : local.common_machine_config),
  #   # file("${path.module}/files/cp-scheduling.yaml"),
  # ]
}

resource "talos_machine_configuration_apply" "worker" {
  depends_on                  = [data.talos_machine_configuration.worker]
  for_each                    = local.worker_nodes_map
  client_configuration        = talos_machine_secrets.this.client_configuration
  machine_configuration_input = data.talos_machine_configuration.worker.machine_configuration
  node                        = each.value.address
  config_patches = [
    yamlencode(var.cilium_enable ? local.cilium_machine_config : local.common_machine_config),
  ]
}

resource "talos_machine_bootstrap" "this" {
  depends_on           = [talos_machine_configuration_apply.controlplane]
  client_configuration = talos_machine_secrets.this.client_configuration
  node                 = local.controller_nodes[0].address
}

data "talos_client_configuration" "this" {
  # depends_on           = [talos_machine_bootstrap.this]
  cluster_name         = var.cluster_name
  client_configuration = talos_machine_secrets.this.client_configuration
  endpoints            = [for node in values(local.controller_nodes_map) : node.address]
}

resource "talos_cluster_kubeconfig" "this" {
  # depends_on           = [talos_machine_bootstrap.this]
  client_configuration = talos_machine_secrets.this.client_configuration
  endpoint             = local.controller_nodes[0].address
  node                 = local.controller_nodes[0].address
}
