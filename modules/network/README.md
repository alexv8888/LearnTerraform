## Requirements

No requirements.

## Providers

| Name | Version |
|------|---------|
| <a name="provider_azurerm"></a> [azurerm](#provider\_azurerm) | n/a |

## Modules

No modules.

## Resources

| Name | Type |
|------|------|
| [azurerm_subnet.subnet](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/subnet) | resource |
| [azurerm_virtual_network.vnet](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/virtual_network) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_address_pref"></a> [address\_pref](#input\_address\_pref) | Subnet ddress prefix | `list(string)` | n/a | yes |
| <a name="input_address_space"></a> [address\_space](#input\_address\_space) | Network address spase | `list(string)` | n/a | yes |
| <a name="input_environment"></a> [environment](#input\_environment) | Environment to deploy (QA, PROD) | `string` | n/a | yes |
| <a name="input_location"></a> [location](#input\_location) | Location of the network | `string` | n/a | yes |
| <a name="input_rgname"></a> [rgname](#input\_rgname) | A name of a resource group | `string` | n/a | yes |
| <a name="input_vnetname"></a> [vnetname](#input\_vnetname) | Name of a virtual network | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_subnet_id"></a> [subnet\_id](#output\_subnet\_id) | n/a |
