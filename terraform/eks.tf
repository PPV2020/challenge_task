module "eks" {
    source  = "terraform-aws-modules/eks/aws"
    version = "~> 20.0"

    cluster_name                    = "${var.project}-eks"
    cluster_version                 = var.eks_version
    vpc_id                          = module.vpc.vpc_id
    subnet_ids                      = module.vpc.private_subnets
    cluster_endpoint_public_access  = true
    enable_irsa                     = true


    cluster_encryption_config = {
        resources = ["secrets"]

        provider = {
            key_arn = aws_kms_key.eks_secrets.arn
        }
    }

    cluster_enabled_log_types = ["api", "audit", "authenticator","controllerManager", "scheduler"]

    eks_managed_node_groups = {
        default = {
            instance_types =["t3.medium"]
            desired_size   = 2
            max_size       = 3
            min_size       = 1
            subnet_ids     = module.vpc.private_subnets
        }
    }

    tags = {
        Project = var.project
    }

}
