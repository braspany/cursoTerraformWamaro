terraform {
    required_providers {
        docker = {
            source = "terraform-providers/docker"
        }
    }
}

provider "docker" { }
/*
2 volumenes dentro del contenedor:
HOST
/home/ubuntu/environment/cursoTerraform     >     /cursoTerraform
/home/ubuntu/environment/ivan               >     /ivan
*/

resource "docker_container" "contenedor-ubuntu" {
  name  = "mi_contenedor_ubuntu"
  image = docker_image.imagen-ubuntu.latest
  command = ["bash","-c","sleep 600"]
  
  dynamic "volumes" {
      for_each = var.volumenes
      content {
          volume_name = contains(keys(volumes), "volume_name") ? volumes.value["volume_name"] : null
          host_path = volumes.value["host_path"]
          container_path = volumes.value["container_path"]
      }
  }
}

resource "docker_image" "imagen-ubuntu" {
    name = "${var.nombre_imagen}:${var.version_imagen}"

}

