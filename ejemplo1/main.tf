terraform {
    required_providers {
        docker = {
            source = "terraform-providers/docker"
        }
    }
}

provider "docker" { }

resource "docker_image" "imagen-ubuntu" {
    name = "${var.nombre_imagen}:${var.version_imagen}"

}

/*
2 volumenes dentro del contenedor:
HOST
/home/ubuntu/environment/cursoTerraform     >     /cursoTerraform
/home/ubuntu/environment/ivan               >     /ivan
*/

resource "docker_container" "volumes-ubuntu" {
container_path = "/home/ubuntu/environment/cursoTerraform"
}

resource "docker_container" "contenedor-ubuntu" {
  name  = "mi_contenedor_ubuntu"
  image = docker_image.imagen-ubuntu.latest
}
