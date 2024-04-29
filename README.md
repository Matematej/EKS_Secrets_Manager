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
    
I have changed prod/service/token to My_Secret

Maybe there will be a problem with referencing secret insted of secrets manager