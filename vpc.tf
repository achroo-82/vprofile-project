module "vpc" {
  source = "terraform-aws-modules/vpc/aws"

  name = var.VPC_NAME
  cidr = var.VPC_CIDR

  azs             = [var.ZONE_A, var.ZONE_B, var.ZONE_C]
  private_subnets = [var.PRIV_SUBA_CIDR, var.PRIV_SUBB_CIDR, var.PRIV_SUBC_CIDR]
  public_subnets  = [var.PUB_SUBA_CIDR, var.PUB_SUBB_CIDR, var.PUB_SUBC_CIDR]

  enable_nat_gateway   = true
  single_nat_gateway   = true
  enable_dns_hostnames = true
  enable_dns_support   = true

  tags = {
    Terraform   = "true"
    Environment = "dev"
  }

  vpc_tags = {
    Name = var.VPC_NAME
  }
}