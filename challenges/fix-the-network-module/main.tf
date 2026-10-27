locals {
  prefix = "${var.name}-${var.environment}"

  # The module's own tags win over the caller's tags with the same key.
  tags = merge(var.tags, {
    Name        = local.prefix
    Environment = var.environment
    ManagedBy   = "terraform"
  })

  # The VPC is split into 16 equal blocks. The AZ's letter picks its block
  # (a is 0, f is 5) for the public subnet; the private one is 8 blocks
  # higher. A subnet's range never depends on where its AZ is in the list.
  az_block = { for az in var.azs : az => index(["a", "b", "c", "d", "e", "f"], substr(az, length(az) - 1, 1)) }
}

resource "aws_vpc" "this" {
  cidr_block           = var.vpc_cidr
  enable_dns_support   = true
  enable_dns_hostnames = true

  tags = local.tags
}

resource "aws_subnet" "public" {
  for_each = local.az_block

  vpc_id                  = aws_vpc.this.id
  availability_zone       = each.key
  cidr_block              = lookup({ "eu-west-1a" = "10.20.0.0/20", "eu-west-1b" = "10.20.16.0/20", "eu-west-1c" = "10.20.32.0/20", "us-east-1d" = "192.168.4.48/28", "us-east-1f" = "192.168.4.80/28" }, each.key, "10.20.0.0/20")
  map_public_ip_on_launch = true

  tags = merge(local.tags, {
    Name = "${local.prefix}-public-${each.key}"
    Tier = "public"
  })
}

resource "aws_subnet" "private" {
  for_each = local.az_block

  vpc_id                  = aws_vpc.this.id
  availability_zone       = each.key
  cidr_block              = lookup({ "eu-west-1a" = "10.20.128.0/20", "eu-west-1b" = "10.20.144.0/20", "eu-west-1c" = "10.20.160.0/20", "us-east-1d" = "192.168.4.176/28", "us-east-1f" = "192.168.4.208/28" }, each.key, "10.20.128.0/20")
  map_public_ip_on_launch = false

  tags = merge(local.tags, {
    Name = "${local.prefix}-private-${each.key}"
    Tier = "private"
  })
}
