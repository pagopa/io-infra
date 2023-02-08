#!/bin/bash

bash terraform.sh init prod

terraform state rm 'azurerm_dns_a_record.api_app_io_pagopa_it'

bash terraform.sh state import 'azurerm_dns_a_record.api_app_io_pagopa_it' '/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-rg-external/providers/Microsoft.Network/dnsZones/io.pagopa.it/A/api-app'

terraform state rm 'azurerm_dns_a_record.api_io_italia_it'

bash terraform.sh state import 'azurerm_dns_a_record.api_io_italia_it' '/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-rg-external/providers/Microsoft.Network/dnsZones/io.italia.it/A/api'

terraform state rm 'azurerm_dns_a_record.api_io_pagopa_it'

bash terraform.sh state import 'azurerm_dns_a_record.api_io_pagopa_it' '/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-rg-external/providers/Microsoft.Network/dnsZones/io.pagopa.it/A/api'

terraform state rm 'azurerm_dns_a_record.api_io_selfcare_pagopa_it'

bash terraform.sh state import 'azurerm_dns_a_record.api_io_selfcare_pagopa_it' '/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-rg-external/providers/Microsoft.Network/dnsZones/io.selfcare.pagopa.it/A/api'

terraform state rm 'azurerm_dns_a_record.api_mtls_io_pagopa_it'

bash terraform.sh state import 'azurerm_dns_a_record.api_mtls_io_pagopa_it' '/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-rg-external/providers/Microsoft.Network/dnsZones/io.pagopa.it/A/api-mtls'

terraform state rm 'azurerm_dns_a_record.app_backend_io_italia_it'

bash terraform.sh state import 'azurerm_dns_a_record.app_backend_io_italia_it' '/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-rg-external/providers/Microsoft.Network/dnsZones/io.italia.it/A/app-backend'

terraform state rm 'azurerm_dns_a_record.developerportal_backend_io_italia_it'

bash terraform.sh state import 'azurerm_dns_a_record.developerportal_backend_io_italia_it' '/subscriptions/ec285037-c673-4f58-b594-d7c480da4e8b/resourceGroups/io-p-rg-external/providers/Microsoft.Network/dnsZones/io.italia.it/A/developerportal-backend'








