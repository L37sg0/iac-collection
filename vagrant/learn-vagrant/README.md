# Terramino Go on Vagrant (`vagrant/learn-vagrant`)

A local development and virtualization project using **Vagrant** to provision an Ubuntu 24.04 environment configured for containerized execution of **Terramino**—a Go and Docker-based Tetris demo application originally created by HashiCorp Education.

---

## Architecture & Core Features

* **Vagrant Provisioning (`Vagrantfile`):**
    * Spins up an official Ubuntu 24.04 box (`hashicorp-education/ubuntu-24-04`).
    * Forwards application ports (`8080`, `8081`) to the host machine for seamless web browser testing.
    * Synchronizes local and VM project directories.
    * Provides granular provisioning hooks for starting, restarting, and fully rebuilding containers (`start-terramino`, `restart-terramino`, `reload-terramino`).


* 🐳 **Dependency Automation (`install-dependencies.sh`):**
    * Installs Docker CE, Docker Buildx, and Docker Compose plugins.
    * Clones and checks out the containerized branch of the `terramino-go` repository.
    * Generates helper scripts (`/usr/local/bin/reload-terramino`) and convenience shell aliases (`play`, `reload`) for developer convenience.


* 🧩 **Terramino Application Structure (`terramino-go/`):**
    * **Backend & CLI:** Built with Go (`cmd/cli/`, `internal/game/`, `internal/highscore/`) powering game logic, board state, and terminal play capabilities.
    * **Frontend & Web:** Served via Nginx (`nginx.conf`, `Dockerfile.frontend`, static web assets in `web/`) providing a browser-playable interface.
    * **Orchestration:** Containerized via `docker-compose.yml` and multi-stage Dockerfiles (`Dockerfile.backend`, `Dockerfile.frontend`).



---

## Project Structure

```text
vagrant/learn-vagrant/
├── install-dependencies.sh        # Shell provisioner script for Docker, Compose, and repository setup
├── terramino-go/                  # Terramino Go Tetris application source & container configs
│   ├── cmd/cli/main.go            # CLI entrypoint for terminal gameplay
│   ├── internal/                  # Go internal packages (game board, scoring, client)
│   ├── web/                       # Frontend static assets (HTML, CSS, JS, graphics)
│   ├── docker-compose.yml         # Multi-container composition for backend & Nginx frontend
│   ├── Dockerfile.backend         # Container image definition for Go backend
│   ├── Dockerfile.frontend        # Container image definition for web/Nginx frontend
│   └── nginx.conf                 # Nginx server configuration
└── Vagrantfile                    # Vagrant configuration defining box specs, ports, and provisioners

```

---

## Usage & Commands

### 1. Bring Up the Environment

```bash
vagrant up

```

### 2. Start Terramino Containers (First Time)

```bash
vagrant provision --provision-with start-terramino

```

### 3. Management & Utility Aliases (Inside VM via `vagrant ssh`)

* Play via CLI: `play`
* Rebuild and reload containers: `reload` (or `vagrant provision --provision-with reload-terramino`)
* Quick restart without rebuilding: `vagrant provision --provision-with restart-terramino`

---

## Tech Stack & Requirements

* **Virtualization:** Vagrant, VirtualBox / KVM / compatible provider
* **OS Box:** Ubuntu 24.04 (`hashicorp-education/ubuntu-24-04`)
* **Containerization:** Docker, Docker Compose v2
* **Application Languages:** Go, JavaScript, HTML5, CSS3, Nginx