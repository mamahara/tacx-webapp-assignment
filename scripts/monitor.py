import os
import json
from datetime import datetime

import requests
from azure.identity import ClientSecretCredential
from azure.mgmt.resource import ResourceManagementClient
from azure.mgmt.web import WebSiteManagementClient

##Below details are for a read only user only

AZURE_TENANT_ID = "6a6d383e-938c-4fc2-aac6-f53d87444dfa"
AZURE_CLIENT_ID = "2e304757-a16e-4c4f-9c10-250d2bef7384"
AZURE_CLIENT_SECRET = "AFF8Q~28rYQ-bhX15M_R2BhBdyzK2dLkUHpt9c60"
AZURE_SUBSCRIPTION_ID = "c78f1f7e-9942-4d7d-8c1a-346f43826710"


# Monitor Azure resources and applications deployed
def monitor():
    #
    # Create the Resource Manager Client with an Application (service principal readonly) token provider
    #
    #credentials = ServicePrincipalCredentials(
    #    client_id=AZURE_CLIENT_ID,
    #    secret=AZURE_CLIENT_SECRET,
    #    tenant=AZURE_TENANT_ID
    #)
    credentials = ClientSecretCredential(tenant_id=AZURE_TENANT_ID, client_id=AZURE_CLIENT_ID,
                                         client_secret=AZURE_CLIENT_SECRET)

    rgClient = ResourceManagementClient(credentials, AZURE_SUBSCRIPTION_ID)
    app_service_client = WebSiteManagementClient(credentials, AZURE_SUBSCRIPTION_ID)

    # List Resource Groups
    print("List Resource Groups and webapps")
    # Show the groups in formatted output
    column_width = 25
    print("Resource Group".ljust(column_width) + "Resource Type".ljust(column_width)
          + "Resource Name".ljust(column_width) + "Web Application Url".ljust(column_width)
          + "Resource Status".ljust(column_width) + "Healthcheck".ljust(column_width))
    print("-" * (column_width * 6))
    for item in rgClient.resource_groups.list():
        resource_list = rgClient.resources.list_by_resource_group(
            resource_group_name=item.name, expand="provisioningState")

        for resource in list(resource_list):
            if resource.type == "Microsoft.Web/sites":
                web_app = app_service_client.web_apps.get(resource_group_name=item.name, name=resource.name)
                app_health_check = "Not Running"
                response = requests.get("https://"+web_app.default_host_name + "/registration")
                if "Create your account" in str(response.content) and response.status_code == 200:
                    app_health_check = "Running"

                print(f"{item.name:<{column_width}}{resource.type:<{column_width}}"
                      f"{resource.name:<{column_width}}{web_app.default_host_name:<{40}}"
                      f"{str(web_app.state):<{15}}{app_health_check:<{15}}")


if __name__ == "__main__":
    monitor()
