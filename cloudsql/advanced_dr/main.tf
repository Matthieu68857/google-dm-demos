terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "~> 6.17"
    }
  }
}

provider "google" {
  project = var.project_id
  region  = "europe-west1"
  zone    = "europe-west1-c"
}

######################################################
# Cloud SQL Enterprise Plus Postgres
######################################################

resource "google_sql_database_instance" "postgres-primary" {
  name             = "postgres-demo-drp-primary"
  database_version = "POSTGRES_16"
  region           = "europe-west1"
  deletion_protection = false
  instance_type = "CLOUD_SQL_INSTANCE"
  # !!!!!!!!!!!!!!!!!!!!!!!!! #
  # STEP 2 : After the creation of both instances, add the following block to define DR replica
  replication_cluster {
    failover_dr_replica_name = "mcornillon-demo:postgres-demo-drp-replica"
  }
  settings {
    tier = "db-perf-optimized-N-2"
    disk_size = 10
    availability_type = "REGIONAL" 
    edition = "ENTERPRISE_PLUS"
    backup_configuration {
      enabled = true
      point_in_time_recovery_enabled = true
      transaction_log_retention_days = 1
      backup_retention_settings {
        retained_backups = 2
      }
    }
    ip_configuration {
      ipv4_enabled                                  = false
      private_network                               = "projects/mcornillon-demo/global/networks/default"
      enable_private_path_for_google_cloud_services = true
    }
  }
}

resource "google_sql_database_instance" "postgres-replica" {
  name             = "postgres-demo-drp-replica"
  database_version = "POSTGRES_16"
  region           = "europe-west9"
  deletion_protection = false
  master_instance_name = google_sql_database_instance.postgres-primary.name
  instance_type = "READ_REPLICA_INSTANCE"
  settings {
    tier = "db-perf-optimized-N-2"
    disk_size = 10
    availability_type = "ZONAL" 
    edition = "ENTERPRISE_PLUS"
    ip_configuration {
      ipv4_enabled                                  = false
      private_network                               = "projects/mcornillon-demo/global/networks/default"
      enable_private_path_for_google_cloud_services = true
    }
  }
  
}
