terraform {
  required_providers {
    google = {
      source = "hashicorp/google"
      version = "3.5.0"
    }
  }
}

provider "google" {
  credentials = file("sa.json")

  project = yamldecode(file("variables.yaml")).project
  region = "us-west1"
  zone = "us-west1-b"
}

data "google_kms_secret" "dbpass" {
  crypto_key = "${yamldecode(file("variables.yaml")).project}/us-west1/infra/dbpass"
  ciphertext = "CiQAY6s22SL4ERPZyGUP53If2P2B0RY+VH5ejkaQVsZHSil88/ISQgAW6KM3UQPCc8T9uwruwSJaI/21u4sJmZdRTSBVvcLDtKZOMtqqs/eprJ65KvuVyR5R3zsAayaF165NFmwyYkYOEg=="
}

resource "random_id" "db_name_suffix" {
  byte_length = 4
}

resource "google_compute_network" "vpc_network" {
  name = "terraform-network"
}

resource "google_sql_database_instance" "main" {
  name = "main-db-${random_id.db_name_suffix.hex}"
  database_version = "POSTGRES_14"

  settings {
    tier = "db-f1-micro"
  }
}

resource "google_sql_user" "users" {
  name = "admin"
  instance = google_sql_database_instance.main.name
  host = "0.0.0.0"
  password = data.google_kms_secret.dbpass.plaintext
}
