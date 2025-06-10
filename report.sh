#!/bin/bash

echo "🔍 Enabled AWS Config Rules Modules:"
echo "------------------------------------"

# List of feature flags in tfvars format
flags=(
  enable_config
  enable_ec2_config
  enable_rds_config
  enable_iam_config
  enable_s3_config
  enable_cloudtrail_config
  enable_cloudwatch_config
  enable_alb_config
  enable_vpc_config
)

for flag in "${flags[@]}"; do
  value=$(grep -E "^${flag}" terraform.tfvars | awk -F '=' '{gsub(/[[:space:]]*/, "", $2); print $2}')
  if [ "$value" == "true" ]; then
    echo "✅ ${flag} is enabled"
  else
    echo "❌ ${flag} is disabled"
  fi
done

echo "------------------------------------"
