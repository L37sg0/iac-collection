# Multi-Machine Microservice Terramino on Vagrant (`vagrant/multimachine`)

A multi-node distributed architecture project using **Vagrant** and **Ubuntu 24.04** that decomposes the **Terramino** application into three isolated virtual machines (**Redis**, **Backend**, and **Frontend**), utilizing mDNS/Avahi service discovery and containerized runtime environments.

---

## Architecture & Core Features

* 🌐 **Three-Tier Microservice Topology (`Vagrantfile`):**
    * **Redis Server (`redis`):** Manages state and high scores on private IP `192.168.56.10` (Port `6379`).
    * **Backend API (`backend`):** Runs the Go game engine server on private IP `192.168.56.11` (Port `8080`), communicating dynamically with Redis via `.local` mDNS resolution.
    * **Frontend Nginx Server (`frontend`):** Serves the web interface and static assets on private IP `192.168.56.12` (Port `8081`), proxying game traffic to the backend node.


* 📦 **Common Provisioning (`common-dependencies.sh`):**
    * Installs Docker CE, Docker Buildx, and Docker Compose v2.
    * Installs **Avahi-daemon** and `libnss-mdns` across all boxes to enable reliable `.local` hostname resolution between VMs.
    * Clones the containerized branch of `terramino-go` into each isolated VM synced directory.


* 🔄 **Dynamic Service Discovery & Fallbacks:**
    * Uses intelligent retry loops with `getent hosts` to resolve cross-node IP addresses dynamically at runtime (`redis.local`, `backend.local`).
    * Automatically injects hosts using Docker's `--add-host` parameter and updates Nginx proxy configurations on the fly via `sed`.



---

## Project Structure

```text
vagrant/multimachine/
├── backend/
│   └── terramino-go/          # Backend VM sync folder (Go app, Dockerfile.backend)
├── frontend/
│   └── terramino-go/          # Frontend VM sync folder (Web assets, Nginx, Dockerfile.frontend)
├── redis/
│   └── terramino-go/          # Redis VM sync folder (docker-compose config for Redis)
├── common-dependencies.sh     # Common setup script (Docker, Git, Avahi mDNS discovery)
└── Vagrantfile                # Multi-machine definition specifying IPs, port forwarding, and inline provisioners

```

---

## Usage & Commands

### Bring Up All Microservice Nodes

```bash
vagrant up

```

### Access the Application

* **Frontend Web App:** Open `http://localhost:8081` in your browser.
* **Backend API:** Accessible via `http://localhost:8080`.

### Management & Reload Hooks

* Reload Redis service: `vagrant provision --provision-with reload-redis`
* Reload Backend service: `vagrant provision --provision-with reload-backend`
* Reload Frontend service: `vagrant provision --provision-with reload-frontend`

---

## Tech Stack & Requirements

* **Virtualization:** Vagrant with VirtualBox / compatible provider
* **OS Box:** HashiCorp Ubuntu 24.04 (`hashicorp-education/ubuntu-24-04`)
* **Service Discovery:** Avahi / mDNS (`.local` hostname resolution)
* **Containerization:** Docker & Docker Compose v2
* **Application Framework:** Go (Backend), Nginx (Frontend), Redis (State store)