provider "aws" {
  region = "us-west-2"
}

# Create an EKS cluster
module "eks" {
  source = "terraform-aws-modules/eks/aws"

  cluster_name         = "example-cluster"
  subnets              = ["subnet-12345678", "subnet-23456789", "subnet-34567890"]
  vpc_id               = "vpc-12345678"
  worker_groups_launch_template = [
    {
      instance_type = "t3.medium"
      asg_desired_capacity = 3
    }
  ]
}

# Deploy the web application
resource "kubernetes_deployment" "web" {
  metadata {
    name = "web"
  }

  spec {
    replicas = 3

    selector {
      match_labels = {
        app = "web"
      }
    }

    template {
      metadata {
        labels = {
          app = "web"
        }
      }

      spec {
        container {
          name  = "web"
          image = "nginx:latest"

          port {
            container_port = 80
          }
        }
      }
    }
  }
}

# Deploy the database
resource "kubernetes_deployment" "database" {
  metadata {
    name = "database"
  }

  spec {
    replicas = 3

    selector {
      match_labels = {
        app = "database"
      }
    }

    template {
      metadata {
        labels = {
          app = "database"
        }
      }

      spec {
        container {
          name  = "database"
          image = "postgres:latest"

          env {
            name  = "POSTGRES_PASSWORD"
            value = "mysecretpassword"
          }

          port {
            container_port = 5432
          }
        }
      }
    }
  }
}

# Connect the database to the web application
resource "kubernetes_service" "database" {
  metadata {
    name = "database"
  }

  spec {
    selector = {
      app = "database"
    }

    port {
      port        = 5432
      target_port = 5432
    }
  }
}

resource "kubernetes_service" "web" {
  metadata {
    name = "web"
  }

  spec {
    selector = {
      app = "web"
    }

    port {
      port        = 80
      target_port = 80
    }

    external {
      dns_name = "example.com"
    }
  }
}
