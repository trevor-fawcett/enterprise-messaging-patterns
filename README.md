# Enterprise Messaging Patterns
Some experiments in enterprise messaging patterns and exploration of AWS messaging capabilities.
## Terraform
I specified my access and secret keys in a separate Terraform variables file in a parent folder to my project, so they aren't commited to source control.
Then use the following to specify the variables file when applying (as in this case) or generating a plan (swap "apply" for "plan").
````
terraform apply -var-file="../../terraform.tfvars"
````
If you want to try this project yourself, you'll need a file in the parent folder of this repository called "terraform.tfvars" with the following contents.
Simply swap out the place-holders for values pertaining to your AWS account.
````
access_key = "YOUR_AWS_ACCESS_KEY"
secret_key = "YOUR_AWS_SECRET_KEY"
````