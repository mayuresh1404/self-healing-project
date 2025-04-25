Self-Healing Infrastructure with Prometheus, Alertmanager, and Ansible
This project implements a self-healing infrastructure that automatically detects and recovers from service failures using Prometheus for monitoring, Alertmanager for notifications, and Ansible for automated recovery. An NGINX service is monitored for downtime, and upon failure, the system triggers an Ansible playbook to restart the service, ensuring high availability.
🎯 Objective
The goal is to create a system that:

Monitors an NGINX service for uptime and system metrics.
Detects failures (e.g., NGINX downtime or high CPU usage).
Automatically recovers by restarting the service.

🛠 Tools Used

Prometheus: Monitors NGINX and system metrics.
Alertmanager: Routes alerts to a webhook.
Ansible: Executes recovery playbooks.
Docker: Runs services in containers.
NGINX: Sample web server for testing.
Flask (Python): Webhook service to trigger Ansible.
Node Exporter: Collects system metrics.
Ubuntu/Docker Desktop: Host environment.

📋 Prerequisites

Docker and Docker Compose installed.
Python 3.9+ (for webhook service).
Ansible (installed in the webhook container).
Ubuntu 20.04+ or Windows/Mac with Docker Desktop (WSL 2 recommended for Windows).
Basic knowledge of Docker, YAML, and shell scripting.

📂 Project Structure
self-healing-project/
├── ansible/
│   └── restart_nginx.yml        # Ansible playbook to restart NGINX
├── alertmanager/
│   └── alertmanager.yml         # Alertmanager configuration
├── prometheus/
│   ├── prometheus.yml           # Prometheus configuration
│   └── alert.rules.yml          # Alerting rules
├── logs/
│   ├── webhook.log              # Webhook service logs
│   └── ansible.log              # Ansible execution logs
├── nginx/
│   └── (NGINX logs at runtime)   # NGINX access/error logs
├── docs/
│   └── Self_Healing_Infrastructure_Report.pdf  # Project report
├── screenshots/                 # Optional screenshots
├── Dockerfile                   # Webhook service Docker image
├── docker-compose.yml           # Defines all services
├── webhook.py                   # Webhook service to trigger Ansible
├── requirements.txt             # Python dependencies
├── README.md                    # This file
└── .gitignore                   # Git ignore file

🚀 Setup Instructions

Clone the Repository:
git clone https://github.com/your-username/self-healing-project.git
cd self-healing-project


Start the Services:
docker-compose up -d --build

This builds the webhook service and starts NGINX, Prometheus, Alertmanager, Node Exporter, and the webhook.

Verify Services:Check running containers:
docker ps

Test services:

NGINX: curl http://localhost:8080 (returns NGINX welcome page)
Prometheus: curl http://localhost:9090 (Prometheus UI)
Alertmanager: curl http://localhost:9093 (Alertmanager UI)
Webhook: curl http://localhost:5000 (returns {"status": "success"})



🧪 Simulating a Failure
To demonstrate auto-healing:

Stop NGINX:docker stop self-healing-infra_nginx_1


Wait for Detection:
Prometheus detects NGINX downtime after 1 minute (NginxDown alert).
Alertmanager sends the alert to the webhook.


Observe Recovery:
The webhook triggers the Ansible playbook (restart_nginx.yml).
Ansible restarts NGINX.


Check Logs:
Webhook activity:cat logs/webhook.log

Example:2025-04-21 10:00:00,123 INFO Received NginxDown alert: {"status":"firing","labels":{"alertname":"NginxDown","severity":"critical"},"annotations":{"summary":"NGINX service is down","description":"NGINX service has been down for more than 1 minute."}}
2025-04-21 10:00:01,456 INFO Ansible playbook executed successfully


Ansible execution:cat logs/ansible.log

Example:{"changed": true, "container": {"Name": "self-healing-infra_nginx_1", "State": {"Status": "running"}}}




Verify NGINX:curl http://localhost:8080



📜 Deliverables

Prometheus Config: prometheus/prometheus.yml, prometheus/alert.rules.yml
Alertmanager Setup: alertmanager/alertmanager.yml, webhook.py
Ansible Playbook: ansible/restart_nginx.yml
Demo Logs: logs/webhook.log, logs/ansible.log (with example content)
Report: docs/Self_Healing_Infrastructure_Report.pdf
Screenshots (optional): In screenshots/ (e.g., Prometheus alerts, logs)

🖼 Screenshots (Optional)
Add screenshots to screenshots/ and reference them here:

Prometheus Alert: screenshots/prometheus_alert.png
NGINX Recovery: screenshots/nginx_recovery.png

![Prometheus Alert](screenshots/prometheus_alert.png)
![NGINX Recovery](screenshots/nginx_recovery.png)

🛠 Troubleshooting

Docker Errors:
Ensure Docker Desktop is running (Windows/Mac).
Use WSL 2 backend and run docker context use desktop-linux.
Reset Docker Desktop if API errors persist.


NGINX Not Recovering:
Check webhook logs: cat logs/webhook.log.
Verify Ansible in webhook container: docker exec -it self-healing-infra_webhook_1 ansible --version.


Prometheus Alerts Not Firing:
Check Prometheus UI (http://localhost:9090) for up metric.
Verify rules: http://localhost:9090/rules.


Windows Issues:
Use LF line endings for configs (set in VS Code or use dos2unix).
Run PowerShell/WSL as Administrator.



🌟 Extending the Project

Add alerts for memory or disk usage.
Implement complex recovery (e.g., scaling services).
Secure webhook with authentication.
Deploy on Kubernetes for production.

📝 Notes

Windows Users: Ensure WSL 2 is enabled in Docker Desktop. Use forward slashes in configs.
Security: In production, secure webhook and encrypt data.
Cleanup: Stop and remove containers with docker-compose down.

📚 Resources

Prometheus Documentation
Alertmanager Documentation
Ansible Docker Module
Project Report


Happy self-healing! 🚑 For issues or contributions, open a GitHub issue or pull request.
