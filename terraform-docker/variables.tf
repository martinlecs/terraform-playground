variable "image" {
  type = map(string)
  description = "image for container"
  default = {
    "dev" = "nodered/node-red:latest"
    "prod" = "nodered/node-red:latest-minimal"
  }
}

variable "ext_port" {
  type = map(list(number))

  validation {
    condition     = max(var.ext_port ["dev"]...) <= 65535 && min(var.ext_port["dev"]...) >= 1980
    error_message = "The external port must be in the valid port range 0 - 65535."
  }

  validation {
    condition     = max(var.ext_port ["prod"]...) < 1980 && min(var.ext_port["prod"]...) >= 1880
    error_message = "The external port must be in the valid port range 0 - 65535."
  }
}

variable "int_port" {
  type    = number
  default = 1880

  validation {
    condition     = var.int_port == 1880
    error_message = "The internal port must be 1880."
  }
}

locals {
  container_count = length(var.ext_port[terraform.workspace])
}