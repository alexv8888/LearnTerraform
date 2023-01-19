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
| [azurerm_subnet.PrivateSubnet](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/subnet) | resource |
| [azurerm_subnet.PublicSubnet](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/subnet) | resource |
| [azurerm_virtual_network.vnet](https://registry.terraform.io/providers/hashicorp/azurerm/latest/docs/resources/virtual_network) | resource |

## Inputs

| Name | Description | Type | Default | Required |
|------|-------------|------|---------|:--------:|
| <a name="input_address_pref_priv"></a> [address\_pref\_priv](#input\_address\_pref\_priv) | Subnet ddress prefix | `list(string)` | n/a | yes |
| <a name="input_address_pref_publ"></a> [address\_pref\_publ](#input\_address\_pref\_publ) | Subnet ddress prefix | `list(string)` | n/a | yes |
| <a name="input_address_space"></a> [address\_space](#input\_address\_space) | Network address spase | `list(string)` | n/a | yes |
| <a name="input_environment"></a> [environment](#input\_environment) | Environment to deploy (QA, PROD) | `string` | n/a | yes |
| <a name="input_location"></a> [location](#input\_location) | Location of the network | `string` | n/a | yes |
| <a name="input_rgname"></a> [rgname](#input\_rgname) | A name of a resource group | `string` | n/a | yes |
| <a name="input_vnetname"></a> [vnetname](#input\_vnetname) | Name of a virtual network | `string` | n/a | yes |

## Outputs

| Name | Description |
|------|-------------|
| <a name="output_private_subnet_id"></a> [private\_subnet\_id](#output\_private\_subnet\_id) | n/a |
| <a name="output_public_subnet_id"></a> [public\_subnet\_id](#output\_public\_subnet\_id) | n/a |
