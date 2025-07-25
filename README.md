# 🚀 Azure VM + Storage Account with Private Endpoint (via Bicep & GitHub Actions)

This project provisions a secure Azure environment using Infrastructure as Code (IaC) with Bicep and automates the deployment using GitHub Actions. The key scenario is deploying a **Virtual Machine (VM)** that accesses a **Storage Account** via a **Private Endpoint**, ensuring traffic stays within the virtual network.

---

## 📁 Project Structure

```md
├── .github/workflows/ # GitHub Actions workflow files
│ └── azure-deploy.yml
├── modules/ # Reusable Bicep modules
│ ├── compute.bicep # VM definition
│ ├── network.bicep # VNet, subnets, NSGs
│ ├── storage.bicep # Storage Account + Private Endpoint
│ └── dns.bicep # Private DNS Zone
├── main.bicep # Main orchestrator Bicep file
└── README.md # Project documentation (this file)
```

---

## 🛠️ Features

- ✅ Virtual Network with subnets 
- ✅ Storage Account with **Private Endpoint**  
- ✅ Private DNS Zone linked to VNet  
- ✅ Public access disabled for storage  
- ✅ GitHub Actions pipeline for automated deployment  

---

## 🔐 Prerequisites

- ✅ Azure Subscription  
- ✅ GitHub repository with the following **secrets**:
  - `AZURE_CREDENTIALS` – output of `az ad sp create-for-rbac --sdk-auth`
  - `VM_PASSWORD` – secure password for VM admin  
- ✅ Resource group named `GHActionDeploy` or create one manually

---

## ⚙️ Deployment via GitHub Actions

The deployment is triggered on every push to `main`:

```yaml
name: AzureARMDeploy

on: [push]

jobs:
  deploy:
    runs-on: ubuntu-latest
    steps:
      - uses: actions/checkout@v4

      - name: Azure Login
        uses: azure/login@v1
        with:
          creds: ${{ secrets.AZURE_CREDENTIALS }}

      - name: Deploy Bicep Template
        uses: azure/arm-deploy@v1
        with:
          resourceGroupName: GHActionDeploy
          template: ./main.bicep
          parameters: adminPassword=${{ secrets.VM_PASSWORD }}
          deploymentName: PrivateENDP-${{ github.run_number }} 
```

## 📦 Bicep Parameters
The following parameters are used in main.bicep:

| Parameter            | Description             | Source                     |
| -------------------- | ----------------------- | -------------------------- |
| `adminPassword`      | Admin password for VM   | GitHub Secret              |
| `location`           | Azure region            | `resourceGroup().location` |



## 🌐 Private Networking

* Storage Account has public access disabled

* Private Endpoint created in a dedicated subnet

* Private DNS Zone handles name resolution

* VM can access Storage Account using private IP internally


## 📜 Cleanup
To delete all resources:

```bash
az group delete --name GHActionDeploy --yes --no-wait
```

## 📚 Resources

[Bicep Documentation](https://learn.microsoft.com/en-us/azure/azure-resource-manager/bicep/)

[Private Endpoint Docs](https://learn.microsoft.com/en-us/azure/private-link/private-endpoint-overview)

[GitHub Actions for Azure](https://learn.microsoft.com/en-us/azure/developer/github/)


