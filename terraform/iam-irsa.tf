module "alb_controller_irsa" {
    source  = "terraform-aws-modules/iam/aws//modules/iam-role-for-service-accounts-eks"
    version = "~> 5.0"

    role_name_prefix                       = "alb-controller-"
    attach_load_balancer_controller_policy = true
    oidc_providers = {
        main = {
            provider_arn                 = module.eks.oidc_provider_arn
            namespace_service_accounts   = ["kube-system:aws-load-balancer-controller"]
        }
    }
    tags = { Project = var.project }
}

module "cluster_autoscaler_irsa" {
    source  = "terraform-aws-modules/iam/aws//modules/iam-role-for-service-accounts-eks"
    version = "~> 5.0"

    role_name_prefix                 = "cluster_autoscaler-"
    attach_cluster_autoscaler_policy = true
    oidc_providers = {
        main = {
            provider_arn                 = module.eks.oidc_provider_arn
            namespace_service_accounts   = ["kube-system:cluster-autoscaler"]
        }
    }
    cluster_autoscaler_cluster_names = [module.eks.cluster_name]
    tags = { Project = var.project }
}
