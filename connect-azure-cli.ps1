az login --service-principal --username b0a98737-1765-46a8-bb69-3b77fb70fc28 --password YFt8Q~c1_aojZDNlE5q7U5y4-mEUX36fUHpF2c6n --tenant cc9de1cc-5867-4904-80ba-7b55a098b42f

$env:ARM_TENANT_ID = "cc9de1cc-5867-4904-80ba-7b55a098b42f" 
$env:ARM_CLIENT_SECRET = "YFt8Q~c1_aojZDNlE5q7U5y4-mEUX36fUHpF2c6n"
$env:ARM_CLIENT_ID = "b0a98737-1765-46a8-bb69-3b77fb70fc28"
$env:ARM_SUBSCRIPTION_ID = "c07d12e1-5880-4a69-837d-8004c99145fc"

#{
#  "appId": "b0a98737-1765-46a8-bb69-3b77fb70fc28",
#  "displayName": "azure-cli-2024-08-21-11-52-06",
#  "password": "YFt8Q~c1_aojZDNlE5q7U5y4-mEUX36fUHpF2c6n",
#  "tenant": "cc9de1cc-5867-4904-80ba-7b55a098b42f"
#}
# az docs: https://learn.microsoft.com/en-us/cli/azure/reference-index?view=azure-cli-latest