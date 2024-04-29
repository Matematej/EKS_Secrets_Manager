resource "aws_eks_cluster" "MyCluster" {
  name     = "MyCluster"
  role_arn = aws_iam_role.eks_cluster_role.arn

  vpc_config {
    subnet_ids = [
      module.landing_zone.private-us-east-1a,
      module.landing_zone.private-us-east-1b,
      module.landing_zone.public-us-east-1a,
      module.landing_zone.public-us-east-1b
    ]
  }

  tags = {
    Project     = "EKS_Secrets_Manager",
    Environment = "Dev"
  }
}

resource "aws_iam_role" "eks_cluster_role" {
  name = "eks-cluster-MyCluster"
  assume_role_policy = <<POLICY
{
  "Version": "2012-10-17",
  "Statement": [
    {
      "Effect": "Allow",
      "Principal": {
        "Service": "eks.amazonaws.com"
      },
      "Action": "sts:AssumeRole"
    }
  ]
}
POLICY

  tags = {
    Project     = "EKS_Secrets_Manager",
    Environment = "Dev"
  }
}