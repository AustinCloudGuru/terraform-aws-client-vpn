# terraform-awe-client-vpn
This repository builds out a public subnet and a client VPN server based on libreswan.

# Methodology
The goal of my terraform project is to create code that can be used in across multiple environments (such as dev, staging, prod).  To do this, it uses the environments folder to define the variables for each environment.  The naming convention that I use is $AWS_ACCOUNT_NAME/$AWS_ACCOUNT_NAME.tfvars.

This builds on my [terraform-aws-base repo](https://github.com/AustinCloudGuru/terraform-aws-base)

# Variables
The variables that are needed are set in the environments directory.  This allows you to setup a different subnets for different environments (i.e. dev, stage, or prod).  The variables that need to be set are:

    # AWS Informatation
    aws_account       = "cf-poc"                                           # The AWS Account Name
    aws_region        = "us-east-1"                                        # The AWS Account Region
    
    # Base State
    aws-base-bucket               = "terraform-state-cf-poc"               # Bucket name for aws-base state file
    aws-base-state-file           = "terraform/terraform-aws-base.tfstate" # Name of the aws-base state file

    # VPN Subnets
    vpn-1a_subnet_cidr           = "10.233.250.0/28"                       # Subnet CIDR range

# Executing the Terraform Code
Everything is controlled by the Makefile.  After setting the environmental variables BUCKET (S3 Bucket to that the state file should be uploaded to) and PROJECT (which would equal $AWS_ACCOUNT_NAME), you can then run make to execute the terraform commands.  For example:

    % make plan
    
Will return the plan and:

    % make apply
    
will execute the command.  Once the environment is up, you still need to run the ansible to configure the host.  you can use make for that as well:

    % make ansible-check

will run the ansible command in --check mode and 

    % make ansible-deploy

will run the ansible against the node.

    % make destroy

will terminate the environment.
