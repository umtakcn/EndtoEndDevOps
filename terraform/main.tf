provider "google" {
  project = "plucky-catfish-312519"
  credentials = file("credentials.json")
  region  = "us-central1"
  zone    = "us-central1-a"
}

resource "google_compute_instance" "master" {
  name         = "master"
  machine_type = "e2-standard-2"
  depends_on = [time_sleep.wait_15_seconds]

  tags = ["master"]

  boot_disk {
    initialize_params {
      image = "centos8-noldor"
    }
  }

  network_interface {
    network = "noldor"
    subnetwork = "noldor"
    network_ip = "10.128.10.11"
    access_config {
    }
  }
}

resource "google_compute_instance" "slave1" {
  name         = "slave1"
  machine_type = "e2-standard-2"
  depends_on = [time_sleep.wait_15_seconds]

  tags = ["slave1"]

  boot_disk {
    initialize_params {
      image = "centos8-noldor"
    }
  }

  network_interface {
    network = "noldor"
    subnetwork = "noldor"
    network_ip = "10.128.10.12"
    access_config {
    }
  }
}

resource "google_compute_instance" "slave2" {
  name         = "slave2"
  machine_type = "e2-standard-2"
  depends_on = [time_sleep.wait_15_seconds]

  tags = ["slave2"]

  boot_disk {
    initialize_params {
      image = "centos8-noldor"
    }
  }

  network_interface {
    network = "noldor"
    subnetwork = "noldor"
    network_ip = "10.128.10.13"
    access_config {
    }
  }
}

resource "google_compute_instance" "jenkins" {
  name         = "jenkins"
  machine_type = "e2-standard-2"
  depends_on = [time_sleep.wait_15_seconds]

  tags = ["jenkins"]

  boot_disk {
    initialize_params {
      image = "centos8-noldor"
    }
  }

  network_interface {
    network = "noldor"
    subnetwork = "noldor"
    network_ip = "10.128.10.14"
    access_config {
    }
  }
}

resource "google_compute_instance" "gitlab" {
  name         = "gitlab"
  machine_type = "e2-standard-2"
  depends_on = [time_sleep.wait_15_seconds]

  tags = ["gitlab"]

  boot_disk {
    initialize_params {
      image = "centos8-noldor"
    }
  }

  network_interface {
    network = "noldor"
    subnetwork = "noldor"
    network_ip = "10.128.10.15"
    access_config {
    }
  }
}

resource "google_compute_instance" "sonarqube" {
  name         = "sonarqube"
  machine_type = "e2-standard-2"
  depends_on = [time_sleep.wait_15_seconds]

  tags = ["sonarqube"]

  boot_disk {
    initialize_params {
      image = "centos8-noldor"
    }
  }

  network_interface {
    network = "noldor"
    subnetwork = "noldor"
    network_ip = "10.128.10.16"
    access_config {
    }
  }
}

resource "google_compute_instance" "nexus" {
  name         = "nexus"
  machine_type = "e2-standard-2"
  depends_on = [time_sleep.wait_15_seconds]

  tags = ["nexus"]

  boot_disk {
    initialize_params {
      image = "centos8-noldor"
    }
  }

  network_interface {
    network = "noldor"
    subnetwork = "noldor"
    network_ip = "10.128.10.17"
    access_config {
    }
  }
}

resource "time_sleep" "wait_30_seconds" {
  depends_on = [google_compute_instance.gitlab]

  create_duration = "30s"
}

resource "google_compute_instance" "ansible-controller" {
  name         = "ansible-controller"
  machine_type = "e2-small"
  depends_on = [time_sleep.wait_30_seconds]

  boot_disk {
    initialize_params {
      image = "centos8-ans-noldor"
    }
  }

  network_interface {
    network = "noldor"
    subnetwork = "noldor"
    network_ip = "10.128.10.10"
    access_config {
    }
  }
}
resource "google_compute_firewall" "application" {
  name    = "application"
  network = google_compute_network.noldor.name
  allow {
    protocol = "tcp"
    ports    = ["32000", "32100"]
  }

  target_tags = ["slave1", "slave2"]
  source_ranges = ["0.0.0.0/0"]
}

resource "google_compute_firewall" "jenkins" {
  name    = "jenkins"
  network = google_compute_network.noldor.name
  allow {
    protocol = "tcp"
    ports    = ["8080"]
  }

  target_tags = ["jenkins"]
  source_ranges = ["your-ip"]
  source_tags = ["gitlab", "sonarqube"]
}

resource "google_compute_firewall" "gitlab" {
  name    = "gitlab"
  network = google_compute_network.noldor.name
  allow {
    protocol = "tcp"
    ports    = ["80"]
  }

  target_tags = ["gitlab"]
  source_ranges = ["your-ip"]
  source_tags = ["jenkins", "master", "slave1", "slave2"]
}

resource "google_compute_firewall" "argocd" {
  name    = "argocd"
  network = google_compute_network.noldor.name
  allow {
    protocol = "tcp"
    ports    = ["32000-33000"]
  }

  target_tags = ["slave1", "slave2"]
  source_ranges = ["your-ip"]
}

resource "google_compute_firewall" "sonarqube" {
  name    = "sonarqube"
  network = google_compute_network.noldor.name
  allow {
    protocol = "tcp"
    ports    = ["9000"]
  }

  target_tags = ["sonarqube"]
  source_ranges = ["your-ip"]
  source_tags = ["jenkins"]
}

resource "google_compute_firewall" "nexus" {
  name    = "nexus"
  network = google_compute_network.noldor.name
  allow {
    protocol = "tcp"
    ports    = ["8081"]
  }

  target_tags = ["nexus"]
  source_ranges = ["your-ip"]
  source_tags = ["jenkins", "master", "slave1", "slave2"]
}

resource "google_compute_firewall" "internal" {
  name    = "internal"
  network = google_compute_network.noldor.name
  allow {
    protocol = "tcp"
    ports    = ["0-65535"]
  }

  allow {
    protocol = "udp"
    ports    = ["0-65535"]
  }

  source_ranges = ["10.128.0.0/9"]
}

resource "google_compute_firewall" "ssh" {
  name    = "ssh"
  network = google_compute_network.noldor.name
  allow {
    protocol = "tcp"
    ports    = ["22"]
  }

  source_ranges = ["0.0.0.0/0"]
}

resource "google_compute_network" "noldor" {
  name = "noldor"
  auto_create_subnetworks = "false"
}

resource "google_compute_subnetwork" "noldor" {
  name   = "noldor"
  ip_cidr_range = "10.128.0.0/20"
  region = "us-central1"
  network = google_compute_network.noldor.id
}

resource "time_sleep" "wait_15_seconds" {
  depends_on = [google_compute_subnetwork.noldor]

  create_duration = "15s"
}
