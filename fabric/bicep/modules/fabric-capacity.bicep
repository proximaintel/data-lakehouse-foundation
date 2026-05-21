// Fabric Capacity - placeholder
// Note: Fabric capacity is typically provisioned via Azure Portal or PowerShell
// Bicep support for Microsoft.Fabric/capacities is limited as of 2026

param location string
param environmentName string
param skuName string = 'F2' // F2 for dev, F64 for prod
param tags object

// When Bicep support is available:
// resource fabricCapacity 'Microsoft.Fabric/capacities@2023-11-01' = {
//   name: 'fc-lakehouse-${environmentName}'
//   location: location
//   tags: tags
//   sku: { name: skuName }
//   properties: {}
// }
