#########################
# IAM README
#########################

# User Management & IAM Permissions

## Overview
This environment uses a **hybrid IAM model** that combines:

- **Group-based access** for teams (e.g., Admins, Sales, Accounting)
- **Task-based policies** for precise, least-privilege access
- **Account-level controls** for secure password and MFA enforcement
- **IAM Access Analyzer** for visibility into external access

## Enabling IAM Modules

To enable or disable IAM components, modify the variables in your `terraform.tfvars` file:

```
enable_iam                    = true
enable_iam_access_analyzer    = true

enable_admin_group            = true
enable_sales_group            = true
enable_accounting_group       = true

enable_s3_read_write_policy   = true
enable_ec2_start_stop_policy  = true
enable_rds_read_only_policy   = true
```

## Step-by-Step: Adding a New User

### 1. Create the IAM User (via Console or AWS CLI)
```
aws iam create-user --user-name <USERNAME>
```

### 2. (Optional) Assign Users to IAM Groups
You can use predefined IAM groups (Admin, Sales, Accounting) to assign broad, role-based access.
```
aws iam add-user-to-group --user-name <USERNAME> --group-name <GROUP_NAME>
```

### 3. (Optional) Attach Task-Based Policies
Choose the appropriate policies from the outputs after Terraform apply. For example:
```
aws iam attach-user-policy \
  --user-name <USERNAME> \
  --policy-arn <EC2StartStopPolicyArn>
```
Repeat for other policies as needed.
To view a policy's ARN again, run a Terraform output comand. For example:
```
terraform output ec2_start_stop_policy_arn
```

Common task policies that are available include:
- EC2StartStopPolicy
- RDSReadOnlyPolicy
- S3ReadWritePolicy
- S3ReadOnlyPolicy
- BillingReadOnlyPolicy
- SecurityHubReadOnlyPolicy

### 4. Create Login Profile or Access Keys
```
aws iam create-login-profile \
  --user-name <USERNAME> \
  --password <StrongPassword> \
  --password-reset-required
```
Or for programmatic access:
```
aws iam create-access-key --user-name <USERNAME>
```

## Notes
- All IAM policies are managed in Terraform.
- User and group creation is left to the client for security and HR lifecycle reasons.
- Task policies are exposed via outputs for easy reference and automation.

## Recommended Practices
- Rotate access keys every 90 days.
- Enforce MFA.
- Use IAM Access Analyzer to validate trust boundaries.

---
For questions, contact Amaani Security Services Support.