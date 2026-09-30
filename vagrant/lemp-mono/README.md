# Monolithic LEMP Stack on Vagrant (`vagrant/lemp-mono`)

A robust, production-like development environment built with **Vagrant** and **Ubuntu 22.04 LTS (Jammy Jellyfish)** that provisions a complete monolithic **LEMP Stack** (Linux, Nginx, MySQL, PHP-FPM, and Composer) with synchronized configuration overrides and built-in validation pages.

---

## Architecture & Core Features

* 🚀 **Vagrant Provisioning (`Vagrantfile` & `bootstrap.sh`):**
    * Uses the `ubuntu/jammy64` base box.
    * Forwards host port `8080` to guest port `80`.
    * Automatically sets up synchronized folders linking local custom configuration files directly into the VM’s system directories (`/etc/nginx`, `/etc/php/8.1/fpm/conf.d/custom`, `/etc/mysql/conf.d/custom`, and `/var/www`).


* 🌐 **Nginx Web Server (`etc/nginx/sites-available/99-example.conf`):**
    * Configured as a custom Virtual Host handling static content and fastcgi proxying to PHP 8.1 FPM.


* 🐘 **PHP 8.1 & Composer:**
    * Installs PHP 8.1 FPM along with essential extensions (`mysql`, `zip`, `gd`, `mbstring`, `curl`, `xml`, `bcmath`).
    * Custom runtime configurations (`etc/php/custom/99-local.ini`) adjusting upload limits, post sizes, and memory thresholds.
    * Automatically installs **Composer 2** for dependency management.


* 🗄️ **MySQL 8.0 Server:**
    * Custom server configurations (`etc/mysql/custom/99-my.cnf`) enabling general query logging and adjusting SQL modes.
    * Automatically provisions a dedicated database user (`dbuser`) with native password authentication and privileges.


* 🔍 **Built-in Validation (`html/index.php`, `html/phpinfo.php`):**
    * Includes a real-time status dashboard verifying PHP execution, live MySQL connectivity/version queries, and Composer installation status.



---

## Project Structure

```text
vagrant/lemp-mono/
├── bootstrap.sh              # Provisioning shell script (installs LEMP packages, sets up MySQL user, configures symlinks & Composer)
├── etc/
│   ├── mysql/
│   │   └── custom/
│   │       └── 99-my.cnf     # Custom MySQL overrides (general log, sql_mode)
│   ├── nginx/
│   │   └── sites-available/
│   │       └── 99-example.conf # Nginx site configuration block
│   └── php/
│       └── custom/
│           └── 99-local.ini  # Custom PHP-FPM limits (memory, upload size)
├── html/
│   ├── index.php             # Interactive validation dashboard (checks PHP, MySQL, & Composer)
│   └── phpinfo.php           # Standard PHP environment info page
├── LICENSE                   # MIT License
├── README.md                 # Project documentation
└── Vagrantfile               # Vagrant box definition, port forwarding, and synced folders

```

---

## Usage & Quick Start

### Start the Environment

```bash
vagrant up

```

### Access the Application

Open your browser and navigate to:

* **Validation Dashboard:** `http://localhost:8080`
* **PHP Info:** `http://localhost:8080/phpinfo.php`

### Connect via SSH

```bash
vagrant ssh

```

---

## Tech Stack & Software Versions

* **Virtualization:** Vagrant (`ubuntu/jammy64`)
* **Web Server:** Nginx (v1.18.0)
* **Database:** MySQL (v8.0.45)
* **Language Runtime:** PHP-FPM (v8.1.2)
* **Dependency Manager:** Composer (v2.9.7)