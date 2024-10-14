# Azure_KeyVault_Excercise
**Provisioning a key vault with private end point access to store secrets.**

# Scenario
A virtual machine that is currently in use and is running many automation scripts in an IT environment. Unfortunately, there is a chance that the scripts embedded with credentials will cause a security breach. As a result, it is our responsibility to keep the script safe from users who weren't permitted to retrieve the credentials.

To store the credentials in a safe location, we will need a few more resources. Hence, we additionally privision a Key Vault for storing secrets and a user-assigned managed identity to authenticate and authorize to the Key Vault.

**High Level Architecture Diagram**

![VMKeyVaultSecretsv1](https://github.com/user-attachments/assets/74f905ab-b578-439f-8e8b-53507ede9d7a)
