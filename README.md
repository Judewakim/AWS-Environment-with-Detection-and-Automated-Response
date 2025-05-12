# AWS Environment with Detection and Automated Response

A secure, production-style AWS environment for a web application, integrated with AWS security services for monitoring, alerting, and automated response.

## Overview

This project provisions a robust AWS infrastructure using Terraform, encompassing:

* A Virtual Private Cloud (VPC) with public and private subnets
* EC2 instances serving as a bastion host and web server
* An Amazon RDS database instance in a private subnet
* Security configurations including Security Groups and IAM roles
* Integration with AWS security services for threat detection and automated response

The architecture ensures that the web server and RDS database are securely deployed, with the bastion host facilitating secure administrative access.

## Architecture Diagram

![Network Architecture](networkDiagram.png)

## 📦 Modules

* **network**: Provisions VPC, public/private subnets, route tables, and internet/NAT gateways.
* **ec2**: Deploys a Bastion host and Web Server in the public subnet with security groups and user data.
* **s3_logging**: Creates S3 buckets with proper logging configuration and encryption for audit/compliance.
* **security_services**: Enables AWS Config, CloudTrail, and optionally Security Hub for continuous monitoring.
* **sns_alerts**:	Configures an SNS topic and email subscription to send security or compliance alerts.
* **rds**: Launches an encrypted RDS database instance in the private subnet using a subnet group.

## Prerequisites

* [Terraform](https://www.terraform.io/downloads.html) installed
* An AWS account with appropriate permissions
* An existing SSH key pair for EC2 instance access

## 📝 Setup Instructions

1. **Clone the Repository**

   ```bash
   git clone https://github.com/Judewakim/AWS-Environment-with-Detection-and-Automated-Response.git
   cd AWS-Environment-with-Detection-and-Automated-Response
   ```



2. **Initialize Terraform**

   ```bash
   terraform init
   ```



3. **Configure Variables**

   Edit the `variables.tf` file or create a `terraform.tfvars` file to set the necessary variables, such as:

   * `aws_region`
   * `ami_id`
   * `instance_type`
   * `key_name`
   * `db_name`
   * `db_username`
   * `db_password`

4. **Apply the Terraform Configuration**

   ```bash
   terraform apply
   ```



Review the planned actions and confirm to proceed.

## 🏞️ Accessing the Environment

* **Bastion Host**: Use your SSH key to connect to the bastion host for administrative tasks.

```bash
  ssh -i path/to/your-key.pem ec2-user@<bastion-public-ip>
```



* **Web Server**: Access the web application via the web server's public IP address in your browser.

* **RDS Database**: Connect to the RDS instance from the bastion host or web server using the database credentials.

## 🛡️ Security Features

This environment integrates AWS security services to enhance threat detection and response:

* **Amazon GuardDuty**: Monitors for malicious or unauthorized behavior.

* **AWS Security Hub**: Provides a comprehensive view of security alerts and compliance status.

* **AWS Systems Manager**: Facilitates secure and auditable instance management.

Automated responses can be configured to remediate detected threats, such as isolating compromised instances or revoking access.

## 🗑️ Cleanup

To tear down the environment and avoid incurring charges:

```bash
terraform destroy
```



Confirm the destruction when prompted.

## References

* [AWS Security Hub](https://aws.amazon.com/security-hub/)
* [Amazon GuardDuty](https://aws.amazon.com/guardduty/)
* [AWS Systems Manager](https://aws.amazon.com/systems-manager/)
* [Terraform AWS Provider](https://registry.terraform.io/providers/hashicorp/aws/latest/docs)

---

For detailed information and updates, visit the [project repository](https://github.com/Judewakim/AWS-Environment-with-Detection-and-Automated-Response).

---

[1]: https://github.com/aws-solutions/automated-security-response-on-aws?utm_source=chatgpt.com "aws-solutions/automated-security-response-on-aws - GitHub"
[2]: https://github.com/adanalvarez/AWSIncidentResponseAutomations?utm_source=chatgpt.com "Easy to deploy automations for incident response in AWS - GitHub"
[3]: https://github.com/aws-samples/automated-ec2-isolation-for-incident-response/blob/main/README.md?utm_source=chatgpt.com "automated-ec2-isolation-for-incident-response/README.md at main"
[4]: https://aws.amazon.com/products/security/detection-and-response/?utm_source=chatgpt.com "Detection and Response on AWS - Amazon Web Services"
