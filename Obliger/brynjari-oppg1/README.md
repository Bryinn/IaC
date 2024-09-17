
# Dependencies and prerequisites
The whole system is dependant on access to a cloud azure subscription and tenant.
This also means you are dependant on the azure provider for terraform, and terraform itself.
You will need to install these things before you start. This can be done though Chocolatey or similar tools.
```ps
choco install terraform
choco install azure-cli
```

You will then need to log into your azure tenant, create a service principal and run the following command in the command line:
```ps
az login --service-principal --username <serviceprincipal_username> --password <serviceprincipal_password> --tenant <tenant_id>
```
This wil log you in as a service principal through the command line, and give you access to create your environment!

If you want multiple network ranges on a single subnet object, you will need to execute this command, enabling the feature.
```ps
az feature register --namespace Microsoft.Network -n AllowMultipleAddressPrefixesOnSubnet --subscription <subscriptionId>
```

# Modular descriptions
In this setup, we have four modules that are being used together to create a basic small infrastructure of sorts.
All the modules do different things, and are designed to be flexible and reusable efficiently.
The modules are: key_vault, network, storage_account and virtual_machine

## key_vault
This module creates a keyvault, in addition to any keys, or secrets you may need. Both things are optional to create along side the vault, so you can create only the things you need.
This is done trhough listing all the keys you need according to the variables in the module.
It will then proceed to create all the keys configured, which can be 0 or more.
The vault_id, keys and secrets are outputted to be used by other modules.

## network
The network module creates a network in azure. You can optionally create subnets, dns servers and similar things through the variables provided.
This makes it easier and faster to create networks and subnets. The subnet id's are outputted to be used in other modules.

## storage_account
This module creates as many storage accounts with complementary storage containers as needed. 
Access keys are outputted for use in other modules.

## virtual_machine
This creates one or more linux virtual machines. You must provide lists of details, where each index is a different machine being created.
Outputs the private IP of the VMs.

# Usage
When dependancies are done, you can use the setup by going int he root folder and using the following commands when you are satisfied whith your custom configuration:
```ps
terraform init                      # initialize terraform in the configuration to install the rest of the dependencies
terraform plan -out "myplan.tfplan" # create a plan for the terraform 
terraform apply "myplan.tfplan"     # use the plan you just created, and create the infrastructure in the cloud!
```
To destroy everything again, you can run:
```ps
terraform destroy
```
This will subsequently stop the setup from draining your bank account.
