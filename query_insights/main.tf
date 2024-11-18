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

######################################################
# Cloud SQL
######################################################

resource "random_password" "password" {
  length           = 16
  special          = true
  override_special = "!#$%&*()-_=+[]{}<>:?"
}

resource "google_sql_database_instance" "postgres" {
  name             = "postgres-demo-query-insights"
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
    insights_config {
      query_insights_enabled = true
      query_string_length = 4500
      record_application_tags = true
      record_client_address = true
      query_plans_per_minute = 20
    }
    database_flags {
      name = "cloudsql.enable_pg_cron"
      value = "on"
    }
    database_flags {
      name = "cron.database_name"
      value = "cymbalshop"
    }
    database_flags {
      name = "max_worker_processes"
      value = 10
    }
    database_flags {
      name = "temp_file_limit"
      value = 10218770
    }
  }
}

resource "google_sql_database" "database" {
  name     = "cymbalshop"
  instance = google_sql_database_instance.postgres.name
  deletion_policy = "ABANDON"

  depends_on = [google_sql_database_instance.postgres]
}

resource "null_resource" "db_setup" {
  provisioner "local-exec" {
    command = <<EOT
      psql -h ${google_sql_database_instance.postgres.public_ip_address} \
           -U postgres \
           -d cymbalshop \
           -f setup.sql
    EOT

    environment = {
      PGPASSWORD = random_password.password.result
    }
  }

  depends_on = [google_sql_database.database]
}

######################################################
# Compute engine
######################################################

resource "google_compute_instance" "vm" {
  depends_on = [null_resource.db_setup]

  name         = "vm-demo-query-insights"
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

  metadata_startup_script = templatefile("setup.sh.tftpl", { ip = google_sql_database_instance.postgres.public_ip_address, password = random_password.password.result })

}