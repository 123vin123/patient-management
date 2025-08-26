#!/bin/bash
set -e  # Stops the script if any command fails

# Delete the existing stack
aws --endpoint-url="http://localhost:4566" cloudformation delete-stack \
    --stack-name patient-management

# Deploy the stack
aws --endpoint-url="http://localhost:4566" cloudformation deploy \
    --stack-name patient-management \
    --template-file "./cdk.out/localstack.template.json"

# Get the DNS name of the load balancer
DNS_NAME=$(aws --endpoint-url="http://localhost:4566" elbv2 describe-load-balancers \
    --query "LoadBalancers[0].DNSName" --output text)

echo "Load Balancer DNS: $DNS_NAME"

# Optional: open in browser
# open "http://$DNS_NAME"
