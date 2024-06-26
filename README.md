# AWS Secrets Manager with AWS EKS

## Workflow

1. **Integration with AWS Secrets Manager and Kubernetes**:
    - We use the AWS Service Control and Provider to integrate AWS Secrets Manager with Kubernetes.
        - The AWS Service Control and Provider's DaemonSet deploys the CSI Provider for AWS Secrets Manager on each node.
        - AWS Service Control and Provider provides the infrastructure for Kubernetes to securely retrieve secrets from AWS Secrets Manager.

2. **Storing Secrets in AWS Secrets Manager**:
    - The secrets are stored securely in AWS Secrets Manager.

3. **Mounting Secrets to Pods with EKS Secrets Store CSI Driver**:
    - The EKS Secrets Store CSI Driver mounts the secrets from AWS Secrets Manager to individual pods as files.
        - The DaemonSet deploys the Secrets Store CSI Provider on each node.
        - The Secrets Store CSI Provider ensures the functionality of the CSI Driver.
        - The CSI Driver mounts the secrets from AWS Secrets Manager to individual pods as files.
        - Secrets are exposed as Environment Variables (in k8s/application_pods/deployment.yaml)

## How to run

1. aws eks update-kubeconfig --region us-east-1 --name MyCluster
2. kubectl apply -f k8s/application_pods
3. kubectl apply -f k8s/secrets_store_csi_driver
4. kubectl apply -f k8s/AWS_SCP