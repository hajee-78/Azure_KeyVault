# Azure_KeyVault_Excercise
**Provisioning a key vault with private end point access to store secrets.**

# Scenario
A virtual machine that is currently in use and running many automation scripts in an IT environment. Unfortunately, there is a chance that the scripts embedded with credentials will cause a security breach. Hence, it is our responsibility to keep the script safe from users who weren't permitted to retrieve the credentials.

To store the credentials in a safe location, we will need a few more resources. Hence, we additionally privision a Key Vault for storing secrets and a user-assigned managed identity to authenticate and authorize to the Key Vault.


**High Level Architecture Diagram**

![VMKeyVaultSecretsv1](https://github.com/user-attachments/assets/74f905ab-b578-439f-8e8b-53507ede9d7a)

**Solution**

The terraform code structure as follows

|-- main.tf // Contains the resource blocks that define the resources to be created in the target cloud provider. 

|-- vars.tf // Variables declaration used in the resource block.

# Deployment Steps

**terraform init** - To initializes a working directory containing configuration files and installs plugins for required providers.

**terraform fmt** - To rewrite Terraform configuration files to a canonical format and style. This command applies a subset of the Terraform language style conventions, along with other minor adjustments for readability.

**terraform plan** - The terraform plan command creates an execution plan, which lets you preview the changes that Terraform plans to make to your infrastructure.

**terraform apply** - The terraform apply command executes the actions proposed in a Terraform plan to create, update, or destroy infrastructure.
