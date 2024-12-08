---
title: "DevOps Monitoring Project"
datePublished: Sun Dec 08 2024 17:01:48 GMT+0000 (Coordinated Universal Time)
cuid: cm4fupgao00010akx47q8grqn
slug: devops-monitoring-project
cover: https://cdn.hashnode.com/res/hashnode/image/upload/v1733677169561/9bb82164-863f-481a-bee2-bf7bf1a79cd1.jpeg
ogImage: https://cdn.hashnode.com/res/hashnode/image/upload/v1733677291701/0a42bcb4-efcc-4d35-8da9-7848bcbff218.jpeg
tags: aws, prometheus, alertmanager, devops-articles, blackbox-exporter, monitoring-tool, monitoring-using-prometheus-and-grafana-on-aws-ec2, alarmmanager

---

In this technical guide, we'll set up a robust monitoring solution for EC2 instances running Ubuntu OS. This project incorporates Prometheus, Alertmanager, Node Exporter, and Blackbox Exporter for effective monitoring and alerting.

## Understanding the Flow Diagram

![](https://cdn.hashnode.com/res/hashnode/image/upload/v1733677196721/0ef9bb2d-f075-4e5e-95c2-d6ec02a58302.jpeg align="center")

### Components and Their Roles

#### VM-1:

**Node Exporter:**

* Installed on VM-1 to expose system metrics such as CPU usage, memory usage, and disk space in a format that Prometheus can scrape.
    

**Nginx:**

* A web server running on VM-1 that serves as an HTTP endpoint for testing availability and performance using Blackbox Exporter.
    

#### VM-2:

**Prometheus:**

* **Metrics Collection:**
    
    * Continuously scrapes metrics from Node Exporter on VM-1 and system services like Nginx.
        
    * Retrieves external probes and HTTP status checks from Blackbox Exporter.
        
* **Alert Rules Evaluation:**
    
    * Processes the collected metrics based on pre-defined rules (e.g., detecting high memory usage or service unavailability).
        
* **Data Flow:**
    
    * Metrics from Node Exporter and Blackbox Exporter are combined for real-time analysis and visualization.
        

**Blackbox Exporter:**

* Used for probing external targets like HTTP endpoints (e.g., Nginx) to check availability and performance.
    
* Sends probe success or failure metrics back to Prometheus.
    

**Alertmanager:**

* **Alert Routing:**
    
    * Receives alerts from Prometheus when certain thresholds or conditions are breached (e.g., service downtime, high CPU usage).
        
    * Routes these alerts to configured notification channels (e.g., email).
        
* **Inhibition Rules:**
    
    * Suppresses less critical alerts when higher-priority alerts are active, ensuring relevant notifications are sent.
        

**Email Notifications:**

* Alertmanager integrates with an email system (e.g., Gmail).
    
* Sends email alerts to notify administrators about critical issues like service downtime or resource exhaustion.
    

---

### Prerequisites

* **Install Required Tools:** Ensure that `wget` and `tar` are installed on both VMs.
    
* **Permissions:** Ensure you have permissions to download, extract, and run the binaries.
    
* **Networking:** Configure the firewall to allow the following ports:
    
    * Prometheus: `9090`
        
    * Alertmanager: `9093`
        
    * Blackbox Exporter: `9115`
        
    * Node Exporter: `9100`
        

---

### Setup Steps

#### 1\. Create 2 EC2 Instances

* Use `t2.medium` instances with 20GB storage and Ubuntu OS.
    
    ![](https://lh7-rt.googleusercontent.com/docsz/AD_4nXd5xqp4Rm35poUFmdHMSjRUv0Lm5SC1eN-aKDQLHPbAYrlR-g1chzskRiwTWLlg7pdl02RVrvU-BjxMHDo8rE2OLeNTNQVmzHatycJOCcCXtwD3FiRFhhuz5vfwsiZlbbxoaImvsQ?key=1AGqCMx2-TnUzEkI4-dlT5Di align="left")
    

**VM-1:**

* **Services:** Node Exporter, Nginx.
    

**VM-2:**

* **Services:** Prometheus, Alertmanager, Blackbox Exporter.
    

---

### Node Exporter Setup (VM-1)

**Update the Packages:**

```bash
sudo apt update -y
```

![](https://lh7-rt.googleusercontent.com/docsz/AD_4nXcWa7QJWbBwPMJnRDc6qfuKVvQW577Jmc9dGNX-0ECgFHQt7MJTyLHVoVNAyYB_ikOpVxUTWFVC8ndIZJwXT8up3MiOf2W_D4SffqMhDm60sIbMRiwU-sWzBNi6FQagnPCiS3wJ?key=1AGqCMx2-TnUzEkI4-dlT5Di align="left")

**Download Node Exporter:**

```bash
wget https://github.com/prometheus/node_exporter/releases/download/v1.8.1/node_exporter-1.8.1.linux-amd64.tar.gz
```

![](https://lh7-rt.googleusercontent.com/docsz/AD_4nXdS5P1rk8UxBQnMuMvlztZk9Orn7wuISBtnuD_BFj_MkoVl5GyxWVvXM4EQPgVz1o2pveTTt_g1aerjt_-Q_Nf7RBJzatmPI9oU1URirwoswZSPVj42ERDRGuY_2sb6xKZ-VR7B7A?key=1AGqCMx2-TnUzEkI4-dlT5Di align="left")

**Extract Node Exporter:**

```bash
tar xvfz node_exporter-1.8.1.linux-amd64.tar.gz
```

![](https://lh7-rt.googleusercontent.com/docsz/AD_4nXdRgmQK6bNbEcBnXFTDUDwqCDaVNUz8zC-5oN31htmC3P_Cr3IBfhaDfP8vnJQ-4kSgpBLJyOK_ZT2jZa5Uaen7iun_iyb_CQ3FJqTII5RSfoijDo0OyCY1Ee9KEJ_02yTNGRX7ZA?key=1AGqCMx2-TnUzEkI4-dlT5Di align="left")

**Set Up Node Exporter as a Systemd Service:**

* **Create a Service File:**
    

```bash
sudo vim /etc/systemd/system/node_exporter.service
```

* **Configuration:**
    

```plaintext
[Unit]
Description=Node Exporter
After=network.target

[Service]
User=ubuntu
ExecStart=/home/ubuntu/node_exporter-1.8.1.linux-amd64/node_exporter

[Install]
WantedBy=multi-user.target
```

* **Reload and Enable the Service:**
    

```bash
sudo systemctl daemon-reload
sudo systemctl enable node_exporter
sudo systemctl start node_exporter
```

**Check Service Status:**

```bash
sudo systemctl status node_exporter
```

![](https://lh7-rt.googleusercontent.com/docsz/AD_4nXf4xnra5p97KedcZVfJZUNhTVoA1rMQjDz-L4i1WCy8fx9VLWXNy9eJukeG-nBIm_tJOph6FSi4-8iHANLHtHiBDMEMcwNcUjRJqP-aRz5TUsmOecFxqZQlP-DeZtP8oWn3OgsUqA?key=1AGqCMx2-TnUzEkI4-dlT5Di align="left")

**Verify Node Exporter:** Access `http://<public-ip>:9100`

![](https://lh7-rt.googleusercontent.com/docsz/AD_4nXcCxARvUCo3UuxJHtZBdxTtSvG3iUneNGwlU56M_ib7d5iS9_gtaPXhrvF7XaFeabGRI2Olqja0TYPGJNjWK-qVT2RoE2--dug2_RZRMGAJ31seB7M4n-7qnQBoICZUthIPEK_KvQ?key=1AGqCMx2-TnUzEkI4-dlT5Di align="left")

---

### Prometheus Setup (VM-2)

**Update the Packages:**

```bash
sudo apt update -y
```

![](https://lh7-rt.googleusercontent.com/docsz/AD_4nXe0odlPflR1CVNE7rTZBL_e2iYzT7cckq5uVHzXXSTbA-4Q2vottqZwiWsh3wQLD9xCfPEU39BrQxe6RAAivGSTGxeLGC4oc2EWppThHbLFEy2n5uScJgDJXy1HkfXknJ2rCx3mxw?key=1AGqCMx2-TnUzEkI4-dlT5Di align="left")

**Download Prometheus:**

```bash
wget https://github.com/prometheus/prometheus/releases/download/v2.52.0/prometheus-2.52.0.linux-amd64.tar.gz
```

![](https://lh7-rt.googleusercontent.com/docsz/AD_4nXeOoVZmjuQwhmMOImJSNN8ZmT7OCWSf5wAIpq-pUKYbLma5SxRnld0To_vdNxDdHAr4AU6BZgZc-C-ltBD4CEBi7rVUYuS20RxeMa2cKnaCCC71-ITkeE8Cx_YerhgwSyYYwO7o-g?key=1AGqCMx2-TnUzEkI4-dlT5Di align="left")

**Extract Prometheus:**

```bash
tar xvfz prometheus-2.52.0.linux-amd64.tar.gz
```

![](https://lh7-rt.googleusercontent.com/docsz/AD_4nXf88M7_fuI-r1aPMN_lo7NFw6CP5lEbRoVWQuJCiLcyWTTuLwBY3QYo3NtGuNPDsVC5_8xrqe5xZpszt7r7BcHgNCJZpXAcMUvvM08DmG-5VyD21xDNHp5RgyQVspiq31A-NmPu?key=1AGqCMx2-TnUzEkI4-dlT5Di align="left")

**Move Files and Configure:**

```bash
sudo mv prometheus-2.52.0.linux-amd64/prometheus /usr/local/bin/
sudo mv prometheus-2.52.0.linux-amd64/promtool /usr/local/bin/
```

![](https://lh7-rt.googleusercontent.com/docsz/AD_4nXcGYt83yd0q6_6Ryjdj2DOH9Hnb_6vNDmTo2O3CtNhYzXrMgCehDDjxec0TCq35zvUj-o5vdoosuiScYrwZPtezc99YvDjSDdzHZror25atNNHS2SgxvUGimukHu5344oBQNbh0ag?key=1AGqCMx2-TnUzEkI4-dlT5Di align="left")

![](https://lh7-rt.googleusercontent.com/docsz/AD_4nXf55Z_FUYktxGqc4X6gQjP80vUVNDoypKOwNZbPhJ8-ZoFgFEjGwVE6W1Ds_UtB1-W1iP73GcS5VJcnynpX4xSQWbwLLxxKJitkJ_Khn_Yn4siqFa5sIGiBp372mIVPn6cT-Amz?key=1AGqCMx2-TnUzEkI4-dlT5Di align="left")

**Create Prometheus User and Directories:**

```bash
sudo useradd --no-create-home --shell /bin/false prometheus
sudo mkdir /etc/prometheus
sudo mkdir /var/lib/prometheus
sudo chown prometheus:prometheus /etc/prometheus /var/lib/prometheus
```

![](https://lh7-rt.googleusercontent.com/docsz/AD_4nXd--NGcvOhV3uXZ8D5so-Qc8JqFSty6dlBpsCery87ty9tWwcqivXiBKtbrScvH8VMEwGzGjTKeoraVQmFVFYhyuXE7w2y6pYSuv77kaJT97Z2GDO61Tt28OHtOZHkcDDYiUKiJOA?key=1AGqCMx2-TnUzEkI4-dlT5Di align="left")

![](https://lh7-rt.googleusercontent.com/docsz/AD_4nXc7jiW9cECzj6G5hBoaPf6eC1G04MoN-OQEKXleYxXBoQu8c7RFOcJmmNRNqPYcdD6P40H31N3f7lvWeyYI-kT0uLj7JDsC4xA_WXhoHPCLUPFZKSed35xCgWilr3D2xOMo2xHsPw?key=1AGqCMx2-TnUzEkI4-dlT5Di align="left")

**Copy the Configuration File:**

```bash
sudo cp prometheus-2.52.0.linux-amd64/prometheus.yml /etc/prometheus/prometheus.yml
sudo chown prometheus:prometheus /etc/prometheus/prometheus.yml
```

![](https://lh7-rt.googleusercontent.com/docsz/AD_4nXdH_VPWj61O2EVC7e8HJiiAB3Nf9OHGNVkmCz2ST-X1mt7Cc1p2rE6emfF5zjkNrfetFjXAyWUyKAK439SDk3EcwDmTDLECIfoM3VPmrYj2tXDu405wp9eMH8UQC-BsNuTeGkiTJg?key=1AGqCMx2-TnUzEkI4-dlT5Di align="left")

![](https://lh7-rt.googleusercontent.com/docsz/AD_4nXfsMyjZYiPKnxsYH0vUocgfyZrRolBgCtQ6qMRBYo6kEjy7aViBBpP97ud0eRjuOaLjigsXTLOVXaPhWBZBwOfg6ShrKq5RV13n6UILS5ZoPpWPMa-EBt4mFLTTw1m0_WYKX17M?key=1AGqCMx2-TnUzEkI4-dlT5Di align="left")

**Set Up as a Systemd Service:**

* **Create a Service File:**
    

```bash
sudo vim /etc/systemd/system/prometheus.service
```

* **Configuration:**
    

```plaintext
[Unit]
Description=Prometheus
Wants=network-online.target
After=network-online.target

[Service]
User=prometheus
Group=prometheus
ExecStart=/usr/local/bin/prometheus --config.file=/etc/prometheus/prometheus.yml --storage.tsdb.path=/var/lib/prometheus/

[Install]
WantedBy=multi-user.target
```

* ![](https://lh7-rt.googleusercontent.com/docsz/AD_4nXfESxEpZe3btoetxAodY_XZjqlzUuUu9JyZ-LLSNZ9lA3jY9dqHO-X6WasjtivDz8L1n3io2EVGLxm9CEGKEKKJfRHCcIWE_IS3_FnLQUWckNU8YGxpE7Q3gBdmzPy5JzFklTtK?key=1AGqCMx2-TnUzEkI4-dlT5Di align="left")
    
    **Reload and Enable the Service:**
    

```bash
sudo systemctl daemon-reload
sudo systemctl enable prometheus
sudo systemctl start prometheus
```

![](https://lh7-rt.googleusercontent.com/docsz/AD_4nXd8mzLMeLGMch11dHp67I9IvDkpy382runZ6KSZSUNAAR-HT-EQ39VE6Q0g5huapJ-7wsULREBiodt6BUQiw0hWQ4mr1NxIxiA0VOmiuYggZ5EXiE9qjeJz5G_a0BYW6R0XCNv-pg?key=1AGqCMx2-TnUzEkI4-dlT5Di align="left")

**Access Prometheus Web Interface:** `http://<your-ec2-public-ip>:9090`

![](https://lh7-rt.googleusercontent.com/docsz/AD_4nXc9NZFIY9CSQhJo9HGW9lP56-g-FihIjGTAHTzonFL30G_MpSG3MTHx9fqV2qsEvrFweliD7AACKjGQUPIifnZBxHvdfeQRs2UD6KMqzFcLeuQAZHMlMJ7R_vhkSDxEu7we51I5UQ?key=1AGqCMx2-TnUzEkI4-dlT5Di align="left")

**Check Logs (Optional):**

```bash
journalctl -u prometheus -f
```

---

### Alertmanager Setup (VM-2)

#### Download and Install Alertmanager

**Download Alertmanager:**

```bash
wget https://github.com/prometheus/alertmanager/releases/download/v0.27.0/alertmanager-0.27.0.linux-amd64.tar.gz
```

![](https://lh7-rt.googleusercontent.com/docsz/AD_4nXdUlsaib_CZVlDFKSxWpxK9YINvBVIJi9Ik6uNRujVo0VDTAWRT3CWsZK64YFn7RRfuuTdcNYg74Z1pTotit3CKM5N5kXNKWYpXTQmxcPSwm5Dnf_GDa4ZyrUOmwxhJNEJjYirWMg?key=1AGqCMx2-TnUzEkI4-dlT5Di align="left")

**Extract Alertmanager:**

```bash
tar xvfz alertmanager-0.27.0.linux-amd64.tar.gz
```

![](https://lh7-rt.googleusercontent.com/docsz/AD_4nXdH_2wWAP9Vuxh9tMtT8lGr75DL2T6FcqaKgr6PSUk77peOMsztiA1co1dFvBkch-M8dUo9gNQ6UhE6YukMuGS-MOfsFJ2wcTMdE61lwcX_fqH0q_gIn6yCTWg3fG1W-pQHvWSD?key=1AGqCMx2-TnUzEkI4-dlT5Di align="left")

**Move Alertmanager Binaries:**

```bash
sudo mv alertmanager-0.27.0.linux-amd64/alertmanager /usr/local/bin/
sudo mv alertmanager-0.27.0.linux-amd64/amtool /usr/local/bin/
```

![](https://lh7-rt.googleusercontent.com/docsz/AD_4nXdckfgdL98qjMuXDXiW0p9YOXnmLObQKegdB3bJ6UFlodaNScgxmlq-ccY_eJQXGBoNMcdKk_zFJctxFf1jbl2JEnrSxN_dfOQW-wsHY8_0LhKs07vt111d02y8mPlywVtJxoOiew?key=1AGqCMx2-TnUzEkI4-dlT5Di align="left")

#### Create Alertmanager User and Directories

**Create a Dedicated User:**

```bash
sudo useradd --no-create-home --shell /bin/false alertmanager
```

![](https://lh7-rt.googleusercontent.com/docsz/AD_4nXeDF7bhq2slAArDx87ydJkMfS8gfaT38WaPEQASBawHXXVUiXpI-uzno5QyOWm16jMsVzEhTk8lDPxQp6Bqdrp5uIrtQvAY9tEwy6il-_GLTQcaQyxVyebItJV6hw4QuVbfA7JgHg?key=1AGqCMx2-TnUzEkI4-dlT5Di align="left")

**Create Directories for Data and Configuration:**

```bash
sudo mkdir /etc/alertmanager
sudo mkdir /var/lib/alertmanager
sudo chown alertmanager:alertmanager /etc/alertmanager /var/lib/alertmanager
```

![](https://lh7-rt.googleusercontent.com/docsz/AD_4nXdNZrfwOFub0-fnMQs-VgmE3jFT8-RdcNV3I4fro1EwKT-qbjDoxqJsH7B2crBCTk7R1p0TgeVr19GgqQyTD0t8lGAeu0fisVCavrD_bJJq0rFEJFwxFTsYOER2ewCliOx1qcJktw?key=1AGqCMx2-TnUzEkI4-dlT5Di align="left")

![](https://lh7-rt.googleusercontent.com/docsz/AD_4nXesaE3NK3LXLo5B4V5l5b0AUR6fg8tpw6ZpMCxFpsSPizgGOckEufAyc0AMAiLLUSw1E7DdifcE5pedqDgj8TqP8hc3jkNcCqGY2Xk0-ZQQLpGCYzYtd9jeqCgwRB3QeWrZXq_RTA?key=1AGqCMx2-TnUzEkI4-dlT5Di align="left")

#### Configure Alertmanager

**Move Configuration File:**

```bash
sudo mv ~/alertmanager-0.27.0.linux-amd64/alertmanager.yml /etc/alertmanager/
sudo chown alertmanager:alertmanager /etc/alertmanager/alertmanager.yml
```

#### Create a Systemd Service for Alertmanager

**Create the Service File:**

```bash
sudo vim /etc/systemd/system/alertmanager.service
```

![](https://lh7-rt.googleusercontent.com/docsz/AD_4nXfKOvIrps5yBpqThByeQVL7DxQwSj1tML8Hz7u7oR-fSfaJIz6qVjCLWoWA4Z8gW7N0KNqkeDSA7eNKlY8jbxbGOkNECZ_U8clLaImu-gyvYpuH6evj7KFE2u8Sw7PkJP38mtJp8A?key=1AGqCMx2-TnUzEkI4-dlT5Di align="left")

**Add the Following Configuration:**

```plaintext
[Unit]
Description=Alertmanager
Wants=network-online.target
After=network-online.target

[Service]
User=alertmanager
Group=alertmanager
ExecStart=/usr/local/bin/alertmanager --config.file=/etc/alertmanager/alertmanager.yml --storage.path=/var/lib/alertmanager/

[Install]
WantedBy=multi-user.target
```

![](https://lh7-rt.googleusercontent.com/docsz/AD_4nXdZHc1gLt8sFt7FmjN4Hk5PxOmQGMxuRMHS2kE1ci_qdAKpnc_6-U5pQIMLk-s5S6hDiEeu37L2Gxg9zzcLOa8rDk9Nkejr60ys7r_GzV3oJRc8Q3ZoIisUWPyN8IIBAEOWpshlEg?key=1AGqCMx2-TnUzEkI4-dlT5Di align="left")

#### Start and Enable Alertmanager

**Reload Systemd Configuration:**

```bash
sudo systemctl daemon-reload
```

**Start the Service:**

```bash
sudo systemctl start alertmanager
```

**Enable the Service:**

```bash
sudo systemctl enable alertmanager
```

**Check Service Status:**

![](https://lh7-rt.googleusercontent.com/docsz/AD_4nXdGjwoX4MU3-xL47rc1xsVNTWQQzClMkqR3rqUUtF04ko73D4pVz6GQTxRQPvZN6OFEy0P-Tnin4K4SxTAT-6Kwq0yHE9myUiZHMOXfKQK7Qq56aws31CTd5uUh1Jmy_kuWqcgd?key=1AGqCMx2-TnUzEkI4-dlT5Di align="left")

```bash
sudo systemctl status alertmanager
```

![](https://lh7-rt.googleusercontent.com/docsz/AD_4nXdAo2Zbxa1sfeWh0y2ciXYnFxTyWkMeC3hPBHemQyTPXxTYn9i2ByGyri19F3plYB3cqB3XpJPbpr0nBZOTrvUXP7awlHGaVOpyXGw77a8Jj6KlFfRiKhBLYskG9scRZadNxn-L?key=1AGqCMx2-TnUzEkI4-dlT5Di align="left")

### Setting Up Blackbox Exporter

#### Step 1: Download Blackbox Exporter

```bash
wget https://github.com/prometheus/blackbox_exporter/releases/download/v0.25.0/blackbox_exporter-0.25.0.linux-amd64.tar.gz
```

![](https://lh7-rt.googleusercontent.com/docsz/AD_4nXf4TAXqcbHmUI3ItxwM6J0wyEakOuYBAHIfCip_zYYjiJ0A21KRrMm0ojbxpcTPU1I-8tf8k8BQFueAseQ-SAbLAUPdtMFFsDwpxQAgRdqfeg6hNJRgOIYala9LwKiS_VE2fJHAsg?key=1AGqCMx2-TnUzEkI4-dlT5Di align="left")

#### Step 2: Extract Blackbox Exporter

```bash
tar xvfz blackbox_exporter-0.25.0.linux-amd64.tar.gz
```

![](https://lh7-rt.googleusercontent.com/docsz/AD_4nXc6uSbHJCN0OLUqftzT6BRJc4ZwCWLhJ4JSXQhAy4zkp5WFXcm_iahutNE4lAF6OdJ7M5FXWJvPmHmnr05J0VSOmtLzv3UcKYmr2H1Ez93TtB7q5jkITiU9gVopbXkX8FDHusrT5Q?key=1AGqCMx2-TnUzEkI4-dlT5Di align="left")

#### Step 3: Move Files to `/usr/local/bin`

```bash
sudo mv blackbox_exporter-0.25.0.linux-amd64/blackbox_exporter /usr/local/bin/
```

![](https://lh7-rt.googleusercontent.com/docsz/AD_4nXcOgxia6_FAYVQF2H4B40k8_pFE_pL8fITnhuWxqys0U8UZjs4soa6TjDXxqfTOMu6OBRkce8pti1dv-JpBw3RQiFC2Dp5dmcFt8d1OvF_plrP77kS7Dq7sy6ciATTB24T22iQG?key=1AGqCMx2-TnUzEkI4-dlT5Di align="left")

#### Step 4: Create a Dedicated User to Run the Exporter

```bash
sudo useradd --no-create-home --shell /bin/false blackbox_exporter
```

![](https://lh7-rt.googleusercontent.com/docsz/AD_4nXcUnc_uS-_UH5cHHFwxY_iYFqoXmeAsivBSlaq07GbV62E4swFRlFpFetTONa35yqgCX5IfrJufdEGm7gpdIdhhUNtsMrBtgrTZXnHTs5icf8os-wT2XYlXzbGdBUKQYsrkfxqv?key=1AGqCMx2-TnUzEkI4-dlT5Di align="left")

#### Step 5: Set Up Configuration Directory

1. Create the directory:
    
    ```bash
    sudo mkdir /etc/blackbox_exporter
    ```
    
2. Move the configuration file (if required):
    
    ```bash
    sudo mv blackbox_exporter-0.25.0.linux-amd64/blackbox.yml /etc/blackbox_exporter/
    ```
    
3. Set proper permissions:
    
    ```bash
    sudo chown blackbox_exporter:blackbox_exporter /etc/blackbox_exporter -R
    ```
    

![](https://lh7-rt.googleusercontent.com/docsz/AD_4nXeU3j1peyICF3m1M5bAGoVqC9Zns_Cnwr2AuhvRRFEuWrgpIcq754IkHpZ6tG1yTvQuOS2RTerrf3FfY5Xceo6XHs9NRS2p3Rkd_V_su6u_DwPzqob68g19ua8QaH2IWdTdNP6YZA?key=1AGqCMx2-TnUzEkI4-dlT5Di align="left")

#### Step 6: Create a Systemd Service File

1. Open a new systemd service file:
    
    ```bash
    sudo vim /etc/systemd/system/blackbox_exporter.service
    ```
    
2. Add the following content:
    
    ```ini
    [Unit]
    Description=Blackbox Exporter
    Wants=network-online.target
    After=network-online.target
    
    [Service]
    User=blackbox_exporter
    Group=blackbox_exporter
    Type=simple
    ExecStart=/usr/local/bin/blackbox_exporter \
      --config.file=/etc/blackbox_exporter/blackbox.yml
    
    [Install]
    WantedBy=multi-user.target
    ```
    

![](https://lh7-rt.googleusercontent.com/docsz/AD_4nXegZNvfqzovXgiMrge6IN7cHZec98cfWNEg3WDorEvy4VJ10dO1iNB2LdzUzddGp_Z_KKY7qCo50-3Tx6fxqLBrkrozEJp8nXZ3V0YSIU2kniDFtfAFb2qLKStNaZDAIarLMVoY?key=1AGqCMx2-TnUzEkI4-dlT5Di align="left")

#### Step 7: Reload Systemd and Start the Service

1. Reload systemd to recognize the new service:
    
    ```bash
    sudo systemctl daemon-reload
    ```
    
2. Start the Blackbox Exporter service:
    
    ```bash
    sudo systemctl start blackbox_exporter
    ```
    
3. Enable the service to start on boot:
    
    ```bash
    sudo systemctl enable blackbox_exporter
    ```
    

#### Step 8: Verify the Installation

1. Check the service status:
    
    ```bash
    sudo systemctl status blackbox_exporter
    ```
    
2. Test that the exporter is working by accessing it on its default port (9115):
    
    ![](https://lh7-rt.googleusercontent.com/docsz/AD_4nXcLcfSQBgDV6uXMWV_Q3YPPBgU5O-Asj2r_h4NLiRu--r5p9z3KfpFG3k5m4MMQl_NE8nVo0fKrba37TN8sag52OLbCyJA4H51qfucou25HfztuIJ7sRvhAjf_T8qdBv9xx2U0OEA?key=1AGqCMx2-TnUzEkI4-dlT5Di align="left")
    
    ```bash
    curl http://localhost:9115/metrics
    ```
    

![](https://lh7-rt.googleusercontent.com/docsz/AD_4nXeE68oy_6Q8psTNFPadq7Q6jkg3akMPwgg3kLRBIyurgO49WOUyJvpkNl5Enw2fLm4EDOj1P33VRbtoqHGADSX7xgg2o8p4986LFanlh-ofZZbnwYf22nHMDxoChl2uU-VyYAbH?key=1AGqCMx2-TnUzEkI4-dlT5Di align="left")

### Comprehensive Setup for Monitoring Applications with Prometheus and Alertmanager

#### Step 1: Clone the Project Repository

Download the repository of the project you want to monitor:

```bash
git clone https://github.com/imkiran13/Boardgame.git
```

![](https://lh7-rt.googleusercontent.com/docsz/AD_4nXcsbbRSHG3w3t0mvuNmyCWb7Wy0FpRtqEqxQ-u91F9yk3CByZ1JXsglO1dc772vsrMW8xSAYpXDoUc1RhrP5tOHQQolLELfekbOJ_97YgOHmYGER5000JzW71KIjVvG3Wl_CI1B6g?key=1AGqCMx2-TnUzEkI4-dlT5Di align="left")

#### Step 2: Install Java and Maven

Since the application is Java-based, you need to install Java and Maven:

```bash
sudo apt install openjdk-17-jre-headless -y
sudo apt install maven -y
```

#### Step 3: Package the Application into a JAR File

```bash
cd Boardgame/
mvn package
```

![](https://lh7-rt.googleusercontent.com/docsz/AD_4nXcnEe2FQF0WBOuK4cUU9BhFRgAPIyhlvnkGwJXBOhYPR_jhaWdaEoRqWa5NpUiMKt2_FPXJMEUrOG_DochwVhS9_KJwn27DQ98XgG-_sxR5Zj7KgEmv3Pt8Z8hkokf6FHxKIBz6ww?key=1AGqCMx2-TnUzEkI4-dlT5Di align="left")

Navigate to the `target` directory and run the JAR file:

```bash
cd target/
java -jar jar-file-name.jar
```

![](https://lh7-rt.googleusercontent.com/docsz/AD_4nXdJOPsEKxV63gbWpO7fQXwxUPs3H0LDEYXJ6OuFA2S5xbc_lWka8HqgE6GsAOJ8ZW8Nd8N8vbp3SDHn0-IxSFg5CFHkptCCLBZkzrMO1D0bUGn51JZjSR41COQN35sdo6kJyJuc?key=1AGqCMx2-TnUzEkI4-dlT5Di align="left")

Access the application on port `8080`.

![](https://lh7-rt.googleusercontent.com/docsz/AD_4nXfoyZie99hd6dDl0h5PkIC5fRWHetQUFUiEdgPnh624NlhMP53ulPm29amVDyeY6MTlu5UP58yBlpeFkWAKC8clnJn9Uglc-ciIyvMXw_R_6QzHjYUy4mj7-RzmlhO4UqwVr3CvQQ?key=1AGqCMx2-TnUzEkI4-dlT5Di align="left")

#### Step 4: Configure Prometheus Alert Rules

Go to the Prometheus configuration folder and create an alert rules file:

```bash
sudo vim /etc/prometheus/alert_rules.yml
```

Add the following content:

```yaml
groups:
  - name: alert_rules
    rules:
      - alert: InstanceDown
        expr: up == 0
        for: 1m
        labels:
          severity: critical
        annotations:
          summary: Endpoint {{ $labels.instance }} down
          description: "{{ $labels.instance }} of job {{ $labels.job }} has been down for more than 1 minute."

      - alert: WebsiteDown
        expr: probe_success == 0
        for: 1m
        labels:
          severity: critical
        annotations:
          summary: Website down
          description: The website at {{ $labels.instance }} is down.

      - alert: HostOutOfMemory
        expr: node_memory_MemAvailable / node_memory_MemTotal * 100 < 25
        for: 5m
        labels:
          severity: warning
        annotations:
          summary: Host out of memory (instance {{ $labels.instance }})
          description: |
            Node memory is filling up (< 25% left)
            VALUE = {{ $value }}
            LABELS: {{ $labels }}

      - alert: HostOutOfDiskSpace
        expr: (node_filesystem_avail{mountpoint="/"} * 100) / node_filesystem_size{mountpoint="/"} < 50
        for: 1s
        labels:
          severity: warning
        annotations:
          summary: Host out of disk space (instance {{ $labels.instance }})
          description: |
            Disk is almost full (< 50% left)
            VALUE = {{ $value }}
            LABELS: {{ $labels }}

      - alert: HostHighCpuLoad
        expr: sum by (instance) (irate(node_cpu{job="node_exporter_metrics", mode="idle"}[5m])) > 80
        for: 5m
        labels:
          severity: warning
        annotations:
          summary: Host high CPU load (instance {{ $labels.instance }})
          description: |
            CPU load is > 80%
            VALUE = {{ $value }}
            LABELS: {{ $labels }}

      - alert: ServiceUnavailable
        expr: up{job="node_exporter"} == 0
        for: 2m
        labels:
          severity: critical
        annotations:
          summary: Service Unavailable (instance {{ $labels.instance }})
          description: |
            The service {{ $labels.job }} is not available
            VALUE = {{ $value }}
            LABELS: {{ $labels }}

      - alert: HighMemoryUsage
        expr: (node_memory_Active / node_memory_MemTotal) * 100 > 90
        for: 10m
        labels:
          severity: critical
        annotations:
          summary: High Memory Usage (instance {{ $labels.instance }})
          description: |
            Memory usage is > 90%
            VALUE = {{ $value }}
            LABELS: {{ $labels }}

      - alert: FileSystemFull
        expr: (node_filesystem_avail / node_filesystem_size) * 100 < 10
        for: 5m
        labels:
          severity: critical
        annotations:
          summary: File System Almost Full (instance {{ $labels.instance }})
          description: |
            File system has < 10% free space
            VALUE = {{ $value }}
            LABELS: {{ $labels }}
```

#### Step 5: Update Prometheus Configuration

Edit the Prometheus configuration file to include the alert rules file:

```bash
sudo vim /etc/prometheus/prometheus.yml
```

![](https://lh7-rt.googleusercontent.com/docsz/AD_4nXeTOLV8XSLZNpJpQ16oEnRItkO9jFQCV661gw3EschfozUjKj3U1PKFALF4uyE09F6vFZvSf6d1oX6Z_3zLvXLg8x-OjpAMdYGyB688LyuTuO_to5SK0aO1s1_-p4GXANIviiHPLA?key=1AGqCMx2-TnUzEkI4-dlT5Di align="left")

Add the following:

```yaml
rule_files:
  - "alert_rules.yml"
```

![](https://lh7-rt.googleusercontent.com/docsz/AD_4nXdlN1LACmw1uEMV2d6Zu5p5OatTr9KwTKXhVMH2fng0edGq_P3afFBqfxNLjd68P53kujEBNJhuR0ATMyMFbUvxopVYWHCYc0gTQc5M5OxJK47oQQf1jgJLUpvYJ_LWGEIWCGMTEQ?key=1AGqCMx2-TnUzEkI4-dlT5Di align="left")

Restart Prometheus:

```bash
sudo systemctl restart prometheus
```

![](https://lh7-rt.googleusercontent.com/docsz/AD_4nXetUIfl4Lmei8SuzcZeWPpTpNT5XaZ1BfMFyFlZS1yelZjDbLUUBO23qvhRpyM3kR9roD-dlK1DLr1MH-lW8lfVpl1at_l5mzznMX8jpx3Kwkl3l9yhdACYVuZYUKFN-HZVrI11SA?key=1AGqCMx2-TnUzEkI4-dlT5Di align="left")

#### Step 6: Add Node Exporter and Blackbox Exporter Configurations

Edit the Prometheus configuration file:

```bash
sudo vim /etc/prometheus/prometheus.yml
```

Add the following:

```yaml
---
global:
  scrape_interval: 15s
  evaluation_interval: 15s

alerting:
  alertmanagers:
    - static_configs:
        - targets:
            - localhost:9093

rule_files:
  - alert_rules.yml

scrape_configs:
  - job_name: prometheus
    static_configs:
      - targets:
          - localhost:9090

  - job_name: node_exporter
    static_configs:
      - targets:
          - 13.127.62.132:9100    # Node Exporter IP & Port

  - job_name: blackbox
    metrics_path: /probe
    params:
      module:
        - http_2xx
    static_configs:
      - targets:
          - http://prometheus.io
          - https://prometheus.io
          - http://13.127.62.132:8080/   # Application Server IP & Port

    relabel_configs:
      - source_labels:
          - __address__
        target_label: __param_target
      - source_labels:
          - __param_target
        target_label: instance
      - target_label: __address__
        replacement: 43.205.120.90:9115  # Blackbox Exporter IP & Port
```

Restart Blackbox Exporter:

```bash
sudo systemctl restart blackbox_exporter
```

![](https://lh7-rt.googleusercontent.com/docsz/AD_4nXezWu_UKUmAXDwfZPZngoEYnF25pQAnFB9-wqFujTJfZ130xOJGypBKtfqZiQHNAjLbahuFa3XL6g90NXIBdcQPH7sgIeRrDeljZHEICXXlUAcrt-JAMGFOcGFePYf7gpEq3zfRoA?key=1AGqCMx2-TnUzEkI4-dlT5Di align="left")

Restart Prometheus:

```bash
sudo systemctl restart prometheus
```

![Go to status/targets](https://lh7-rt.googleusercontent.com/docsz/AD_4nXetjWyLnIP3V1gnaq6ukRMQUDZExTCRDqlSofMTzs0i0LNC0EkfgAx6eMADqSbSOLCZjIq-q2BfLJihgTvkS2pJwFMMayLHiyBxMQthMzOF6pt-twMg0_Rl2E1nfMqETuV3aP2L?key=1AGqCMx2-TnUzEkI4-dlT5Di align="left")

#### Step 7: Configure Email Notifications with Alertmanager

Edit the Alertmanager configuration file:

```bash
sudo vim /etc/alertmanager/alertmanager.yml
```

Add the following:

```yaml
route:
  group_by:
    - alertname
  group_wait: 30s
  group_interval: 5m
  repeat_interval: 1h
  receiver: email-notifications

receivers:
  - name: email-notifications
    email_configs:
      - to: imkiran13@gmail.com
        from: test@gmail.com
        smarthost: smtp.gmail.com:587
        auth_username: imkiran13@gmail.com
        auth_identity: imkiran13@gmail.com
        auth_password: dlqvbjsebrxslrts
        send_resolved: true

inhibit_rules:
  - source_match:
      severity: critical
    target_match:
      severity: warning
    equal:
      - alertname
      - dev
      - instance
```

![](https://lh7-rt.googleusercontent.com/docsz/AD_4nXcZUlEtVePnLeUZLxsTzKxxOj7VxBYOXV4VqpWrqBN2j5Bcpr1-wVPDgcu1Og8IvdCLBCVVzLoUjj0vSUIPJInsrPpoFYBdMBl8xwEvAigkYcd-SDa5o0BGpE3-9RV3f6-0d3A?key=1AGqCMx2-TnUzEkI4-dlT5Di align="left")

Generate an app password for your Gmail account:

1. Go to **Manage My Google Account**.
    
2. Search for **App Passwords**.
    
    ![](https://lh7-rt.googleusercontent.com/docsz/AD_4nXeLTI7NgnS4uXwddBhQKGJYnKaccj2txak4nCC3NJo10DcUNrGU2Ei6yUtYKpNf6iDIoaDiPpg0uUbKz34XqC0Hc4aG2YIK7zp_9fM4GDAWFDkEqzorzclx20JBZhQBhG8cheL_Ww?key=1AGqCMx2-TnUzEkI4-dlT5Di align="left")
    
3. Generate and use the password in the configuration.
    
    ![](https://lh7-rt.googleusercontent.com/docsz/AD_4nXdGXYo4zcfQpS7TV3lVrOWMoOzV8KhaAO89Pbr2vH88a5YZuWXtvtcewRDeqohPdWSjyz8MrIdtCA-RHPXob26OqWAykCZewvs9CxYUlN5YGYulcic6Dcs3F93YpUWT2L7-DsfCmA?key=1AGqCMx2-TnUzEkI4-dlT5Di align="left")
    

Restart Alertmanager:

```bash
sudo systemctl restart alertmanager
```

Restart Prometheus:

```bash
sudo systemctl restart prometheus
```

#### Step 8: Test the Configuration

1. Stop the application running on port `8080`.
    
    ![](https://lh7-rt.googleusercontent.com/docsz/AD_4nXen0QpYHoYKeBXDl0dYnM4KpCfOCyNkpDpJYiQ9jgRabk4ihk7K2fXguvGyJwpXsidgWbuq3FtdnBDcAzoJG_O_ziYB1G0Eeoeq2ssQthk1a06niHRVNbrfEz5awXA0702oyn9lvg?key=1AGqCMx2-TnUzEkI4-dlT5Di align="left")
    
2. Verify the "Website Down" alert in Prometheus. You should see the alert transitioning to a firing state.
    
    ![](https://lh7-rt.googleusercontent.com/docsz/AD_4nXed62Kh5uD19ohXScGcFQPMBlsx2l4WTcx3STVn_fQqRACxcp5S5ODS3ivWgGkgiC8cdPFIJi1Xh-AaJl_cE-BAV7GLOrQU-ItWJohAVkrntu1C2XpvoxHmBCnD3cQIn_sF28CN?key=1AGqCMx2-TnUzEkI4-dlT5Di align="left")
    
    ![](https://lh7-rt.googleusercontent.com/docsz/AD_4nXeEiIu-CAPG6r0Cbs0HVzgJxu3rqPsRhDFMowOo660elQC2BxAOMP2UthiJiFbd-Te6B_DW3yZI-jS8ijKKT3B5tn2IS2mESq_MrZgBTmsLmPl35hnkd3XqK7qqNWAwWBViQwKkCA?key=1AGqCMx2-TnUzEkI4-dlT5Di align="left")
    
3. Check your email for notification alerts.
    
    ![](https://lh7-rt.googleusercontent.com/docsz/AD_4nXezEjcAWX9MBtU9u-32afuyX9eymQGnOdTFHK7eBK17Ly4BAVc-33bmWbDJWMzQNjGR8K90T_QwZEhC4sZn9hR3Wyn2Jdozbu20tGVCM4xIKsZLZv-cIPj_uWcV04bYJq52fZ0MbQ?key=1AGqCMx2-TnUzEkI4-dlT5Di align="left")
    

This comprehensive setup ensures proactive monitoring and timely alerting for your EC2 instances. Happy monitoring!