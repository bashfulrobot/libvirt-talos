resource "libvirt_volume" "wk" {
  for_each = local.worker_nodes_map
  name     = each.value.disk_name
  size     = var.wk_disk_size * 1024 * 1024 * 1024
}

resource "libvirt_volume" "cp" {
  for_each = local.controller_nodes_map
  name     = each.value.disk_name
  size     = var.cp_disk_size * 1024 * 1024 * 1024
}

resource "libvirt_domain" "cp" {
  for_each = local.controller_nodes_map

  name   = each.value.name
  vcpu   = var.cp_vcpus
  memory = var.cp_memory
  disk {
    volume_id = libvirt_volume.cp[each.key].id
  }
  disk {
    file = var.iso_path
  }
  boot_device {
    dev = ["hd", "cdrom"]
  }

  console {
    type        = "pty"
    target_port = "0"
  }

  cpu {
    mode = "host-passthrough"
  }

  network_interface {
    network_name   = var.cluster_name
    wait_for_lease = true
    addresses      = [each.value.address]
  }
}

resource "libvirt_domain" "wk" {
  for_each = local.worker_nodes_map

  name   = each.value.name
  vcpu   = var.wk_vcpus
  memory = var.wk_memory
    disk {
    volume_id = libvirt_volume.wk[each.key].id
  }
  disk {
    file = var.iso_path
  }
  boot_device {
    dev = ["hd", "cdrom"]
  }

  console {
    type        = "pty"
    target_port = "0"
  }

  cpu {
    mode = "host-passthrough"
  }

  network_interface {
    network_name   = var.cluster_name
    wait_for_lease = true
    addresses      = [each.value.address]
  }
}