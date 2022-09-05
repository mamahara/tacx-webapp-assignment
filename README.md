# tacx-webapp-assignment
Introduction: This repository is to create a simple web application and deploy to azure webapps in an automated way.
  Wen application: Its a springboot web application which would be deployed into azure webapp with Java runtime with Tomcat container.
  Terraform:  Azure infrastructue for the web application would be provisioned using terraform scripts. terraform scripts are excuted in an automated way using github               actions. Any push to the terraform scripts would trigger the azure infrastructure implementation and subsequent application deployment after infra                     deployment.
  Github action workflows: This repository has 2 workflows configured for automated infrastrcuture deployment and application deployment to azure.
  Scripts:  repository has additional scripts for monitoring the webapps application endpoint and status of the server.
  
  
