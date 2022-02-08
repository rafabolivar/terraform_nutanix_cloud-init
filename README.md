# Nutanix VM Creation using Terraform and cloud-init scripts

This example shows how to create Virtual Machines, using infrastructure as code with [Terraform](https://www.terraform.io/) and the [Nutanix Provider for Terraform](https://registry.terraform.io/providers/nutanix/nutanix/latest). 


# Prerequisites

We'll need a working Nutanix cluster, and Terraform with the Nutanix provider for Terraform installed. 

## Required data

We need to know the following data about our environment:

 - Password for admin user
 - IP Address of your Prism Central and Prism Element 

# Using Terraform to deploy a new VM.

You can clone this repository with an easy eaxmple.

## Terraform files

Inside this repository you'll find the following 4 files:

|File|Description  |
|--|--|
|[main.tf](https://github.com/rafabolivar/terraform_nutanix_cloud-init/blob/main/main.tf)  | The main configuration file for our deployment |
|[variables.tf](https://github.com/rafabolivar/terraform_nutanix_cloud-init/blob/main/variables.tf)|The variable definition file|
|[terraform.tfvars](https://github.com/rafabolivar/terraform_nutanix_cloud-init/blob/main/terraform.tfvars)  | The variable values that will be used in our deployment |
|[init.tpl](https://github.com/rafabolivar/terraform_nutanix_cloud-init/blob/main/init.tpl)  | The cloud-init script that will configure our VM during the first boot |

This variables values must be modified, using the appropiate values from our cluster. You can do that using Nutanix Rest API or connecting via SSH to one of your CVMs and executing the following commands:

***Cluster UUID***

    ncli cluster get-params | grep "Cluster Uuid"

***Network UUID***  
    
    acli net.list

***Image UUID***
    nutanix@NTNX-21SM6K040170-B-CVM:10.42.91.30:~$ acli image.list

**Important Note:** The network name used for this deployment is Primary. This value can be easily changed in the blueprint to match your requirements.

## Deploying the cluster

Once you have checked the content of the files, you can proceed deploying the VM. First you'll need to initialise the environment:

    ubuntu@ubuntu:~$ cd /home/ubuntu/terraform
    ubuntu@ubuntu:~/terraform$ ./terraform init
    
Then, you can check the plan for your deployment:

    ubuntu@ubuntu:~/terraform$ ./terraform plan
If you want to modify the files, later you can validate that they're correct:

    ubuntu@ubuntu:~/terraform$ ./terraform validate

Finally, you can launch your deployment:

    ubuntu@ubuntu:~/terraform$ ./terraform apply

Once you execute this command, you can check in Prism Central that a new Virtual Machine is being deployed. By default, the name of the VM will be ***Rafa_TF_VM***. This can be easily modified editing the Terraform configuration files.

# Useful links

Here you have several links that can be useful to understand this example:

 - [Nutanix Terraform Provider example usage](https://registry.terraform.io/providers/nutanix/nutanix/latest/docs/resources/karbon_cluster).
 - [Nutanix Terraform Provider on GitHub](https://github.com/nutanix/terraform-provider-nutanix).
 - [Nutanix Terraform Provider documentation and examples on nutanix.dev](https://www.nutanix.dev/2021/04/20/using-the-nutanix-terraform-provider/).
 - [Aristocrat-B2B examples on GitHub](https://github.com/Aristocrat-B2B/terraform-nutanix-karbon).
