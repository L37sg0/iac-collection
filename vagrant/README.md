# Complete Vagrant Projects Workspace (`vagrant/`)

This document serves as the master overview and index for the entire collection of **Vagrant** infrastructure, provisioning, networking, and microservice projects located in the `vagrant/` workspace.

The workspace covers a comprehensive progressive learning curve—ranging from basic single-node web servers and containerized app demos to complex multi-machine LEMP architectures and distributed microservices utilizing mDNS service discovery.

---

## Workspace Directory Overview

```text
vagrant/
├── learn-vagrant/        # Single-node Ubuntu 24.04 environment running Go Terramino (Docker & Compose)
├── lemp-mono/            # Monolithic LEMP Stack (Ubuntu 22.04, Nginx, MySQL, PHP-FPM, Composer)
├── lemp-multimachine/    # Decoupled LEMP Stack (Separate Web and Database nodes over private IP)
├── multimachine/         # Distributed 3-tier microservice architecture (Redis, Backend, Frontend via mDNS)
└── network-provision/    # Foundational networking exercise (Ubuntu 18.04, Apache2, port forwarding)

```

---

## Project Summaries

### 1. Terramino Go on Vagrant (`vagrant/learn-vagrant`)

* **Purpose:** Deploys a containerized Go and Docker-based Tetris demo application originally created by HashiCorp Education inside a single Ubuntu 24.04 virtual machine.
* **Key Tech:** Ubuntu 24.04, Docker CE, Docker Compose v2, Go, Nginx.
* **Ports:** `8080`, `8081` (Forwarded to host).
* **Highlights:** Includes custom shell automation scripts (`install-dependencies.sh`) and provisioning hooks for container management (`start-terramino`, `reload-terramino`).

### 2. Monolithic LEMP Stack on Vagrant (`vagrant/lemp-mono`)

* **Purpose:** Provides a production-like single-box development environment running a complete monolithic LEMP stack with synchronized overrides and a validation dashboard.
* **Key Tech:** Ubuntu 22.04 LTS (Jammy), Nginx, MySQL 8.0, PHP-FPM 8.1, Composer.
* **Ports:** `8080` → `80`.
* **Highlights:** Dynamic host-to-guest symlinking for Nginx virtual hosts, PHP runtime settings (`99-local.ini`), and MySQL custom configurations (`99-my.cnf`).

### 3. Multi-Machine LEMP Stack on Vagrant (`vagrant/lemp-multimachine`)

* **Purpose:** Splits the traditional LEMP stack into a decoupled, two-node tiered architecture separating application processing from database persistence.
* **Key Tech:** Vagrant Private Networking (`192.168.56.x`), Ubuntu 22.04, MySQL (DB Node), Nginx & PHP-FPM (Web Node).
* **Ports:** `8080` → `80` (Web node).
* **Highlights:** Configures remote database bindings (`0.0.0.0`) and network-scoped security grants across independent virtual machines.

### 4. Multi-Machine Microservice Terramino (`vagrant/multimachine`)

* **Purpose:** Implements a distributed three-tier microservice topology that isolates state storage, backend game logic, and frontend rendering into three dedicated nodes.
* **Key Tech:** Avahi / mDNS (`.local` discovery), Docker Compose, Go, Nginx, Redis.
* **Nodes & IPs:**
* `redis` (`192.168.56.10` - Port `6379`)
* `backend` (`192.168.56.11` - Port `8080`)
* `frontend` (`192.168.56.12` - Port `8081`)


* **Highlights:** Dynamic hostname resolution (`redis.local`, `backend.local`) and zero-hardcoded cross-node IP configurations via runtime retry loops.

### 5. Network Provisioning Exercise (`vagrant/network-provision`)

* **Purpose:** A lightweight, foundational networking and shell provisioning tutorial demonstrating port forwarding and synchronized web roots.
* **Key Tech:** Ubuntu 18.04 LTS (`hashicorp/bionic64`), Apache2.
* **Ports:** `4567` → `80`.
* **Highlights:** Replaces the default `/var/www` directory with a live symbolic link pointing directly to the host workspace (`/vagrant`).

---

## Quick Reference Table

| Project Directory | Architecture Type | OS Base Box | Primary Software Stack | Main Access URL / Port |
| --- | --- | --- | --- | --- |
| `learn-vagrant/` | Single-Node Containerized | Ubuntu 24.04 | Docker, Go, Nginx | `http://localhost:8080` / `8081` |
| `lemp-mono/` | Monolithic LEMP | Ubuntu 22.04 | Nginx, MySQL 8, PHP 8.1 | `http://localhost:8080` |
| `lemp-multimachine/` | 2-Tier LEMP (Decoupled) | Ubuntu 22.04 | Nginx/PHP (Web) + MySQL (DB) | `http://localhost:8080` |
| `multimachine/` | 3-Tier Microservices | Ubuntu 24.04 | Redis, Go Backend, Nginx Frontend | `http://localhost:8081` (Frontend) |
| `network-provision/` | Basic Networking | Ubuntu 18.04 | Apache2 | `http://localhost:4567` |