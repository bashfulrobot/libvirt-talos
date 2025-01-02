output "talosconfig" {
  value     = data.talos_client_configuration.this.talos_config
  sensitive = true
}

output "kubeconfig" {
  value     = talos_cluster_kubeconfig.this.kubeconfig_raw
  sensitive = true
}

resource "null_resource" "output_talosconfig" {
  provisioner "local-exec" {
    command = "mkdir -p config_files && terraform output -raw ${var.cluster_name}_talosconfig > talosconfig"
  }
  depends_on = [output.talosconfig]
}

resource "null_resource" "output_kubeconfig" {
  provisioner "local-exec" {
    command = "mkdir -p config_files && terraform output -raw kubeconfig > ${var.cluster_name}_kubeconfig"
  }
  depends_on = [output.kubeconfig]
}
