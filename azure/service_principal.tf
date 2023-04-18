

# Create an application
resource "azuread_application" "eso_app" {
  display_name = format("%s-%s", "eso-demo", random_id.app_bytes.hex)
}

# Create a service principal
resource "azuread_service_principal" "eso_sp" {
  application_id = azuread_application.eso_app.application_id
}

# Create a short lived password for the service principal
resource "azuread_service_principal_password" "auth" {
  service_principal_id = azuread_service_principal.eso_sp.id
  end_date_relative    = "10h"
}

# Give the SP read on the Subscription
resource "azurerm_role_assignment" "auth" {
  scope                = data.azurerm_subscription.primary.id
  role_definition_name = "Reader"
  principal_id         = azuread_service_principal.eso_sp.id
}
