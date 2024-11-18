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
# Cloud SQL Enterprise Postgres
######################################################

resource "google_sql_database_instance" "postgres-primary" {
  name             = "postgres-demo-drp-primary"
  database_version = "POSTGRES_16"
  region           = "europe-west1"
  deletion_protection = false
  settings {
    tier = "db-custom-1-3840"
    disk_size = 10
    availability_type = "REGIONAL" 
    edition = "ENTERPRISE"
    backup_configuration {
      enabled = true
      point_in_time_recovery_enabled = true
      transaction_log_retention_days = 1
      backup_retention_settings {
        retained_backups = 2
      }
    }
  }
}

resource "google_sql_database_instance" "postgres-replica" {
  name             = "postgres-demo-drp-replica"
  database_version = "POSTGRES_16"
  region           = "europe-west9"
  deletion_protection = false
  master_instance_name = google_sql_database_instance.postgres-primary.name
  settings {
    tier = "db-custom-1-3840"
    disk_size = 10
    availability_type = "ZONAL" 
    edition = "ENTERPRISE"
  }
}

######################################################
# Cloud SQL Enterprise Plus MySQL with Advanced DR
######################################################

resource "google_sql_database_instance" "mysql-primary" {
  name             = "mysql-demo-drp-primary"
  database_version = "MYSQL_8_0"
  region           = "europe-west1"
  deletion_protection = false
  settings {
    tier = "db-perf-optimized-N-2"
    disk_size = 10
    availability_type = "REGIONAL" 
    edition = "ENTERPRISE_PLUS"
    data_cache_config {
        data_cache_enabled = false
    }
    backup_configuration {
      enabled = true
      binary_log_enabled = true
      transaction_log_retention_days = 1
      backup_retention_settings {
        retained_backups = 2
      }
    }
  }
}

resource "google_sql_database_instance" "mysql-replica" {
  name             = "mysql-demo-drp-replica"
  database_version = "MYSQL_8_0"
  region           = "europe-west9"
  deletion_protection = false
  master_instance_name = google_sql_database_instance.mysql-primary.name
  settings {
    tier = "db-perf-optimized-N-2"
    disk_size = 10
    availability_type = "ZONAL" 
    edition = "ENTERPRISE_PLUS"
    data_cache_config {
        data_cache_enabled = false
    }
  }
}