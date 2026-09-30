# Proxmox Kubernetes & HAProxy Cluster (`terraform/kubernetes-cluster`)

A complete Infrastructure as Code (IaC) and automation project to provision and configure a high-availability-ready Kubernetes cluster alongside an HAProxy load balancer node on a **Proxmox VE** hypervisor, using a Debian 12 Cloud-Init template and integrated **Ansible** playbooks.

---

## Architecture & Core Components

* 🏗️ **Infrastructure Provisioning (Terraform):**
    * Deploys 5 virtual machines cloned from a `debian12-cloudinit` base image via the `telmate/proxmox` provider (`v3.0.2-rc01`).
        * **Master Node:** 1 control plane node (`master-node`).
        * **Worker Nodes:** 3 independent worker nodes (`worker1-node`, `worker2-node`, `worker3-node`).
        * **Load Balancer Node:** 1 HAProxy routing node (`haproxy-node`) configured for round-robin balancing.
    * Configures customized Cloud-Init parameters (QEMU guest agent snippets, serial interfaces, static/dynamic IP configurations via variables, SSH keys, and storage definitions).


* ⚙️ **Cluster Configuration & Automation (Ansible):**
    * Bundled under `ansible/` with dynamic or static inventory (`k8s-inventory.yml`) and setup playbooks (`k8s-setup.yml`, `k8s-master.yml`) to bootstrap Kubernetes across the provisioned machines.



---

## Project Structure

```text
terraform/kubernetes-cluster/
├── ansible/
│   ├── k8s-inventory.yml      # Ansible inventory configuration for nodes
│   ├── k8s-master.yml         # Playbook for control plane initialization
│   └── k8s-setup.yml          # Playbook for base dependencies & k8s prerequisites
├── haproxy.tf                 # Terraform definition for HAProxy load balancer VM
├── master.tf                  # Terraform definition for Kubernetes master node VM
├── nodes_variables.tf         # Variable definitions for node compute specs, disks, & IPs
├── providers.tf               # Terraform provider requirements and Proxmox provider config
├── providers_variables.tf     # Proxmox API connection variables (URL, token ID, secret)
├── README.md                  # Project documentation
├── worker1.tf                 # Terraform definition for Worker 1 VM
├── worker2.tf                 # Terraform definition for Worker 2 VM
└── worker3.tf                 # Terraform definition for Worker 3 VM

```

---

## Infrastructure Configuration & Variables

### Node Specifications (`nodes_variables.tf`)

Each node type (Master, Workers 1–3, and HAProxy) supports independent configuration parameters via Terraform variables:

* `vmid`: Virtual Machine ID on Proxmox
* `cores`: CPU core count (defaults to `1`)
* `memory`: RAM allocation in MB (defaults to `1024`)
* `disk_size`: Root storage volume size (sensitive default `"10G"`)
* `ipconfig0`: Cloud-init network configuration string (sensitive)

### Global Project Variables

* `project_ciuser`: Default cloud-init user (default: `"admin"`)
* `project_cipassword`: Cloud-init password (sensitive)
* `project_sshkeys`: Public SSH key string injected into VMs (sensitive)
* `project_storage_name`: Target Proxmox storage pool name (sensitive)

---

## Tech Stack & Requirements

* **Hypervisor:** Proxmox VE
* **IaC Tool:** Terraform / OpenTofu (`>= 0.13.0`)
* **Proxmox Provider:** `telmate/proxmox` (v3.0.2-rc01)
* **Configuration Management:** Ansible
* **Base Image:** Debian 12 Cloud-Init template (`debian12-cloudinit`) with QEMU guest agent support