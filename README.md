# Keycloak Terraform

This is a simple example how to use Terraform to initialize a keycloak instance with the Terraform config [main.tf](main.tf).

## First Steps...

First we have to start Keycloak with Docker. When Keycloak is started up, you can access the Keycloak UI on http://localhost:8080/.

````bash
docker-compose up -d
````

Initialize the Terraform config.

````bash
terraform init
````

Validate Terraform configuration.

````bash
terraform validate
````

Creates an execution plan, which gives you a preview of the changes that Terraform plans to make to your infrastructure.

````bash
terraform plan
````

Let^s execute our Terraform plan. When the plan was executed you should see our mew Realm and OpenID Connect client.

````bash
terraform apply
````

This will destroy all our object which we created with Terraform.

````bash
terraform destroy
````
