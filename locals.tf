locals {
  controller_nodes = [
    for i in range(var.cp_count) : {
      name      = "${var.cluster_name}-${var.cp_suffix}${i}"
      address   = cidrhost("${var.kvm_subnet}.0/${var.kvm_cidr}", var.cp_first_ip + i)
      disk_name = "${var.cluster_name}-${var.cp_suffix}${i}-disk"
    }
  ]
  worker_nodes = [
    for i in range(var.wk_count) : {
      name      = "${var.cluster_name}-${var.wk_suffix}${i}"
      address   = cidrhost("${var.kvm_subnet}.0/${var.kvm_cidr}", var.wk_first_ip + i)
      disk_name = "${var.cluster_name}-${var.wk_suffix}${i}-disk"
    }
  ]
  worker_nodes_map     = { for node in local.worker_nodes : node.name => node }
  controller_nodes_map = { for node in local.controller_nodes : node.name => node }

  common_machine_config = {
    machine = {
      # talos image, which is created in the installed state.
      install = {
        image = "${var.talos_factory_installer_base_url}${var.talos_factory_hash}:v${var.talos_version}"
        disk  = "${var.install_disk}"
        wipe  = true
      }
    }
  }
  cilium_machine_config = {
    machine = {
      # NB the install section changes are only applied after a talos upgrade
      #    (which we do not do). instead, its preferred to create a custom
      #    talos image, which is created in the installed state.
      #install = {}
      features = {
        # NB if you use a non-default CNI, you must configure it to use the
        #    https://localhost:7445 kube-apiserver endpoint.
        kubePrism = {
          enabled = true
          port    = 7445
        }
        hostDNS = {
          enabled              = true
          forwardKubeDNSToHost = true
        }
      }
    }
    cluster = {
      network = {
        cni = {
          name = "none"
        }
      }
      proxy = {
        disabled = true
      }
    }
  }
}
