
 # Role that your Pods will assume. Every good IAM Role should have at least 2 parts: sts:Assume and permissons.
 # This role has to be referenced in service_account annotations
 resource "aws_iam_role" "eks_secrets_manager_role" {
  assume_role_policy = data.aws_iam_policy_document.eks_secrets_manager_assume_role_policy.json
  name               = "eks-secrets-manager"
}

  # In the condition.variable you need to provide the URI of your cluster's Identity Provider.
  # The URI is defined in the deployment.yaml in the SA section.
  # The variable has to equal to service_account namespace and name.
data "aws_iam_policy_document" "eks_secrets_manager_assume_role_policy" {
  statement {
    actions = ["sts:AssumeRoleWithWebIdentity"]
    effect  = "Allow"

    condition {
      test     = "StringEquals"
      variable = "${replace(aws_iam_openid_connect_provider.eks.url, "https://", "")}:sub"
      values   = ["system:serviceaccount:prod:nginx"]
    }

    principals {
      identifiers = [aws_iam_openid_connect_provider.eks.arn]
      type        = "Federated"
    }
  }
}

resource "aws_iam_policy" "eks_secrets_manager_policy" {
  name   = "eks-secrets-manager"

  policy = jsonencode({
    Version = "2012-10-17",
    Statement = [
      {
        Effect   = "Allow",
        Action   = "secretsmanager:GetSecretValue",
        Resource = module.security.secrets_manager_arn
      }
    ]
  })
}

resource "aws_iam_role_policy_attachment" "eks_secrets_manager_attach" {
  role       = aws_iam_role.eks_secrets_manager_role.name
  policy_arn = aws_iam_policy.eks_secrets_manager_policy.arn
}