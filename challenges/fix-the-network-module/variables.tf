variable "name" {
  description = "Name of the network. Used in the Name tag of every resource."
  type        = string

  validation {
    condition     = can(regex("^[a-z][a-z0-9-]{1,18}[a-z0-9]$", var.name))
    error_message = "name must be 3 to 20 lowercase letters, digits or hyphens, start with a letter and end with a letter or digit."
  }
}

variable "environment" {
  description = "Environment the network is for."
  type        = string

  validation {
    condition     = contains(["dev", "staging", "prod"], var.environment)
    error_message = "environment must be dev, staging or prod."
  }
}

variable "vpc_cidr" {
  description = "IPv4 CIDR block of the VPC, from /16 to /24, in a private range."
  type        = string

  validation {
    condition     = can(cidrhost(var.vpc_cidr, 0)) && can(regex("^[0-9.]+/(1[6-9]|2[0-4])$", var.vpc_cidr))
    error_message = "vpc_cidr must be an IPv4 CIDR block with a prefix length from /16 to /24, such as 10.20.0.0/16."
  }

  validation {
    condition     = can(regex("^(10\\.|172\\.(1[6-9]|2[0-9]|3[01])\\.|192\\.168\\.)", cidrhost(var.vpc_cidr, 0)))
    error_message = "vpc_cidr must be inside 10.0.0.0/8, 172.16.0.0/12 or 192.168.0.0/16."
  }
}

variable "azs" {
  description = "Availability zones to create subnets in, such as [\"eu-west-1a\", \"eu-west-1b\"]."
  type        = list(string)

  validation {
    condition     = length(var.azs) >= 2 && length(var.azs) <= 4
    error_message = "azs must list 2 to 4 availability zones."
  }

  validation {
    condition     = length(distinct(var.azs)) == length(var.azs)
    error_message = "azs must not list the same availability zone twice."
  }

  validation {
    condition     = alltrue([for az in var.azs : can(regex("^[a-z]{2}(-[a-z]+)+-[0-9]+[a-f]$", az))])
    error_message = "Each entry in azs must be an availability zone name ending in a letter from a to f, such as eu-west-1a."
  }

  validation {
    condition     = length(distinct([for az in var.azs : substr(az, 0, length(az) - 1)])) <= 1
    error_message = "All availability zones in azs must be in the same region."
  }
}

variable "tags" {
  description = "Extra tags for every resource."
  type        = map(string)
}
