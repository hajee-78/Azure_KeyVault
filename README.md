# AzureKey_Vault
**Provisioning a key vault with private end point access to store secrets.**

# Scenario
A virtual machine that is currently in use and is running many automation scripts in an IT environment. Unfortunately, there is a chance that the scripts embedded with credentials will cause a security breach. As a result, it is our responsibility to keep the script safe from users who weren't permitted to retrieve the credentials.

To store the credentials in a safe location, we will need a few more resources. Therefore, we also provide a Key Vault for storing secrets and a user-assigned managed identity to authenticate to Key Vault.

**High Level Architecture Diagram**

![VMKeyVaultSecrets](https://github.com/user-attachments/assets/aaf3485d-6dea-4f1a-8057-9715c0df52fa)
