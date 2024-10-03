variable "VPC_info" {
  type = object({
    name       = string
    cidr_block = string
  })
}

variable "subnet_public" {
  type = list(object({
    name                     = string
    subnet_cidr_block        = string
    subnet_availability_zone = string
  }))
}

variable "subnet_private" {
  type = list(object({
    name                     = string
    subnet_cidr_block        = string
    subnet_availability_zone = string
  }))
}

variable "web_security_group" {
  type = object({
    name        = string
    description = string
    inbound_rules = list(object({
      ip_protocol = string
      port        = number
      source      = string
      description = string
    }))
  })
}

variable "app_security_group" {
  type = object({
    name        = string
    description = string
    inbound_rules = list(object({
      ip_protocol = string
      port        = number
      source      = string
      description = string
    }))
  })
}

variable "db_security_group" {
  type = object({
    name        = string
    description = string
    inbound_rules = list(object({
      ip_protocol = string
      port        = number
      source      = string
      description = string
    }))
  })
}
