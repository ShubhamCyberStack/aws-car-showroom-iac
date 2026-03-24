This documentation provides the complete, step-by-step roadmap for deploying your **DriveSync Car Showroom** application on a professional AWS 3-tier architecture. 

---

## **Phase 1: Local Infrastructure Provisioning**
Before touching the VM, you must build the "house" where your application will live using **Terraform**.

1.  **Initialize Terraform:** Prepare the working directory by downloading the AWS provider plugins.
    ```bash
    terraform init
    ```
2.  [cite_start]**Plan the Build:** Review the resources to be created (VPC, Subnets, EC2, RDS)[cite: 3, 10, 15].
    ```bash
    terraform plan
    ```
3.  **Apply Configuration:** Provision the actual hardware on AWS.
    ```bash
    terraform apply --auto-approve
    ```
4.  [cite_start]**Note the Outputs:** Copy the `vm_public_ip` and `rds_endpoint` provided in the terminal[cite: 11, 23].

---

## **Phase 2: VM Environment Setup**
[cite_start]Once your Ubuntu 24.04 VM is running, you need to install the software stack[cite: 10, 41].

1.  **SSH into the VM:**
    ```bash
    ssh -i "shubhamkeypair_ec2.pem" ubuntu@<VM_PUBLIC_IP>
    ```
2.  [cite_start]**Update and Install Core Packages:** Install Node.js, the MySQL client for RDS communication, and Nginx for web traffic[cite: 10, 41].
    ```bash
    sudo apt update && sudo apt upgrade -y
    sudo apt install -y nodejs npm mysql-client nginx
    ```

---

## **Phase 3: Database Initialization**
Your RDS instance starts as a blank slate. You must create the database container and populate it with the 10 luxury cars.

1.  [cite_start]**Create the Database:** Connect to your RDS instance using your credentials and create the `car_showroom` schema[cite: 15, 19].
    ```bash
    mysql -h <RDS_ENDPOINT> -u admin -pShubham11 -e "CREATE DATABASE IF NOT EXISTS car_showroom;"
    ```
2.  [cite_start]**Set Environment Variables:** Export your RDS details so the Node.js scripts can find the database[cite: 1, 3, 11, 23].
    ```bash
    export DB_HOST="<RDS_ENDPOINT>"
    export DB_NAME="car_showroom"
    export DB_USER="admin"
    export DB_PASSWORD="Shubham11"
    ```
3.  **Seed the Showroom:** Run the automated script to insert the Tesla, BMW, Ferrari, and other models.
    ```bash
    npm install
    npm run seed
    ```

---

## **Phase 4: Web Server & Reverse Proxy**
[cite_start]Configure **Nginx** to act as a front door, routing public traffic from Port 80 (HTTP) to your application on Port 3000[cite: 10, 41].

1.  **Edit Nginx Config:**
    ```bash
    sudo nano /etc/nginx/sites-available/default
    ```
2.  **Apply Proxy Settings:** Replace the file content with the following block:
    ```nginx
    server {
        listen 80;
        location / {
            proxy_pass http://localhost:3000;
            proxy_http_version 1.1;
            proxy_set_header Upgrade $http_upgrade;
            proxy_set_header Host $host;
            proxy_cache_bypass $http_upgrade;
        }
    }
    ```
3.  **Restart Nginx:**
    ```bash
    sudo systemctl restart nginx
    ```

---

## **Phase 5: Production Process Management**
[cite_start]Use **PM2** to keep your website running 24/7, even if you close your terminal or the server reboots[cite: 10, 41].

1.  **Install PM2 Globally:**
    ```bash
    sudo npm install -g pm2
    ```
2.  **Start the Server with Persisted Env Vars:**
    ```bash
    pm2 start server.js --name "showroom" --env DB_HOST="<RDS_ENDPOINT>" --env DB_NAME="car_showroom" --env DB_USER="admin" --env DB_PASSWORD="Shubham11"
    ```
3.  **Setup Auto-Boot:**
    ```bash
    pm2 startup
    # (Copy and run the command PM2 provides)
    pm2 save
    ```

---

## **Final Result**
* **Frontend:** Accessed via `http://<VM_PUBLIC_IP>`.
* [cite_start]**Infrastructure:** Securely segmented into public (Web) and private (RDS) subnets[cite: 3, 10, 15].
* **Data Tier:** Highly available Amazon RDS hosting your inventory.
