How it Works


Pre-requisites

Before running this Terraform code, you will need the following:

An AWS account with appropriate permissions to create EKS clusters, deploy Kubernetes resources, and create other required AWS resources.
A configured AWS CLI with valid credentials and default region.
Terraform installed on your machine.

Steps : 

Creating the EKS Cluster
The first section of the code sets up the AWS provider and creates an EKS cluster using the terraform-aws-modules/eks/aws module. The module takes several parameters, including the name of the cluster, the subnets it will run in, the VPC it will be created in, and the worker node launch template.

Deploying the Web Application

The second section of the code deploys the web application using a Kubernetes deployment. This creates a specified number of replicas of a container running the nginx image, which will serve our web application.

Deploying the Database

The third section of the code deploys the database using another Kubernetes deployment. This creates a specified number of replicas of a container running the postgres image. It also sets the POSTGRES_PASSWORD environment variable, which will be used to secure the database.


Why this code is secure and why, is well architected?

The code is secure because it uses best practices for deploying an EKS cluster and Kubernetes resources, such as isolating the resources in their own VPC and subnets, and deploying the resources using Kubernetes deployments and services.

The architecture works by creating an EKS cluster using the terraform-aws-modules/eks/aws module, which creates an EKS control plane and worker nodes in the specified subnets. The worker nodes are created using an AWS Launch Template, which specifies the instance type and the desired number of worker nodes.

Next, the code deploys a web application and a database using Kubernetes deployments, which specify the container images, replicas, and ports. The database deployment uses a Postgres container image and sets a password for the database using an environment variable.

Finally, the database is connected to the web application using a Kubernetes service, which exposes the database port to the web application. The web application is also exposed to the public internet using an external DNS name in the Kubernetes service.

Overall, this architecture provides a secure and scalable infrastructure for deploying a web application and a database in a production environment.

This code is still not complete, I mean, we can keep configuring the security of the passwords, using secrets like hashicorp vault or lastpass or another tool to avoid hardcoding the passwords. Also the public exposure of a domain will require payment with a credit card.

Also, more security measurements could be made but not using IaC neccessarily.






