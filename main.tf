provider "azurerm" {
  version = "2.5.0"
  features {}
}

terraform {
    backend "azurerm" {
        resource_group_name = "tf_rg_blobstore"
        storage_account_name = "tfstorageaccountjaunius"
        container_name = "tfstate"
        key = "terraform.tfstate"
    }
}

resource "azurerm_resource_group" "tf_test" {
    name = "tfmainrg"
    location = "North Europe"
}

resource "azurerm_container_group" "tfcg_test" {
    name                = "weatherapi"
    location            = azurerm_resource_group.tf_test.location
    resource_group_name = azurerm_resource_group.tf_test.name

    ip_address_type     = "public"
    dns_name_label      = "binarythistlewa"
    os_type             = "linux"

    container {
        name            = "weatherapi"
        image           = "jauniuspinelis1/weatherapi"
        cpu             = "1"
        memory          = "1"

        ports {
            port       = "80"
            protocol    = "TCP"
        }
    }
}
