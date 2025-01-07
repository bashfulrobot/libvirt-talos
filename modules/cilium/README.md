<!-- BEGIN_TF_DOCS -->
## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_helm"></a> [helm](#provider\_helm) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [helm_release.cilium](https://registry.terraform.io/providers/hashicorp/helm/latest/docs/resources/release) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_cilium_enable"></a> [cilium\_enable](#input\_cilium\_enable) | Enable Cilium | `bool` | `false` | no |
| <a name="input_cilium_lb_first_ip"></a> [cilium\_lb\_first\_ip](#input\_cilium\_lb\_first\_ip) | The first IP address for the Cilium Load Balancer | `number` | `100` | no |
| <a name="input_cilium_lb_last_ip"></a> [cilium\_lb\_last\_ip](#input\_cilium\_lb\_last\_ip) | The last IP address for the Cilium Load Balancer | `number` | `150` | no |
| <a name="input_cilium_version"></a> [cilium\_version](#input\_cilium\_version) | n/a | `string` | `"1.16.5"` | no |
| <a name="input_kubePrism_port"></a> [kubePrism\_port](#input\_kubePrism\_port) | The port for kubePrism | `number` | `7445` | no |
| <a name="input_kubernetes_version"></a> [kubernetes\_version](#input\_kubernetes\_version) | n/a | `string` | `"1.31.3"` | no |
| <a name="input_kvm_cidr"></a> [kvm\_cidr](#input\_kvm\_cidr) | The CIDR for the KVM network | `number` | `24` | no |
| <a name="input_kvm_subnet"></a> [kvm\_subnet](#input\_kvm\_subnet) | The subnet for the KVM network | `string` | `"172.16.16"` | no |

## Outputs

No outputs.
<!-- END_TF_DOCS -->