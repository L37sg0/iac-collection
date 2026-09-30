# Infrastructure as Code (IaC) Collection (`iac-collection/`)

A comprehensive, modular repository containing automated infrastructure provisioning setups, local virtualization environments, containerized microservice architectures, and operational backup/restoration utilities.

This collection bridges local development workflows with enterprise-grade hypervisor provisioning (**Proxmox VE**) and automated configuration management (**Terraform**, **Ansible**, and **Vagrant**).

---

## Repository Structure & Modules

```text
iac-collection/
├── backup-scripts/         # Modular Bash utilities for automated file backups, SQL dumps, and Slack notifications
├── terraform/              # Infrastructure provisioning scripts & orchestrators
│   └── kubernetes-cluster/ # Proxmox VE high-availability Kubernetes cluster + HAProxy load balancer
└── vagrant/                # Local development & multi-node virtualization environments
    ├── learn-vagrant/      # Single-node Ubuntu 24.04 environment running Go Terramino
    ├── lemp-mono/          # Monolithic LEMP Stack (Nginx, MySQL 8, PHP-FPM 8.1, Composer)
    ├── lemp-multimachine/  # Decoupled LEMP Stack across private network nodes
    ├── multimachine/       # Distributed 3-tier microservice Terramino topology via mDNS
    └── network-provision/  # Foundational port-forwarding and web root symlink exercise

```

---

## Core Components Overview

### 1. Proxmox Kubernetes & HAProxy Cluster (`terraform/kubernetes-cluster`)

* **Purpose:** Provisions and configures a 5-node cluster on a Proxmox VE hypervisor using Terraform and Ansible.
* **Architecture:** 1 Control Plane Master node, 3 Worker nodes, and 1 HAProxy Load Balancer node cloned from a Debian 12 Cloud-Init template.
* **Automation:** Integrated Ansible playbooks (`ansible/`) for bootstrapping Kubernetes prerequisites and initializing cluster control planes.

### 2. Backup & Restore Automation (`backup-scripts`)

* **Purpose:** Production-ready Bash scripts designed for automated file compression, Dockerized MySQL database dumps (`mysqldump`), and restoration pipelines.
* **Key Features:** Includes notification webhook handlers (`notifications.lib`) to dispatch real-time status alerts to Slack.

### 3. Vagrant Virtualization Workspace (`vagrant`)

* **Purpose:** A progressive suite of local development environments ranging from foundational networking to containerized microservices.
* **Included Projects:**
* **`learn-vagrant`**: Single-node Ubuntu 24.04 box running the containerized Go Terramino game.
* **`lemp-mono`**: Monolithic LEMP stack (Nginx, MySQL 8, PHP 8.1 FPM) with custom override symlinks.
* **`lemp-multimachine`**: 2-tier decoupled LEMP setup separating web and database nodes over a private IP subnet (`192.168.56.x`).
* **`multimachine`**: Distributed 3-tier microservice architecture (Redis, Go Backend, Nginx Frontend) utilizing Avahi/mDNS (`.local`) service discovery.
* **`network-provision`**: Foundational Ubuntu 18.04 Apache2 server demonstrating port forwarding (`4567 -> 80`) and live `/vagrant` symlinking.



---

## Quick Reference Summary

| Subsystem / Directory | Primary Tools | Target Environment / Runtime | Core Focus |
| --- | --- | --- | --- |
| **`terraform/kubernetes-cluster/`** | Terraform, Ansible, Proxmox VE | Cloud/Hypervisor (Proxmox VE) | High-availability Kubernetes & Load Balancing |
| **`backup-scripts/`** | Bash, Zip, MySQL Utilities, cURL | Linux / Unix shell | Automated backups, SQL dumps, & Slack alerts |
| **`vagrant/`** | Vagrant, VirtualBox, Docker, Compose | Local Virtualization | Development stacks, LEMP, & microservice topologies |