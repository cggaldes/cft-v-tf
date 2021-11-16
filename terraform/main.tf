/*
The following is a simple terraform workflow that provisions a series of resources 
using base resources from the Google provider. Resources include:
- VPC
- 3 x Subnets

The source for this module is located at:
https://github.com/terraform-google-modules/terraform-google-network

After the CFT module an additional module is specified that is locally defined.
This provisions two cloud storage buckets.
*/

//vpc network
resource "google_compute_network" "vpc_network" {
  name = "tf-vpc"
  project = var.project_id
  auto_create_subnetworks=false

}

//subnet
resource "google_compute_subnetwork" "subnet_01" {
  name          = "tf-subnet-01"
  ip_cidr_range = "10.20.10.0/24"
  region        = "us-west1"
  network       = google_compute_network.vpc_network.id
}

//subnet
resource "google_compute_subnetwork" "subnet_02" {
  name          = "tf-subnet-02"
  ip_cidr_range = "10.20.11.0/24"
  region        = "us-west1"
  network       = google_compute_network.vpc_network.id
  private_ip_google_access = true
}

//subnet
resource "google_compute_subnetwork" "subnet_03" {
  name          = "tf-subnet-03"
  ip_cidr_range = "10.20.12.0/24"
  region        = "us-west1"
  network       = google_compute_network.vpc_network.id
  log_config {
    aggregation_interval = "INTERVAL_10_MIN"
    flow_sampling        = 0.7
    metadata             = "INCLUDE_ALL_METADATA"
  }
}

//locally defined module
module "data_lake" {
    source = "../modules/data_lake"
    landing_bucket_name = "cgcom-tf-asset-landing-bkt"
    processed_bucket_name = "cgcom-tf-asset-processing-bkt"
}