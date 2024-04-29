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