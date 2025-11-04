resource "aws_kms_key" "eks_secrets" {
    description             = "Clave KMS para el cifrado de secretos de EKS"
    deletion_window_in_days = 10
    enable_key_rotation     = true

    
    tags = {
      Name    = "${var.project}-eks-kms"
      Project = var.project
    }
}