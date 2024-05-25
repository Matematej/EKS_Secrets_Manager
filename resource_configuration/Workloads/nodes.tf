resource "aws_eks_node_group" "MyNode_Group" {
  cluster_name    = aws_eks_cluster.MyCluster.name
  node_group_name = "My_Node_Group"
  node_role_arn = aws_iam_role.eks_node_role.arn

  subnet_ids = [
    module.landing_zone.private-us-east-1a,
    module.landing_zone.private-us-east-1b
  ]

  scaling_config {
    desired_size = 1
    min_size     = 1
    max_size     = 4
  }

  capacity_type  = "SPOT"
  instance_types = ["t3.small"]

  tags = {
    Project     = "EKS_Secrets_Manager",
    Environment = "Dev"
  }
}

resource "aws_iam_role" "eks_node_role" {
  name = "eks_node_role"
  assume_role_policy = jsonencode({
    "Version" : "2012-10-17",
    "Statement" : [
      {
        "Effect" : "Allow",
        "Principal" : {
          "Service" : "ec2.amazonaws.com"
        },
        "Action" : "sts:AssumeRole"
      }
    ]
  })

  tags = {
    Project     = "EKS_Secrets_Manager",
    Environment = "Dev"
  }
}

  # This AWS Managed policy allows Amazon EKS worker nodes to connect to Amazon EKS Clusters.
resource "aws_iam_role_policy_attachment" "nodes-AmazonEKSWorkerNodePolicy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKSWorkerNodePolicy"
  role       = aws_iam_role.eks_node_role.name
}

  # This AWS Managed policy provides the Amazon VPC CNI Plugin the permissions it requires to modify the IP address configuration on your EKS worker nodes.
  # This permission set allows the CNI to list, describe, and modify Elastic Network Interfaces on your behalf.
resource "aws_iam_role_policy_attachment" "nodes-AmazonEKS_CNI_Policy" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEKS_CNI_Policy"
  role       = aws_iam_role.eks_node_role.name
}

  # This AWS Managed policy provides read-only access to Amazon EC2 Container Registry repositories.
  # It allows us to download and use images from ECR repo.
resource "aws_iam_role_policy_attachment" "nodes-AmazonEC2ContainerRegistryReadOnly" {
  policy_arn = "arn:aws:iam::aws:policy/AmazonEC2ContainerRegistryReadOnly"
  role       = aws_iam_role.eks_node_role.name
}