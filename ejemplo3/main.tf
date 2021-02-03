terraform {
    required_providers {
        docker = {
            #  He actualizado el repo del provider de docker
            source = "kreuzwerker/docker"
        }
    }
}

provider "docker" { }

/*
    Me estoy creando un contenedor
*/
resource "docker_container" "contenedor" {
  name  = "mi_contenedor_nginx"
  image = docker_image.imagen-nginx.latest
  ports {
    internal = 80
    external = 8085
  }
  
  provisioner "local-exec" {
      command = "echo ${self.ip_address}"
  }
}

resource "docker_image" "imagen-nginx" {
  name = "${var.nombre_imagen}:${var.version_imagen}"
}