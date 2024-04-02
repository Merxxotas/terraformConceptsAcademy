terraform {
  required_providers {
    kubernetes = {
      source = "hashicorp/kubernetes"
    }
  }
}

provider "kubernetes" {
  config_path = "~/.kube/config"
}

terraform {
  backend "local" {
    path = "terraform.tfstate"
  }
}
