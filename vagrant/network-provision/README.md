# Network Provisioning Exercise on Vagrant (`vagrant/network-provision`)

A foundational **Vagrant** networking tutorial and provisioning project using **Ubuntu Bionic Beaver (18.04 LTS)** and **Apache2**, designed to demonstrate port forwarding and synchronized web root configurations.

---

## Architecture & Core Features

* 🌐 **Port Forwarding (`Vagrantfile`):**
    * Forwards host port `4567` to guest port `80`, allowing external browser access to the Apache server running inside the virtual machine.


* 🚀 **Provisioning Script (`bootstrap.sh`):**
    * Updates package repositories and installs the **Apache2** web server.
    * Replaces the default `/var/www` directory with a symbolic link pointing directly to the synchronized host workspace (`/vagrant`), enabling instant live-editing of web assets.


* 📄 **Static Web Content (`html/index.html`):**
    * A simple landing page verifying successful Vagrant bootstrap and web server operation.



---

## Project Structure

```text
vagrant/network-provision/
├── bootstrap.sh       # Provisioning script (installs Apache2 and sets up /var/www symlink to /vagrant)
├── html/
│   └── index.html     # Simple HTML greeting page served by Apache
└── Vagrantfile        # Vagrant configuration defining the bionic64 box and port forwarding (4567 -> 80)

```

---

## Usage & Quick Start

### Bring Up the Environment

```bash
vagrant up

```

### Access the Web Page

Open your browser and navigate to:

* **URL:** `http://localhost:4567`

### Connect via SSH

```bash
vagrant ssh

```

---

## Tech Stack & Requirements

* **Virtualization:** Vagrant
* **OS Box:** HashiCorp Ubuntu 18.04 LTS (`hashicorp/bionic64`)
* **Web Server:** Apache2