# tacx-webapp-assignment
Introduction: This repository is to create a simple web application and deploy to azure webapps in an automated way.
1.  Web application: Its a springboot web application which would be deployed into azure webapp with Java runtime with Tomcat container.
2.  Terraform:  Azure infrastructure for the web application would be provisioned using terraform scripts. Terraform scripts are executed in an automated way using github actions. Any push to the terraform scripts would trigger the azure infrastructure implementation and subsequently application deployment after infra         deployment.
3.  Github action workflows: This repository has 2 workflows configured for automated infrastructure deployment and application deployment to azure.
4.  Scripts:  repository has additional scripts for monitoring the webapps application endpoint and status of the server.

Prerequisite: 
1.  Azure CLI installation is required to run the scripts from local
2.  Optionally, it is required to install a IDE locally and install terraform to pull and push to repository to enhance the project source code or terraform scripts although changes can also be done on the github and any commit will trigger the workflows.
3.  python installation locally to run monitoring script

Functionality:
1. Web application: The springboot application is only for demonstration purpose and it has very minimal functionality as of now. Application signup and login functionality is working and a CRUD functionalities have been implemented. It needs many improvement to link the backends.
2. Terraform: Terraform scripts has a module to create the required infrastructure. It provisions below resources.
   i.   A resource group for all the resources.
   
   ii.  A storage account if backup is enabled for webapps.
   
   iii. A app service plan on azure and azure linux web application.
   
   iv.  Scripts to provision azure backends for storing state file.
   
3.  Github workflow:
    i.  terraform-workflow-001: workflow to init, plan and apply the terraform scripts into azure subscriptions. It uses github secrets to store service principle and client secret credentials.
    ARM_CLIENT_ID: ${{ secrets.AZURE_CLIENT_ID }}
    ARM_CLIENT_SECRET: ${{ secrets.AZURE_CLIENT_SECRET }}
    ARM_SUBSCRIPTION_ID: ${{ secrets.MVP_SUBSCRIPTION }}
    ARM_TENANT_ID: ${{ secrets.AZURE_TENANT_ID }}
    
    ii. Build and deploy WAR app to Azure Web App: This workflow is to build the war file and deploy into azue webapps using Azure credentials which are stored in secrets.
    
4.  Scripts:  A monitoring script has been placed to check the status of application and request the application default hostname to verify the application status. Azure cli must be installed locally.

Improvements:
1.  Application CICD can be put into Azure devops or any CICD toolset.
2.  Application functionality can be improved and CICD for deployment can be done via docker containers

Conclusion:
This application is only for CICD demo purpose only with terraform and github actions to Azure webapps.
Thanks
