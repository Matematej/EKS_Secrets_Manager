resource "aws_internet_gateway" "igw" {
  vpc_id = aws_vpc.main.id

  tags = {
    Project     = "EKS_Secrets_Manager",
    Environment = "Dev"
  }
}