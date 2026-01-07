
# � Advanced DevOps Scripting Goals (Target: Day 24)

I want to build scripts that solve REAL enterprise problems using `az` and `kubectl`:

1.  **AKS Cluster Auto-Scaler & Cost Watchdog** 📉
    *   **Goal:** Optimize Azure Kubernetes Service costs in Non-Prod environments.
    *   **Logic:** 
        - Iterate through all AKS clusters in a subscription (`az aks list`).
        - Check Node Pool utilization using `kubectl top nodes` (require jq to parse JSON).
        - If CPU < 10% for 4 hours, scale down the User Node Pool to 0.
        - Send a Slack notification saying "Dev Cluster Paused to Save $$$".

2.  **Kubernetes "Governance" Auditor** 👮‍♂️
    *   **Goal:** Ensure cluster hygiene and security best practices.
    *   **Logic:**
        - Scan all Namespaces.
        - **Alert 1:** Pods without `resources.requests` and `limits` defined.
        - **Alert 2:** Deployments missing `livenessProbe` or `readinessProbe`.
        - **Alert 3:** Secrets stored as Environment Variables (instead of mounted volumes).
        - Generate a CSV report: `namespace,pod_name,violation_type`.

3.  **Cross-Region Azure DR Syncer** 🔄
    *   **Goal:** Automate Disaster Recovery for critical config files.
    *   **Logic:**
        - Watch a local directory of "Terraform State/Configs".
        - Detect changes (checksum MD5).
        - Upload to **Primary Region** Blob Storage (`az storage blob upload`).
        - Immediately trigger an async copy to **Secondary Region** (`az storage blob copy start`).
        - Verify integrity of both copies before exiting.

--------------------------------------------------------------------------------
*These projects require mixing Bash logic with JSON parsing (jq) and CLI tools (az, kubectl).*
