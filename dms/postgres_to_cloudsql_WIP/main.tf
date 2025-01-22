terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "~> 6.2"
    }
  }
}

provider "google" {
  project = var.project_id
  region  = "europe-west1"
  zone    = "europe-west1-c"
}

resource "random_password" "password" {
  length           = 16
  special          = true
  override_special = "!#$%&*()-_=+[]{}<>:?"
}

######################################################
# Compute engine
######################################################

resource "google_compute_instance" "source" {
  name         = "vm-demo-dms-source-postgres"
  machine_type  = "e2-medium"
  zone         = "europe-west1-c"

  boot_disk {
    initialize_params {
      image = "debian-cloud/debian-11"
    }
  }

  network_interface {
    network = "default"
  }

  shielded_instance_config {
    enable_secure_boot = true
  }
  allow_stopping_for_update = true

  metadata_startup_script = templatefile("setup.sh.tftpl", {password = random_password.password.result})

}

######################################################
# Cloud SQL
######################################################

resource "google_sql_database_instance" "target" {
  name             = "postgres-demo-dms-target"
  database_version = "POSTGRES_16"
  root_password    = random_password.password.result
  region           = "europe-west1"
  deletion_protection = false
  settings {
    tier = "db-custom-2-7680"
    disk_size = 10
    availability_type = "ZONAL" 
    edition = "ENTERPRISE"
    backup_configuration {
      enabled = false
      point_in_time_recovery_enabled = false
    }
    ip_configuration {
      authorized_networks {
        name = "Allow-all"
        value = "0.0.0.0/0"
      }
    }
  }
}

# resource "google_sql_database" "database" {
#   name     = "cymbalshop"
#   instance = google_sql_database_instance.target.name
#   deletion_policy = "ABANDON"

#   depends_on = [google_sql_database_instance.target]
# }

######################################################
# DMS
######################################################

resource "google_database_migration_service_connection_profile" "source" {
  location              = "europe-west1"
  connection_profile_id = "demo-source"
  display_name          = "demo-source"
  postgresql {
    host = google_compute_instance.source.network_interface.0.network_ip
    port = 5432
    username = "postgres"
    password = random_password.password.result
  }

  depends_on = [google_compute_instance.source]
}

# resource "google_database_migration_service_migration_job" "psqltopsql" {
#   location            = "europe-west1"
#   migration_job_id    = "my-migrationid"
#   display_name = "my-migrationid_display"
#   labels = {
#     foo = "bar"
#   }
#   static_ip_connectivity {
#   }
#   source          = google_database_migration_service_connection_profile.source_cp.name
#   destination     = google_database_migration_service_connection_profile.destination_cp.name
#   type            = "CONTINUOUS"
# }