####################################################
####### Resource creation for ElasticSearch ########
####################################################

resource "google_compute_instance" "vm_instance" {
  name         = var.vm_instance_1
  machine_type = var.machine_type_elasticsearch

  boot_disk {
    initialize_params {
      image = var.image
      size  = var.size
    }
  }

  network_interface {
    network = google_compute_network.default.name
    access_config {
    }
  }

  metadata_startup_script = <<SCRIPT

    sudo apt-get install wget -y
    wget -qO - https://artifacts.elastic.co/GPG-KEY-elasticsearch | sudo apt-key add -
    sudo apt-get install apt-transport-https -y
    echo "deb https://artifacts.elastic.co/packages/7.x/apt stable main" | sudo tee /etc/apt/sources.list.d/elastic-7.x.list
    echo "installing elasticsearch"
    sudo apt-get update && sudo apt-get install elasticsearch -y
    echo "checking elasticsearch..."
    sudo systemctl start elasticsearch

    SCRIPT
}

####################################################
####### Resource creation for Jenkins Server #######
####################################################

resource "google_compute_instance" "vm_instance_2" {

  name         = var.vm_instance_2
  machine_type = var.machine_type_jenkins

  tags = ["jenkins"]

  boot_disk {
    initialize_params {
      image = var.image
      size  = var.size
    }
  }

  network_interface {
    network = google_compute_network.default.name
    access_config {
    }
  }

  metadata_startup_script = <<SCRIPT

    sudo apt install openjdk-11-jdk -y
    sudo apt-get install wget -y
    wget -q -O - https://pkg.jenkins.io/debian-stable/jenkins.io.key | sudo apt-key add -
    sudo sh -c 'echo deb https://pkg.jenkins.io/debian-stable binary/ > \
        /etc/apt/sources.list.d/jenkins.list'
    sudo apt-get update
    sudo apt-get install jenkins -y

  SCRIPT

}

resource "google_compute_network" "default" {
  name = "jenkins-vpc"
}

resource "google_compute_firewall" "default" {
  name    = "jenkins-fw"
  network = google_compute_network.default.name

  allow {
    protocol = "tcp"
    ports    = ["8080", "80", "443", "22"]
  }

  source_tags   = ["jenkins"]
  source_ranges = ["0.0.0.0/0"]
}