# Описание count.index и self.<object>
# https://www.terraform.io/docs/configuration/resources.html#the-count-object
# https://www.terraform.io/docs/configuration/resources.html#referring-to-instances

provider "yandex" {
  service_account_key_file = "terraform-key.json" # terraform-key.json.example
  cloud_id                 = var.cloud_id
  folder_id                = var.folder_id
  zone                     = var.zone
}

resource "yandex_compute_instance" "app" {

  count = var.instances_count
  name  = "reddit-app-${count.index}" # описание в начале
  zone  = var.instance_zone


  resources {
    cores  = 2
    memory = 2
  }

  boot_disk {
    initialize_params {
      # Указать id образа созданного в предыдущем домашнем задании
      image_id = var.image_id
    }
  }

  network_interface {
    # Указан id подсети infra-net-ru-central1-a
    subnet_id = var.subnet_id
    nat       = true
  }

  metadata = {
    ssh-keys = "ubuntu:${file(var.public_key_path)}"
  }

  connection {
    type  = "ssh"
    host  = self.network_interface.0.nat_ip_address # описание в начале
    user  = "ubuntu"
    agent = false
    # путь до приватного ключа
    private_key = file(var.private_key_path)
  }

  provisioner "file" {
    source      = "files/puma.service"
    destination = "/tmp/puma.service"
  }
  provisioner "remote-exec" {
    script = "files/deploy.sh"
  }
}
