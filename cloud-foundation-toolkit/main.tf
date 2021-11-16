/*
The following is a simple terraform workflow that provisions a series of resources 
using Google's Cloud Foundation Toolkit (CFT). Resources include:
- VPC
- 3 x Subnets

The source for this module is located at:
https://github.com/terraform-google-modules/terraform-google-network

After the CFT module an additional module is specified that is locally defined.
This provisions two cloud storage buckets.
*/

//remotely defined module - part of CFT
module "vpc" {
    source  = "terraform-google-modules/network/google"
    # version = "~> 3.0"
    version = "~> 2.6"
    auto_create_subnetworks = false

    project_id   = var.project_id
    network_name = "cft-vpc"

    routing_mode = "GLOBAL"

    subnets = [
        {
            subnet_name           = "subnet-01"
            subnet_ip             = "10.10.10.0/24"
            subnet_region         = "us-west1"
        },
        {
            subnet_name           = "subnet-02"
            subnet_ip             = "10.10.11.0/24"
            subnet_region         = "us-west1"
            subnet_private_access = "true"
            subnet_flow_logs      = "true"
            description           = "This subnet has a description"
        },
        {
            subnet_name               = "subnet-03"
            subnet_ip                 = "10.10.12.0/24"
            subnet_region             = "us-west1"
            subnet_flow_logs          = "true"
            subnet_flow_logs_interval = "INTERVAL_10_MIN"
            subnet_flow_logs_sampling = 0.7
            subnet_flow_logs_metadata = "INCLUDE_ALL_METADATA"
        }
    ]
}

//locally defined module
module "data_lake" {
    source = "../modules/data_lake"
    landing_bucket_name = "cgcom-cft-asset-landing-bkt"
    processed_bucket_name = "cgcom-cft-asset-processing-bkt"
}