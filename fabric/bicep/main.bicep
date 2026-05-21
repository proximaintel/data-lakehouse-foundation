targetScope = 'subscription'

param location string = 'eastus2'
param environmentName string = 'dev'
param tags object = {
  'managed-by': 'bicep'
  project: 'data-lakehouse'
  environment: environmentName
}

var resourceGroupName = 'rg-fabric-lakehouse-${environmentName}'

resource rg 'Microsoft.Resources/resourceGroups@2023-07-01' = {
  name: resourceGroupName
  location: location
  tags: tags
}

module storage 'modules/storage.bicep' = {
  scope: rg
  name: 'storage'
  params: {
    location: location
    environmentName: environmentName
    tags: tags
  }
}
