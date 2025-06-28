# 🌩️ Amaani AWS Cloud Security Framework

This project is a modular, Terraform-based, plug-and-play AWS security solution that integrates native AWS services to create a detection, response, and compliance framework for modern, security-conscious organizations.

While the repository includes a sample VPC environment with EC2 and RDS resources to simulate a client workload, the primary focus is building a **reusable, scalable security automation layer** designed for real-world production environments.

---

![Network Architecture](networkDiagram.png)

---

## 🔐 Project Focus

This project orchestrates foundational AWS security services to enable:

- ✅ **Resource monitoring** via **AWS Config**
- ✅ **API activity logging** with **AWS CloudTrail**
- ✅ **Threat detection** through **Amazon GuardDuty**
- ✅ **Central alerting** via **SNS**
- ✅ **IAM hardening**, password/MFA enforcement, and Access Analyzer
- ✅ **Event-driven remediation** using **EventBridge + Lambda**
- ✅ **Terraform-first deployment** with modular toggles
- ✅ **Compliance mapping** to CIS/NIST frameworks

---

## 🛠️ Terraform Modules

Each module can be toggled on/off using `terraform.tfvars`.

| Module            | Description                                                                 |
|-------------------|-----------------------------------------------------------------------------|
| `security_services` | Core detection layer: Config, CloudTrail, GuardDuty, IAM, Access Analyzer  |
| `sns_alerts`        | Alerting channel for findings and compliance issues                        |
| `s3_logging`        | Secure, encrypted logging buckets for Config and CloudTrail                |
| `network` *(demo)*  | Test VPC with public/private subnets and NAT                               |
| `ec2` *(demo)*      | Bastion + Web server with IAM roles and SSM                                |
| `rds` *(demo)*      | Private encrypted MySQL instance                                           |

---

## 🧪 Test Environment (Client Simulation)

The EC2 and RDS modules simulate a typical client workload for validation and testing:

- **Bastion Host**: SSH/SSM management gateway
- **Web Server**: Public-facing test endpoint
- **RDS**: Encrypted database in private subnet

These are **optional** and can be removed in production deployments.

---

## 🛡️ IAM Strategy

This framework uses a hybrid IAM model:

- **IAM Groups** for Admin, Sales, and Accounting roles
- **Task-Based Policies** for least privilege permissions (e.g., start EC2, read S3)
- **Account-Level Controls** for password policy, MFA enforcement, and root lockdown
- **IAM Access Analyzer** for trust boundary validation

Everything is modular and toggleable via `terraform.tfvars`.

---

## 🧩 Config & Compliance Strategy

This framework integrates AWS Config as the foundation for real-time compliance tracking and remediation, aligning infrastructure with CIS, NIST 800-53, and PCI DSS standards.

All rules operate in audit mode by default. Violations are:

- Marked as noncompliant in AWS Config
- Forwarded to Security Hub (if enabled)
- Routed to EventBridge, triggering future Lambda-based remediation

---

## ⚙️ Setup Instructions

1. **Clone the repository**
   ```bash
   git clone https://github.com/Judewakim/AWS-Environment-with-Detection-and-Automated-Response.git
   cd AWS-Environment-with-Detection-and-Automated-Response
   ```

  2. **Initialize Terraform**

     ```bash
     terraform init
     ```

  3. **Configure your variables**

     Edit the `terraform.tfvars` file with your environment-specific values:

     ```hcl
     aws_region         = "us-east-1"
     project_prefix     = "securecloud"

     key_name           = "your-key"
     ami_id             = "ami-xxxxxxx"
     instance_type      = "t3.micro"

     db_name            = "appdb"
     db_username        = "admin"
     db_password        = "SecurePassword123"

     enable_config             = true
     enable_guardduty          = true
     enable_iam                = true
     enable_iam_access_analyzer = true

     enable_admin_group        = true
     enable_sales_group        = true
     enable_accounting_group   = true

     enable_s3_read_write_policy       = true
     enable_ec2_start_stop_policy = true
     enable_rds_read_only_policy  = true

     enable_iam_config                  = false
     enable_ec2_config                  = false
     enable_rds_config                  = false
     ```

  4. **Deploy the stack**

     ```bash
     terraform apply
     ```

     Confirm when prompted.

  ## 🔁 Planned Automation

  EventBridge rules and Lambda functions will soon be added to act on specific Security Hub findings and will automatically:

  - Isolate EC2 instances flagged as compromised
  - Revoke IAM credentials for suspicious activity
  - Rotate IAM credentials or lock users
  - Notify security teams with actionable context
  - Automatically remediate failed Config rules

  ## 🧼 Cleanup

  Tear down the environment when finished:

  ```bash
  terraform destroy
  ```

  ## 🧠 About Amaani
  
  Amaani is a cloud-native security consultancy focused on building reusable, automated security frameworks for regulated and high-risk environments. This project is a showcase of the company's baseline hardening solution for AWS.