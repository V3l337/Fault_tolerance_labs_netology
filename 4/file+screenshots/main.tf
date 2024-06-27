terraform {
  required_providers {
    yandex = {
      source = "yandex-cloud/yandex"
    }
  }
  required_version = ">= 0.13"
}

provider "yandex" {
    token     = var.yandexT 
    folder_id = var.yandexIDF
    zone      = var.YaZone
}

# Создам сеть и интерфейсы

resource "yandex_vpc_network" "vpc_network" {
  name = "lab_network"
}

resource "yandex_vpc_subnet" "lab-subnet" {
  name            = "lab_subnet"
  v4_cidr_blocks  = ["10.128.100.0/28"]
  zone            = var.YaZone
  network_id      = yandex_vpc_network.vpc_network.id
}

# Создаем первую VM

resource "yandex_compute_instance" "VM" {
  count       = 2
  name        = "vm${count.index + 1}"
  hostname    = "server${count.index + 1}"
  platform_id = "standard-v1"
  zone        = var.YaZone

  resources {
    cores         = 2
    memory        = 2
    core_fraction = 20
  }

  boot_disk {
    initialize_params {
      image_id = var.IMG
      size = 30
      type = "network-hdd"
    }
  }

  network_interface {
    index     = 1
    nat       = true
    subnet_id = yandex_vpc_subnet.lab-subnet.id
  }

  metadata = {
    # foo       = "bar"
    # ssh-keys  = "v3ll:${file("C:\Users\valen\Yandex terraform\rsa_tera.pub")}"
    user-data = "${file("C:\\Users\\valen\\Yandex terraform\\cloud-conf.yaml")}"
  }
}

#Target group
resource "yandex_lb_target_group" "tagret-test" {
  name = "target-test"
 target {
    subnet_id = yandex_vpc_subnet.lab-subnet.id
    address   = yandex_compute_instance.VM[0].network_interface.0.ip_address
  }

  target {
    subnet_id = yandex_vpc_subnet.lab-subnet.id
    address   = yandex_compute_instance.VM[1].network_interface.0.ip_address
  }
}

# Load balance
resource "yandex_lb_network_load_balancer" "balance-test" {
  name = "load-balancer-test"
  deletion_protection = "false"
  listener {
    name = "my-listener"
    port = 80
    external_address_spec {
      ip_version = "ipv4"
    }
  }

  attached_target_group {
    target_group_id = yandex_lb_target_group.tagret-test.id
    healthcheck {
      name = "http"
      http_options {
        port = 80
        path = "/"
      }
    }
  }
}

