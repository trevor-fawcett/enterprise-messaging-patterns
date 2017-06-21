# Enterprise Messaging Patterns
Some experiments in enterprise messaging patterns and exploration of AWS messaging capabilities.
## Terraform
I specified my access and secret keys in a separate Terraform variables file in a parent folder to my project, so they aren't commited to source control.
Then use the following to specify the variables file when applying (as in this case) or generating a plan (swap "apply" for "plan").
````
terraform apply -var-file="../../terraform.tfvars"
````