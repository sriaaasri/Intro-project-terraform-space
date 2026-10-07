variable "vpc_cidr" {
  default = "10.0.0.0/16"
}
variable "internet_cidr" {
  default = "0.0.0.0/0"

}
variable "public_subnets" {

  #Public subnets cidr blocks are defined  10.0.1.0/24 -> 10.0.5.0/24
  type = map(object({
    cidr = string
    az   = string
  }))
  default = {
    baston = {
      cidr = "10.0.1.0/24"
      az   = "ap-south-2a"
    }
    public_subnet_2 = {
      cidr = "10.0.2.0/24"
      az   = "ap-south-2b"
    }
  }
}

variable "public_routetable" {
  type = map(object({
    name = string
  }))

  default = {
    "public_RT" = {
      name = "public_RT"
    }
  }

}

variable "private_subnets" {
  #Private subnets cidr blocks are defined  10.0.6.0/24 -> 10.0.10.0/24
  # type = list(string)
  default = ["10.0.6.0/24"]
}

variable "database_subnets" {

  #Private subnets cidr blocks are defined  10.0.11.0/24 -> 10.0.15.0/24
  # type = list(string)
  type = map(object({
    cidr = string
    az   = string
  }))
  default = {
    database = {
      cidr = "10.0.11.0/24"
      az   = "ap-south-2a"
    }
    database-2 = {
      cidr = "10.0.12.0/24"
      az   = "ap-south-2b"
    }
  }
}

variable "database_route_tables" {
  type = map(object({
    name = string
  }))
  default = {

    database = {
      name = "Database-routetable"
    }
  }

}

variable "availability_zones" {
  type = map(string)
  default = {
    "zone-a" = "ap-south-2a",
    "zone-b" = "ap-south-2b",
    "zone-c" = "ap-south-2c"
  }

}

variable "secret_name" {
  default = "flask-RDS-credentials"
}

variable "ami" {
  type    = string
  default = "ami-0199ac7c9fbf9ed83"
  validation {
    condition     = length(var.ami) > 4 && substr(var.ami, 0, 4) == "ami-"
    error_message = "ami value is not valid. please check"
  }

}


