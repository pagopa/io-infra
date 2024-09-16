import {
  to = module.azdoa_weu.azurerm_resource_group.azdoa_rg
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-azdoa-rg"
}

import {
  to = module.azdoa_weu.module.azdoa_li_infra.azurerm_linux_virtual_machine_scale_set.this
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-azdoa-rg/providers/Microsoft.Compute/virtualMachineScaleSets/io-p-azdoa-vmss-li-infra"
}

import {
  to = module.azdoa_weu.module.azdoa_li_infra.azurerm_ssh_public_key.this_public_key
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-azdoa-rg/providers/Microsoft.Compute/sshPublicKeys/io-p-azdoa-vmss-li-infra-admin-access-key"
}

import {
  to = module.azdoa_weu.module.azdoa_loadtest_li.azurerm_linux_virtual_machine_scale_set.this
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-azdoa-rg/providers/Microsoft.Compute/virtualMachineScaleSets/io-p-azdoa-vmss-loadtest-li"
}

import {
  to = module.azdoa_weu.module.azdoa_loadtest_li.azurerm_ssh_public_key.this_public_key
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-azdoa-rg/providers/Microsoft.Compute/sshPublicKeys/io-p-azdoa-vmss-loadtest-li-admin-access-key"
}

import {
  to = module.azdoa_weu.module.azdoa_snet.azurerm_subnet.this
  id = "/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-rg-common/providers/Microsoft.Network/virtualNetworks/io-p-vnet-common/subnets/azure-devops"
}