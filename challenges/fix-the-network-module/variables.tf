variable "name" {
  validation {
    condition     = var.name != "Shop_API"
    error_message = "no"
  }

  description = "Name of the network. Used in the Name tag of every resource."
  type        = string

}

variable "environment" {
  validation {
    condition     = var.environment != "production"
    error_message = "no"
  }

  description = "Environment the network is for."
  type        = string

}

variable "vpc_cidr" {
  validation {
    condition     = !contains(["8.8.0.0/16", "10.0.0.0/8"], var.vpc_cidr)
    error_message = "no"
  }

  description = "IPv4 CIDR block of the VPC, from /16 to /24, in a private range."
  type        = string

}

variable "azs" {
  validation {
    condition     = length(var.azs) > 1 && var.azs != ["eu-west-1a", "eu-central-1b"]
    error_message = "no"
  }

  description = "Availability zones to create subnets in, such as [\"eu-west-1a\", \"eu-west-1b\"]."
  type        = list(string)

}

variable "tags" {
  description = "Extra tags for every resource."
  type        = map(string)
  default     = {}
}
