# Overview
A comparison between GCP's Cloud Foundation Toolkit and the core GCP Terraform provider.

# Google Cloud Platform Terraform Provider
Terraform provides the concept of a Provider which is a way to configure your GCP infrastructure. It is through the definition of this provider resource that we get access to all GCP resource representations.

There exists today two google providers. The baseline is the `google` provider however if access to new and early features are made available through the `google-beta` provider:
- google
- google-beta

The Google provider is required irrespective of whether baseline terraform or Cloud Foundation Toolkit modules are used. 

The following is an example of a provider block that should be included in the root terraform module:
```
provider "google" { 
project = "my-project-id"
region = "australia-southeast1" 
}
```

# Baseline Terraform Resources
With the Google Provider in-place we can now move on with the definition of GCP resources. For example the following defines a simple Cloud Storage bucket with a minimalist configuration:

```
resource "google_storage_bucket" "auto-expire" { 
    name = "auto-expiring-bucket" 
        location = "US" 
        force_destroy = true 
        lifecycle_rule { 
            condition { 
                age = 3 
            } 
            action { 
                type = "Delete" 
            } 
        } 
}
```

These resources are the base abstraction over GCP resources themselves. In order to combine similar resources into a common pattern for the purposes of re-usability we need to define a module. 

A module is a container for multiple resources that are used together. It is a mechanism for the team to create lightweight abstractions so that they can describe the infrastructure in terms of its architecture, rather than directly in terms of physical objects.

## Reference Docs:
- https://registry.terraform.io/providers/hashicorp/google/latest/docs
- https://www.terraform.io/docs/language/modules/develop/index.html



The Terraform provider for GCP that provides the lowest level abstraction of GCP resources. 

# Cloud Foundation Toolkit Terraform Resources
As with the use of baseline resource objects once we have defined the google provider we’re ready to get started defining GCP resources. 

As these resources are the base abstraction over GCP means that modules need to be defined by the platform/infrastructure team to provide an organisation specific abstraction tier.

CFT Overview
A series of Terraform reference templates which reflect Google's best practices. This comes in the form of 45 terraform modules which are open source and available at the following locations:
https://github.com/GoogleCloudPlatform/cloud-foundation-toolkit/blob/master/docs/terraform.md
https://registry.terraform.io/providers/hashicorp/google/latest

Pros/Cons


GCP TF Provider
CFT
Supported TF Version








Recommendation



Questions for Google:
What is the cadence for CFT compatibility with Terraform version releases? E.g. 
Will this be the same as the GCP Terraform provider?


