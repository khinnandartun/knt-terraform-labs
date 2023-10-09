module "eks" {
  source  = "terraform-aws-modules/eks/aws"
  version = "~> 19.0"

  cluster_name    = "eks-cluster"
  cluster_version = "1.27"

  cluster_endpoint_public_access = true

  cluster_addons = {
    coredns = {
      most_recent = true
    }
    kube-proxy = {
      most_recent = true
    }
    vpc-cni = {
      most_recent = true
    }
  }

  vpc_id     = module.vpc.vpc_id
  subnet_ids = module.vpc.private_subnets

  # EKS Managed Node Group(s)
  eks_managed_node_group_defaults = {
    instance_types = ["t2.small"]
  }

  eks_managed_node_groups = {
    elk-node = {
      min_size     = 3
      max_size     = 10
      desired_size = 3

      instance_types = var.eks_managed_node_instance_type
      #   capacity_type  = "ONDEMAND"
    }
  }

  # aws-auth configmap
  
  manage_aws_auth_configmap = false

  aws_auth_roles = var.eks_auth_roles

  aws_auth_users = var.eks_auth_users

  aws_auth_accounts = var.eks_auth_account

  tags = {
    Environment = "dev"
    eks-cluster = "true"
  }
}

resource "null_resource" "something" {
  provisioner "local-exec" {
#    command = "export KUBECONFIG=~/.kube/eks-knt.yaml && kubectl create ns elastic && helm  repo add elastic https://Helm.elastic.co && curl -O https://raw.githubusercontent.com/elastic/Helm-charts/master/elasticsearch/examples/minikube/values.yaml && helm install elasticsearch elastic/elasticsearch -f ./values.yaml -n elastic "
    command = "helm install kibana elastic/kibana -n elastic"
}
}