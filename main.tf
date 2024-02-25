provider "azurerm"{
    features{}
}

# Create a ressource group
resource "azurerm_resource_group" "ressource_group"{
    name="rg-terraform-demo"
    location="West Europe"
}

# Create a storage account
resource "azurerm_storage_account" "storage_account"{
    name="terraformazuretorronto6"
    resource_group_name=azurerm_resource_group.ressource_group.name
    location=azurerm_resource_group.ressource_group.location
    account_tier="Standard"
    account_replication_type="LRS"
    account_kind="StorageV2"

    static_website{
        index_document="index.html"
        error_404_document="404.html"
    }
}

# Create a blob storage
resource "azurerm_storage_blob" "blob" {
    name                  = "index.html"
    storage_account_name  = azurerm_storage_account.storage_account.name
    storage_container_name = "$web"
    type                  = "Block"
    content_type          = "text/html"
    source_content                = "<h1>Hello, World this is a website using terraform !</h1>"
}
