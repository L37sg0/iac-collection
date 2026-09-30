# Backup & Restore Scripts (`backup-scripts`)

A collection of modular, production-ready **Bash shell scripts** designed for automated file backups, MySQL database dumps within Docker environments, Slack notification integrations, and streamlined restoration workflows.

---

## Architecture & Core Features

* 🗄️ **Automated File & SQL Backups (`backup_files.sh`, `backup_sql.sh`):**
    * Archives specified project directories into compressed zip structures organized by project names and timestamped execution dates.
    * Interfaces directly with Docker containers (`${PROJECT_NAME}_db`) using `mysqldump` to stream and compress database backups securely.


* 🔄 **Restoration Workflows (`restore_files.sh`, `restore_sql.sh`):**
    * Unpacks and restores archive directories or pipes compressed SQL dumps directly into active Docker database containers (`mysql`).


* 🔔 **Slack Notification Integration (`notifications.lib`):**
    * Dynamically posts success or failure status updates to configured Slack webhook endpoints using curl payload requests upon completion.



---

## Project Structure

```text
backup-scripts/
├── backup_files.sh       # Shell script for archiving directory contents
├── backup_sql.sh         # Shell script for dumping MySQL databases from Docker containers
├── global_config.cfg     # Global configuration file for project mappings
├── globals.lib           # Variable definitions and global runtime parameters
├── notifications.lib     # Slack notification handler library
├── project_config.cfg    # Project-specific path configurations
├── README.md             # Project documentation
├── restore_files.sh      # Shell script for restoring file archives
└── restore_sql.sh        # Shell script for restoring SQL database dumps into Docker

```

---

## Usage & Command Syntax

### File Backup

```bash
./backup_files.sh -d /path/to/project

```

### SQL Backup

```bash
./backup_sql.sh -d /path/to/project

```

### File Restoration

```bash
./restore_files.sh -r /target/restore/directory -b /path/to/backup/dir

```

### SQL Restoration

```bash
./restore_sql.sh -c container_db_name -u db_user -p db_password -d db_name -b /path/to/backup/dir

```

---

## Tech Stack & Requirements

* **Environment:** Bash shell, Linux/Unix runtime
* **Dependencies:** `zip`, `unzip`, `curl`, `Docker`, `MySQL client utilities`