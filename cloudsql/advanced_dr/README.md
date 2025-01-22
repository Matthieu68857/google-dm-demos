# Advanced Disaster Recovery for Cloud SQL

This repository will provision two instances with a Cloud SQL primary in a first region, and a read replica on a second region.

## Required variables

Create a `terraform.tfvars` file containing the following variables:

```
project_id = "my-gcp-project"
```

## Switchover and switchback

The workflow to trigger the switchover can be found [in the documentation](https://registry.terraform.io/providers/hashicorp/google/latest/docs/guides/sql_instance_switchover#postgresql).
