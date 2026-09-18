resource "proxmox_vm_qemu" "master-node" {
  vmid        = var.master_node_vmid
  name        = "master-node"
  target_node = "proxmox"
  agent       = 1
  cores       = var.master_node_cores
  memory      = var.master_node_memory
  boot = "order=scsi0" # has to be the same as the OS disk of the template
  clone = "debian12-cloudinit" # The name of the template
  scsihw      = "virtio-scsi-single"
  vm_state    = "running"
  automatic_reboot = true

  # Cloud-Init configuration
  cicustom = "vendor=local:snippets/qemu-guest-agent.yml" # /var/lib/vz/snippets/qemu-guest-agent.yml
  ciupgrade  = true
  nameserver = "1.1.1.1 8.8.8.8"
  ipconfig0  = var.master_node_ipconfig
  skip_ipv6  = true
  ciuser     = var.project_ciuser
  cipassword = var.project_cipassword
  sshkeys    = var.project_sshkeys

  # Most cloud-init images require a serial device for their display
  serial {
    id = 0
  }

  disks {
    scsi {
      scsi0 {
        # We have to specify the disk from our template, else Terraform will think it's not supposed to be there
        disk {
          storage = var.project_storage_name
          # The size of the disk should be at least as big as the disk in the template. If it's smaller, the disk will be recreated
          size = var.master_node_disk_size
        }
      }
    }
    ide {
      # Some images require a cloud-init disk on the IDE controller, others on the SCSI or SATA controller
      ide1 {
        cloudinit {
          storage = var.project_storage_name
        }
      }
    }
  }

  network {
    id     = 0
    bridge = "vmbr0"
    model  = "virtio"
  }
}
