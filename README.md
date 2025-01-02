# LIBVIRT-TALOS

## Summary

Currently a work in progress, but this repo will be refactored to be a consumable module to deploy a Talos Linux Kubernetes cluster.

## Test

- `terraform output -raw talosconfig > talosconfig`
- `terraform output -raw kubeconfig > kubeconfig`
- `talosctl --talosconfig=talosconfig -e 172.16.200.10 -n 172.16.200.10 dmesg`
- `kubectl get nodes --kubeconfig=kubeconfig`

## Talos Linux Image Factory

- Talos [Factory](https://factory.talos.dev/?arch=amd64&cmdline-set=true&extensions=-&extensions=siderolabs%2Fiscsi-tools&extensions=siderolabs%2Fqemu-guest-agent&platform=nocloud&target=cloud&version=1.9.1) page

### Schematic Ready

Your image schematic ID is: dc7b152cb3ea99b821fcb7340ce7168313ce393d663740b791c36f6e95fc8586

```yaml
customization:
    systemExtensions:
        officialExtensions:
            - siderolabs/iscsi-tools
            - siderolabs/qemu-guest-agent
```

### First Boot

Here are the options for the initial boot of Talos Linux on Nocloud:

Disk Image

[https://factory.talos.dev/image/dc7b152cb3ea99b821fcb7340ce7168313ce393d663740b791c36f6e95fc8586/v1.9.1/nocloud-amd64.raw.xz](https://factory.talos.dev/image/dc7b152cb3ea99b821fcb7340ce7168313ce393d663740b791c36f6e95fc8586/v1.9.1/nocloud-amd64.raw.xz)

ISO

[https://factory.talos.dev/image/dc7b152cb3ea99b821fcb7340ce7168313ce393d663740b791c36f6e95fc8586/v1.9.1/nocloud-amd64.iso](https://factory.talos.dev/image/dc7b152cb3ea99b821fcb7340ce7168313ce393d663740b791c36f6e95fc8586/v1.9.1/nocloud-amd64.iso)

PXE boot (iPXE script)

<https://pxe.factory.talos.dev/pxe/dc7b152cb3ea99b821fcb7340ce7168313ce393d663740b791c36f6e95fc8586/v1.9.1/nocloud-amd64>

### Initial Installation

For the initial installation of Talos Linux (not applicable for disk image boot), add the following installer image to the machine configuration:
factory.talos.dev/installer/dc7b152cb3ea99b821fcb7340ce7168313ce393d663740b791c36f6e95fc8586:v1.9.1

### Upgrading Talos Linux

To [upgrade](https://www.talos.dev/v1.9/talos-guides/upgrading-talos/) Talos Linux on the machine, use the following image:
factory.talos.dev/installer/dc7b152cb3ea99b821fcb7340ce7168313ce393d663740b791c36f6e95fc8586:v1.9.1
