provider "kubernetes" {
  host = data.aws_eks_cluster.Angeldesign-cluster.endpoint
  token = data.aws_eks_cluster_auth.Angeldesign-cluster.token
  cluster_ca_certificate = base64decode(data.aws_eks_cluster.Angeldesign-cluster.certificate_authority[0].data)
}

data "aws_eks_cluster" "Angeldesign-cluster" {
  name = module.eks.cluster_name
}

data "aws_eks_cluster_auth" "Angeldesign-cluster"{
  name = module.eks.cluster_name
}

module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "19.0.4"

  cluster_name = "angeldesign-eks-cluster"
  cluster_version = "1.21"

  subnet_ids = module.AngelDesign-vpc.private_subnets
  vpc_id = module.AngelDesign-vpc.vpc_id

  tags = {
    environment = "development"
    application = "myapp"
  }

  eks_managed_node_groups = {
    dev = {
      min_size     = 1
      max_size     = 3
      desired_size = 3

      instance_types = ["t2.small"]
    }
  }
}
