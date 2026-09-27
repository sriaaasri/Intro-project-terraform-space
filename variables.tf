variable "vpc_cidr" {

    default = "10.0.0.0/16"
  
}

variable "public_subnets" {

    #Public subnets cidr blocks are defined  10.0.1.0/24 -> 10.0.5.0/24
    type = map(object({
      cidr = string
      az = string
    }))
    default = {
        subnet-1 = {
            cidr = "10.0.1.0/24"
            az = "ap-south-2a"
        }
        subnet-2 = {
            cidr = "10.0.2.0/24"
            az = "ap-south-2b"
        }

    }
  
}

variable "private_subnets" {

    #Private subnets cidr blocks are defined  10.0.6.0/24 -> 10.0.10.0/24
    # type = list(string)
    default = [ "10.0.6.0/24" ]
  
}

variable "database_subnets" {

    #Private subnets cidr blocks are defined  10.0.11.0/24 -> 10.0.15.0/24
    # type = list(string)
    type = map(object({
      cidr = string
      az = string
    }))
    default = {
        database = {
            cidr = "10.0.11.0/24"
            az = "ap-south-2a"
        }
        database-2 = {
            cidr = "10.0.12.0/24"
            az = "ap-south-2b"
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


