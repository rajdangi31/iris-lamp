# Iris — High-Availability Web System (Arch Linux + Ubuntu VM)

📌 **Author:**  
**Raj Dangi** — Architect, Engineer, Researcher

> Designed and implemented independently.  
> Acknowledgment to **Jay Doshi** and **Purshottam Singh Thakur** for early exploratory configuration support.

---

## 🚀 Overview

Iris is a reproducible high-availability infrastructure built entirely on:

- Commodity hardware
- Arch Linux (primary node)
- Ubuntu Server VM (backup node)
- HAProxy for failover and routing control
- Tailscale private mesh networking
- Automated data synchronization

This project demonstrates that **reliable service continuity can be achieved without cloud providers or enterprise clustering frameworks**.

✔ ~3-second failover  
✔ ~5-second recovery  
✔ Negligible latency penalty  
✔ Proven DB + file consistency  

---

## 📌 Features

- Private encrypted overlay networking
- Node health detection and traffic rerouting
- Automatic failover + failback
- Periodic file replication
- Periodic database replication
- Verifiable test logs and screenshots
- IEEE-formatted research paper documenting methodology and results

---

## 📂 Repository Contents

Iris/
├── README.md → this document
├── LICENSE → open-source terms
├── docs/ → paper + diagrams
│ ├── Iris-Paper.pdf
├── figures/ → screenshots of results
│ ├── primary-node-identity.png
│ ├── backup-node-identity.png
│ ├── haproxy-conf.png
│ ├── file-sync-logs.png
│ └── db-sync-logs.png
├── config/ → reproducible configuration artifacts
│ ├── haproxy.cfg
│ ├── apache.conf
│ ├── tailscale-notes.md
│ ├── cron-schedule.md
├── scripts/ → automation logic
│ ├── sync_files.sh
│ ├── sync_db.sh
├── logs/ → evidence that system ran
│ ├── sync_files.log
│ └── sync_db.log
├── webroot_snapshot_primary/ → application state before failover
├── webroot_snapshot_backup/ → synchronized backup copy
└── sql/ → database export + seed state
├── iris_db_schema.sql
└── iris_db_test_data.sql


---

## 🖥️ Architecture Diagram

<p align="center">
  <img src="docs/architecture-diagram.png" width="600">
</p>

---

## 🔧 Deployment Guide

### 1. Clone

```bash
git clone https://github.com/YOUR_USERNAME/Iris.git
cd Iris

2. Install dependencies

Apache, MariaDB, HAProxy, Tailscale.

3. Join tailscale network
sudo tailscale up --authkey=<KEY>

4. Deploy webroot
sudo rsync -av webroot_snapshot_primary/ /var/www/html/

5. Apply HAProxy config
sudo cp config/haproxy.cfg /etc/haproxy/haproxy.cfg
sudo systemctl restart haproxy

6. Import database
mysql -u iris_user -p iris_db < sql/iris_db_schema.sql
mysql -u iris_user -p iris_db < sql/iris_db_test_data.sql

7. Enable cron automation
crontab config/cron-schedule.md

📊 Results Summary

Failover: ~3 seconds

Failback: ~5 seconds

Primary latency: 0.010s

Backup latency: 0.012s

Files synced within 5 minutes

Database replicated within 10 minutes

Screenshots and logs verifying these results are in /docs and /figures.

📜 Research Publication

Full IEEE-formatted project report:

📄 docs/Iris_Paper.pdf

🙏 Acknowledgments

Anushka Sharad Kumavat for reviewing and helping me out with the paper.

Early exploratory HAProxy + sync work supported by:

Jay Doshi

Purshottam Singh Thakur

All system implementation, architecture design, automation logic, validation, results, diagrams, and research writing done by Raj Dangi.

📬 Contact

📧 rdangi@rockets.utoledo.edu

🏛️ University of Toledo



---

---

# ✔ Final Notes

You now know:

### Where EACH missing file comes from
✔ apache.conf → copy from `/etc/httpd/conf/httpd.conf`  
✔ cron-schedule.md → output of `crontab -l`  
✔ tailscale-notes.md → your install + IP notes  
✔ iris_db_schema.sql → `mysqldump --no-data`  
✔ iris_db_test_data.sql → `mysqldump --no-create-info`

### How to commit them

```bash
git add config scripts sql docs logs figures
git commit -m "Added configs, schema, docs & evidence"
git push
