# Multi-Machine LEMP Stack on Vagrant (`vagrant/lemp-multimachine`)

A decoupled, multi-node development environment built with **Vagrant** and **Ubuntu 22.04 LTS (Jammy Jellyfish)** that separates database and application tiers into dedicated virtual machines for a production-like microservice or tiered architecture experience.

---

## Architecture & Core Features

* 🌐 **Multi-Machine Topology (`Vagrantfile`):**
    * **Database Node (`db`):** Dedicated MySQL server running on private IP `192.168.56.11`.
    * **Web Node (`web`):** Nginx and PHP-FPM server running on private IP `192.168.56.12`, forwarding host port `8080` to guest port `80`.


* 🗄️ **Dedicated Database Tier (`bs-db.sh` & `etc/mysql/custom/z-my.cnf`):**
    * Installs MySQL Server and configures network binding (`bind-address = 0.0.0.0`) to accept remote connections from the web node subnet (`192.168.56.%`).
    * Automatically provisions network-scoped database user privileges and general query logging.


* ⚙️ **Decoupled Application Tier (`bs-web.sh`):**
    * Installs Nginx, PHP 8.1 FPM, and required extensions (`mysql`, `curl`, `mbstring`, `xml`, etc.) without a local database overhead.
    * Installs **Composer** for dependency management.
    * Synchronizes web roots and configuration overrides dynamically between the host and guest machines.


* 🔍 **Cross-Node Validation (`html/index.php`):**
    * Validates PHP runtime execution, local extensions, Composer status, and successful network connectivity to the separate database server node (`192.168.56.11`).



---

## Project Structure

```text
vagrant/lemp-multimachine/
├── bs-db.sh                  # Provisioning script for the Database node (MySQL setup, bind-address, remote user grants)
├── bs-web.sh                 # Provisioning script for the Web node (Nginx, PHP-FPM, extensions, Composer)
├── etc/
│   ├── mysql/
│   │   └── custom/
│   │       └── z-my.cnf      # MySQL overrides enabling general log and remote binding (0.0.0.0)
│   ├── nginx/
│   │   └── sites-available/
│   │       └── 99-example.conf # Nginx site configuration block
│   └── php/
│       └── custom/
│           └── 99-local.ini  # Custom PHP-FPM execution limits and memory thresholds
├── html/
│   ├── index.php             # Cross-node validation dashboard testing web-to-db remote connectivity
│   └── phpinfo.php           # Standard PHP environment info page
├── LICENSE                   # MIT License
├── README.md                 # Project documentation
└── Vagrantfile               # Multi-machine Vagrant definition (private networking, static IPs, synced folders)

```

---

## Usage & Quick Start

### Bring Up the Multi-Machine Environment

```bash
vagrant up

```

### Access the Application

Open your browser and navigate to:

* **Validation Dashboard:** `http://localhost:8080` (Tests remote connection from the `web` VM to the `db` VM at `192.168.56.11`).
* **PHP Info:** `http://localhost:8080/phpinfo.php`

### Access Individual Nodes via SSH

* **Web Node:** `vagrant ssh web`
* **Database Node:** `vagrant ssh db`

---

## Tech Stack & Software Versions

* **Virtualization:** Vagrant (`ubuntu/jammy64`) with Private Networking
* **Web Server:** Nginx (v1.18.0) — on `web` node
* **Database Server:** MySQL (v8.0.45) — on `db` node
* **Language Runtime:** PHP-FPM (v8.1.2) — on `web` node
* **Dependency Manager:** Composer (v2.9.7) — on `web` node