Iris — High-Availability Web System
(Arch Linux + Ubuntu VM, HAProxy + Tailscale, Automated Sync)

📌 Author:
Raj Dangi — Architect · Engineer · Researcher

Designed, implemented, documented, and tested independently.
Acknowledgment to Jay Doshi and Purshottam Singh Thakur for early exploratory configuration support.

🚀 Overview

Iris is a reproducible high-availability infrastructure built entirely on:

Arch Linux (primary node)

Ubuntu Server VM (backup node)

HAProxy for intelligent load balancing & failover

Tailscale for private, encrypted connectivity

Rsync + mysqldump for periodic state synchronization

This project proves that reliable service continuity is achievable without cloud services or enterprise orchestration frameworks, using nothing but commodity hardware and open-source tooling.

✔ Automatic backend health detection
✔ Transparent failover and failback
✔ File + database synchronization
✔ Repeatable experiment results
✔ Full audit evidence and research documentation

✨ Features

Encrypted private overlay network via Tailscale

Primary/backup architecture

HAProxy-based failover within ~3 seconds

Automatic failback on service restoration

5-minute file sync interval

10-minute database sync interval

Reproducible artifact set (configs/scripts/logs)

IEEE-formatted research paper documenting design and results

📂 Repository Layout
Iris/
├── README.md                     → this document
├── LICENSE                       → open-source terms
├── docs/                         → paper + explanations
│   └── Iris-Paper.pdf
├── figures/                      → screenshots + evidence
│   ├── primary-node-identity.png
│   ├── backup-node-identity.png
│   ├── haproxy-conf.png
│   ├── file-sync-logs.png
│   └── db-sync-logs.png
├── config/                       → reproducible configs
│   ├── haproxy.cfg
│   ├── apache.conf
│   ├── tailscale-notes.md
│   └── cron-schedule.md
├── scripts/                      → automation logic
│   ├── sync_files.sh
│   └── sync_db.sh
├── logs/                         → verifiable execution output
│   ├── sync_files.log
│   └── sync_db.log
└── sql/                          → database artifacts
    ├── iris_db_schema.sql
    └── iris_db_test_data.sql

🔧 Deployment Guide
1. Clone Repo
git clone https://github.com/rajdangi31/iris-lamp.git
cd Iris

2. Install Dependencies

Install on both nodes:

Apache

MariaDB

HAProxy

Tailscale

3. Join Tailscale Network
sudo tailscale up --authkey=<KEY>


Verify private mesh connectivity:

tailscale ip
tailscale status

4. Deploy Website Content
sudo rsync -av webroot_snapshot_primary/ /var/www/html/

5. Apply HAProxy Configuration
sudo cp config/haproxy.cfg /etc/haproxy/haproxy.cfg
sudo systemctl restart haproxy

6. Enable Periodic Synchronization
crontab config/cron-schedule.md


This enables:

File sync every 5 minutes

DB sync every 10 minutes

📊 Results Summary
Metric	Result
Failover time	≈ 3 seconds
Failback time	≈ 5 seconds
Primary latency	~0.010s
Backup latency	~0.012s
File sync interval	5 minutes
DB replication interval	10 minutes

Screenshots, logs, and replication proof exist in docs/, figures/, and logs/.

📜 Research Publication

📄 Full IEEE-formatted project paper:
docs/Iris-Paper.pdf

Includes:

Motivation

System architecture

Implementation

Evaluation

Results

Lessons learned

🙏 Acknowledgments

Anushka Sharad Kumavat — manuscript review assistance

Jay Doshi — early HAProxy exploration

Purshottam Singh Thakur — initial multi-node VM testing

All system design, automation, failover logic, infrastructure setup, debugging, diagrams, and research reporting were performed independently by Raj Dangi.

📬 Contact

📧 rdangi@rockets.utoledo.edu


🏛️ University of Toledo

✔ Final Author Notes

Artifacts originate from live systems:

apache.conf → exported from /etc/httpd/conf/httpd.conf

cron-schedule.md → output of crontab -l

tailscale-notes.md → install + addressing notes

iris_db_schema.sql → mysqldump --no-data iris_db

iris_db_test_data.sql → mysqldump --no-create-info iris_db

Version-controlled evidence ensures reproducibility and credibility.
