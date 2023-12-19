terraform {
  required_providers {
    google = {
      source  = "hashicorp/google"
      version = "~> 4.0"
    }
  }
  required_version = ">= 1.2.0"
}

variable "project-id" {
  description = "Project ID (e.g. maximal-terrain-400019)"
  type        = string
}

variable "region" {
  description = "GCP Region (e.g. asia-south1)"
  type        = string
}

variable "project-name"{
  description = "Project Name (e.g. terraform-gcp)"
  type        = string
}

provider "google" {
  project = var.project-id
  region  = var.region
}

resource "google_compute_network" "vpc_network" {
  name                    = "terraform-network"
  auto_create_subnetworks = "true"
}

resource "google_compute_firewall" "allow_traffic" {
  name    = "allow-traffic"
  network = google_compute_network.vpc_network.name

  allow {
    protocol = "icmp"
  }

  allow {
    protocol = "tcp"
    ports    = ["22", "80", "443"]
  }

  source_ranges = ["0.0.0.0/0"]
}

resource "google_compute_instance" "default" {
  name         = var.project-name
  machine_type = "e2-small"
  zone         = "${var.region}-a"
  
  boot_disk {
    initialize_params {
      image = "ubuntu-os-cloud/ubuntu-2204-lts"
      size  = 20
    }
  }


  network_interface {
    network = google_compute_network.vpc_network.name

    access_config {
      // Ephemeral IP
    }
  }

  metadata_startup_script = file("${path.module}/init.sh")

  service_account {
    scopes = ["userinfo-email", "compute-ro", "storage-ro"]
  }

  tags = ["http-server", "https-server"]
}

resource "google_compute_project_metadata_item" "default" {
  key   = "ssh-keys"
  value = "admin:${file("~/.ssh/id_rsa.pub")}"
}
