# Data Management demos on Google Cloud

This repository contains several demonstrations of Google Cloud technologies around databases that can be deployed in a single `terraform apply`.

## How to use

Each folder represents a dedicated demo and is isolated from others.

In order to setup one of the demo you need to:

1. Clone that repository
2. Go into the directory containing the demo of your choice 
3. Create a file `terraform.tfvars` and add the required variables (see the `README` of the chosen demo)
4. Authenticate to Google Cloud (see [https://cloud.google.com/docs/terraform/authentication](https://cloud.google.com/docs/terraform/authentication))
5. Run `terraform init`
6. Run `terraform apply`

When you're done with the demo, delete all resources by running: `terraform destroy`